{-# LANGUAGE OverloadedStrings #-}

module WebServer where

import Web.Scotty
import Data.Aeson (object, (.=))
import qualified Data.Map as Map

import CSVParser
import Aggregation
import LossParser
import LossAggregation

startServer :: IO ()
startServer = do

    -- forest cover dataset
    extent <- readFile "data/treecover_extent_2000_in_plantations__ha.csv"
    let forestRecords = parseCSV extent

    -- forest gain dataset
    gainData <- readFile "data/treecover_gain_2000_2020_by_region__ha.csv"
    let gainRecords = parseLossCSV gainData

    -- forest loss dataset
    lossData <- readFile "data/treecover_loss_by_region__ha.csv"
    let lossRecords = parseLossCSV lossData

    -- fire loss dataset
    fireData <- readFile "data/treecover_loss_from_fires_by_region__ha.csv"
    let fireRecords = parseLossCSV fireData

    -- primary forest loss dataset
    primaryData <- readFile "data/treecover_loss_in_primary_forests_2001_tropics_only__ha.csv"
    let primaryRecords = parseLossCSV primaryData

    let totalForest = totalTreeCover forestRecords
    let totalGain = totalLoss gainRecords
    let totalLossValue = totalLoss lossRecords
    let totalFireLoss = totalLoss fireRecords
    let totalPrimaryLoss = totalLoss primaryRecords

    scotty 3000 $ do

        get "/api/global" $
            json (object
                [ "forest_cover" .= totalForest
                , "forest_gain" .= totalGain
                , "forest_loss" .= totalLossValue
                , "fire_loss" .= totalFireLoss
                , "primary_forest_loss" .= totalPrimaryLoss
                ])

        get "/api/countries" $
            json (Map.toList (treeCoverByCountry forestRecords))

        get "/api/regions" $
            json (Map.toList (treeCoverByRegion forestRecords))
        
        get "/api/top-deforestation-countries" $
            json (topDeforestationCountries 10 lossRecords)
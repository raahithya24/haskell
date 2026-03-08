module LossAggregation where

import LossTypes
import qualified Data.Map as Map
import Data.List (sortBy)
import Data.Ord (comparing)

-- total forest loss
totalLoss :: [LossRecord] -> Double
totalLoss records =
    foldr (\r acc -> lossArea r + acc) 0 records
-- aggregate forest loss by country
lossByCountry :: [LossRecord] -> Map.Map String Double
lossByCountry records =
    foldr addLoss Map.empty records
  where
    addLoss r acc =
        Map.insertWith (+) (isoLoss r) (lossArea r) acc


-- top N deforestation countries
topDeforestationCountries :: Int -> [LossRecord] -> [(String, Double)]
topDeforestationCountries n records =
    take n $
    sortBy (flip (comparing snd)) $
    Map.toList (lossByCountry records)
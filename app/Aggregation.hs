module Aggregation where

import ForestTypes
import qualified Data.Map as Map
import Data.Map (Map)
import Regions

-- total tree cover in dataset
totalTreeCover :: [ForestRecord] -> Double
totalTreeCover records =
    foldr (\r acc -> treeCover2000 r + acc) 0 records


-- total land area
totalArea :: [ForestRecord] -> Double
totalArea records =
    foldr (\r acc -> area r + acc) 0 records


-- average tree cover
averageTreeCover :: [ForestRecord] -> Double
averageTreeCover records =
    totalTreeCover records / fromIntegral (length records)


-- aggregate tree cover by country
treeCoverByCountry :: [ForestRecord] -> Map String Double
treeCoverByCountry records =
    foldr addRecord Map.empty records
  where
    addRecord r acc =
        Map.insertWith (+) (iso r) (treeCover2000 r) acc
        
-- aggregate tree cover by region
treeCoverByRegion :: [ForestRecord] -> Map String Double
treeCoverByRegion records =
    foldr addRecord Map.empty records
  where
    addRecord r acc =
        case Map.lookup (iso r) countryRegion of
          Just region ->
              Map.insertWith (+) region (treeCover2000 r) acc
          Nothing -> acc      
module Regions where

import qualified Data.Map as Map
import Data.Map (Map)

-- mapping ISO country codes to regions
countryRegion :: Map String String
countryRegion = Map.fromList
  [ ("AGO","Africa"),
    ("ALB","Europe"),
    ("ARG","South America"),
    ("AUS","Oceania"),
    ("AUT","Europe"),
    ("BEL","Europe"),
    ("BRA","South America"),
    ("CAN","North America"),
    ("CHN","Asia"),
    ("IND","Asia"),
    ("USA","North America")
  ]
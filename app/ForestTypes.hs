module ForestTypes where

data ForestRecord = ForestRecord
  { iso :: String
  , treeCover2000 :: Double
  , area :: Double
  } deriving (Show)
module LossTypes where

data LossRecord = LossRecord
  { isoLoss :: String
  , lossArea :: Double
  } deriving (Show)
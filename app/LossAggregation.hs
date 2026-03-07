module LossAggregation where

import LossTypes

totalLoss :: [LossRecord] -> Double
totalLoss records =
    foldr (\r acc -> lossArea r + acc) 0 records
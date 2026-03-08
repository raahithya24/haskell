module LossParser where

import LossTypes
import Data.List.Split (splitOn)

parseLossLine :: String -> LossRecord
parseLossLine line =
    let cols = splitOn "," line
        isoCode = filter (`notElem` "\"") (cols !! 0)
        loss = read (cols !! 1) :: Double
    in LossRecord isoCode loss

parseLossCSV :: String -> [LossRecord]
parseLossCSV contents =
    map parseLossLine (tail (lines contents))
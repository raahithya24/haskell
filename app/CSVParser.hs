module CSVParser where

import ForestTypes
import Data.List.Split (splitOn)

parseLine :: String -> ForestRecord
parseLine line =
    let cols = splitOn "," line
        isoCode = filter (`notElem` "\"") (cols !! 0)
        cover = read (cols !! 1) :: Double
        areaVal = read (cols !! 2) :: Double
    in ForestRecord isoCode cover areaVal

parseCSV :: String -> [ForestRecord]
parseCSV contents =
    let rows = lines contents
        dataRows = tail rows
    in map parseLine dataRows
module Main where

import CSVParser
import Aggregation
import qualified Data.Map as Map
import WebServer

main :: IO ()
main = do
    putStrLn "Global Deforestation Analysis"

    contents <- readFile "data/treecover_extent_2000_in_plantations__ha.csv"

    let records = parseCSV contents

    putStrLn "Total records loaded:"
    print (length records)

    putStrLn "Total Tree Cover:"
    print (totalTreeCover records)

    putStrLn "Total Area:"
    print (totalArea records)

    putStrLn "Average Tree Cover:"
    print (averageTreeCover records)
    let countryStats = treeCoverByCountry records

    putStrLn "Tree cover by country (first 10):"
    print (take 10 (Map.toList countryStats))

    let regionStats = treeCoverByRegion records

    putStrLn "Tree cover by region:"
    print (Map.toList regionStats)
    let total = totalTreeCover records
    let countryStats = treeCoverByCountry records

    putStrLn "Starting server on http://localhost:3000"

    startServer total (Map.toList countryStats)
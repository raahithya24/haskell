{-# LANGUAGE OverloadedStrings #-}

module WebServer where

import Web.Scotty
import Data.Aeson (object, (.=))
import qualified Data.Map as Map

startServer :: Double -> [(String, Double)] -> IO ()
startServer total countries =
  scotty 3000 $ do

    get "/api/global" $
      json (object ["total_tree_cover" .= total])

    get "/api/countries" $
      json countries
{-# LANGUAGE OverloadedStrings #-}
module Main where

import Control.Monad.IO.Class (liftIO)
import Database.Persist
import Database.Persist.Sqlite
import Database.Persist.TH
import System.Exit (exitSuccess)

import Lib -- Import module containing CRUD

main :: IO ()
main = do
  putStrLn "Witaj w aplikacji zarządzającej bazą danych!"
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


printPerson :: Entity Person -> IO () --Print one person
printPerson (Entity personId person) =
  putStrLn $ show personId ++ ": " ++ show person

printPeople :: [Entity Person] -> IO () -- Print list of people
printPeople people = mapM_ printPerson people
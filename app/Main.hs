{-# LANGUAGE OverloadedStrings #-}
module Main where

import Control.Monad.IO.Class (liftIO)
import Database.Persist
import Database.Persist.Sqlite (runSqlite, runMigration, SqlPersistT)
import Database.Persist.TH
import System.Exit (exitSuccess)

import Lib -- Import module containing CRUD

main :: IO ()
main = do
  putStrLn "Welcome to database management system!"
  runSqlite ":memory:" $ do
    runMigration migrateAll
    liftIO $ menu


menu :: IO ()
menu = do
  liftIO $ putStrLn "Choose option:"
  liftIO $ putStrLn "1. Add Person"
  liftIO $ putStrLn "2. Show All Aeople"
  liftIO $ putStrLn "3. Update Person's Data"
  liftIO $ putStrLn "4. Delete Person"
  liftIO $ putStrLn "5. End"
  liftIO $ putStr "Your Choice: "
  option <- liftIO getLine
  case option of
    "1" -> do
      liftIO $ putStrLn "Not Yet:"
    "2" -> do
      liftIO $ putStrLn "Still to do:"
      menu


printPerson :: Entity Person -> IO () --Print one person
printPerson (Entity personId person) =
  putStrLn $ show personId ++ ": " ++ show person

printPeople :: [Entity Person] -> IO () -- Print list of people
printPeople people = mapM_ printPerson people
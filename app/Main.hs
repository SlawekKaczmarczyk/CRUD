{-# LANGUAGE OverloadedStrings #-}
module Main where

import Control.Monad.IO.Class (liftIO)
import Database.Persist
import Database.Persist.Sqlite (runSqlite, runMigration, SqlPersistT)
import Database.Persist.TH
import System.Exit (exitSuccess)

import Lib (createRecord, readRecord, updateRecord, deleteRecord, runDb)

main :: IO ()
main = do
    putStrLn "Database Management System"
    menu

menu :: IO ()
menu = do
    putStrLn "1. Create record"
    putStrLn "2. Read record"
    putStrLn "3. Update record"
    putStrLn "4. Delete record"
    putStrLn "5. Exit"
    putStrLn "Choose an option: "
    option <- getLine
    case option of
        "1" -> createRecord >> menu
        "2" -> readRecord >> menu
        "3" -> updateRecord >> menu
        "4" -> deleteRecord >> menu
        "5" -> putStrLn "Goodbye!"
        _   -> putStrLn "Invalid option. Try again." >> menu
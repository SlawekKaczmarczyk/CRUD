{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Lib
    ( createRecord
    , readRecord
    , updateRecord
    , deleteRecord
    , runDb
    ) where


import Database.Persist.Class
import Database.Persist.Sql (toSqlKey,SqlPersistT, runMigration)
import Database.Persist.Sqlite 
import Database.Persist.TH
import Control.Monad.IO.Class (liftIO)
import Control.Monad.Logger (NoLoggingT)
import Control.Monad.Trans.Resource (ResourceT)
import qualified Data.Text as T

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Record
    value String
    deriving Show
|]

-- SQLite database file
databaseFile :: T.Text
databaseFile = T.pack "database.sqlite"

-- Function to run database actions
runDb :: SqlPersistT (NoLoggingT (ResourceT IO)) a -> IO a
runDb action = runSqlite databaseFile $ do
    runMigration migrateAll
    action

createRecord :: IO ()
createRecord = do
    putStrLn "Enter value for the new record: "
    value <- getLine
    _ <- liftIO $ runDb $ insert $ Record value
    putStrLn "Record created successfully."

readRecord :: IO ()
readRecord = do
    records <- runDb $ selectList [] []
    putStrLn "Records:"
    mapM_ (\(Entity recordId record) -> putStrLn $ "ID: " ++ show recordId ++ ", Value: " ++ recordValue record) records

updateRecord :: IO ()
updateRecord = do
    putStrLn "Enter the ID of the record to update: "
    recordIdStr <- getLine
    let recordId = read recordIdStr :: Key Record
    putStrLn "Enter the new value: "
    newValue <- getLine
    _ <- liftIO $ runDb $ update recordId [RecordValue =. newValue]
    putStrLn "Record updated successfully."

deleteRecord :: IO ()
deleteRecord = do
    putStrLn "Enter the ID of the record to delete: "
    recordIdStr <- getLine
    let recordId = read recordIdStr :: Key Record
    _ <- liftIO $ runDb $ delete recordId
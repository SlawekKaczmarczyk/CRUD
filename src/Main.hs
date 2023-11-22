{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Lib where

import Database.Persist
import Database.Persist.Sqlite
import Database.Persist.TH

-- Data structure definition
share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Person
    name String
    age Int
    deriving Show
|]

initDb :: IO ()
initDb = runSqlite ":memory:" $ do
  runMigration migrateAll

-- CRUD operations

-- Adding person to database
insertPerson :: Person -> SqlPersistT IO (Key Person)
insertPerson = insert 

-- Retrieving all people from the database
getPeople :: SqlPersistT IO [Entity Person]
getPeople = selectList [] []

-- Update person's data in the database
updatePerson :: Key Person -> Person -> SqlPersistT IO ()
updatePerson personId updatedPerson = do
  update personId [PersonName =. personName updatedPerson, PersonAge =. personAge updatedPerson]

-- Delete a person from the database
detelePerson :: Key Person -> SqlPersistT IO ()
detelePerson personId = delete personId

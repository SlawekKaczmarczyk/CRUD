{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE OverloadedStrings #-}

import Database.Persist
import Database.Persist.Sqlite
import Database.Persist.TH
import Control.Monad.IO.Class (liftIO)

-- Definicja struktury danych
share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Person
    name String
    age Int
    deriving Show
|]

main :: IO ()
main = return ()
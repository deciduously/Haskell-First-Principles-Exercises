--db.hs
module Db where

import Data.Time

data DataBaseItem = DbString String
                  | DbNumber Integer 
                  | DbDate UTCTime
                  deriving (Eq, Ord, Show)

theDatabase :: [DataBaseItem]
theDatabase =
  [ DbDate (UTCTime
            (fromGregorian 1911 5 1)
    (secondsToDiffTime 34123))
  , DbNumber 9001
  , DbString "Hello, world!"
  , DbDate (UTCTime
            (fromGregorian 1921 5 1)
    (secondsToDiffTime 34123))
  ]

filterDbDate :: [DataBaseItem] -> [UTCTime]
filterDbDate = foldr grabUTC []
  where
    grabUTC (DbDate d) b = [d] ++ b
    grabUTC _ b = [] ++ b

filterDbNumber :: [DataBaseItem] -> [Integer]
filterDbNumber = foldr grabNum []
  where
    grabNum (DbNumber n) b = [n] ++ b
    grabNum _ b = [] ++ b

mostRecent :: [DataBaseItem] -> UTCTime
mostRecent = maximum.filterDbDate

sumDb :: [DataBaseItem] -> Integer
sumDb = sum.filterDbNumber

avgDb :: [DataBaseItem] -> Double
avgDb = getAvg.filterDbNumber
  where
    l = fromIntegral.length
    getAvg xs = (/ l xs).fromInteger.sum $ xs
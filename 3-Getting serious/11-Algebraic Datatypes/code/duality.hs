--duality.hs
module Duality where

data GuessWhat = Chickenbutt deriving Show

data Id a = MkId deriving Show

data Product a b = Product a b deriving Show

data Sum a b =
      First a
    | Second b
    deriving Show

data RecordProduct a b =
  RecordProduct { pfirst  :: a
                , psecond :: b }
                deriving (Eq, Show)

newtype NumCow = NumCow Int deriving (Eq, Show)

newtype NumPig = NumPig Int deriving (Eq, Show)

data Farmhouse = Farmhouse NumCow NumPig deriving (Eq, Show)

type Farmhouse' = Product NumCow NumPig --same as Farmhouse

trivialValue :: GuessWhat
trivialValue = Chickenbutt
--naturalNum.hs
module NaturalNum where

import Data.Maybe

data Nat =
    Zero
  | Succ Nat
  deriving (Eq, Show)

natToInteger :: Nat -> Integer
natToInteger Zero     = 0
natToInteger (Succ n) = succ.natToInteger $ n

integerToNat :: Integer -> Maybe Nat
integerToNat n
           | n < 0     = Nothing
           | n == 0    = Just Zero
           | otherwise = Just (Succ (fromMaybe Zero (integerToNat (n - 1))))
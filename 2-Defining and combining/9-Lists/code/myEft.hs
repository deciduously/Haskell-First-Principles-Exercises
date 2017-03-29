--myEft.hs
module MyEft where

eftBool :: Bool -> Bool -> [Bool]
eftBool a b
      | a         = a : []  
      | otherwise = a : eftBool (succ a) b

eftOrd :: Ordering -> Ordering -> [Ordering]
eftOrd a b
     | a > b     = []
     | a == GT   = a : []
     | otherwise = a : eftOrd (succ a) b

eftInt :: Int -> Int -> [Int]
eftInt a b
     | a > b     = []
     | a == b    = a : []
     | otherwise = a : eftInt (succ a) b

eftChar :: Char -> Char -> [Char]
eftChar a b
      | a > b     = []
      | a == b    = a : []
      | otherwise = a : eftChar (succ a) b
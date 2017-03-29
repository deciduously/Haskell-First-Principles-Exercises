--numbersWords.hs
module NumbersWords where

import Data.List (intersperse)

digitToWord :: Int -> String
digitToWord n 
          | n < 0  = "negative"
          | n == 0 = "zero"
          | n == 1 = "one"
          | n == 2 = "two"
          | n == 3 = "three"
          | n == 4 = "four"
          | n == 5 = "five"
          | n == 6 = "six"
          | n == 7 = "seven"
          | n == 8 = "eight"
          | n == 9 = "nine"

digits :: Int -> [Int]
digits n
     | n < 0 = (-1 :: Int) : (digits $ abs n) -- this is hacky but at least it doesn't crash 
     | n < 10 = n : []
     | otherwise = snd x : digits (fst x) where x = divMod n 10

wordNumber :: Int -> String
wordNumber = concat . intersperse "-" . map digitToWord . reverse . digits
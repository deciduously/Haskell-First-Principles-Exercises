--symmetry
module Symmetry where

myWords :: String -> [String]
myWords n
      | n == ""   = []
      | otherwise = firstWord : myWords $ dropWhile (/= ' ') $ tail n
      where
        firstWord = if head n == ' ' then
                       takeWhile (/= ' ') $ tail n else
                       takeWhile (/= ' ') n
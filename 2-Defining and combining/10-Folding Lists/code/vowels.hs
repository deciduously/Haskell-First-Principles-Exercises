--vowels.hs
module Vowels where

import Data.List

stops = "pbtdkg"
vowels = "aeiou"

--put the middle value first
makeABA :: (Eq a, Eq b) => [b] -> [a] -> [(a,b,a)]
makeABA b a = nub.concat $ [ getTuples x y z | x <- b, y <- a, z <- a, y /= z]
  where
    getTuples x y z = [(y, x, z), (z, x, y)]

allCombosLetters :: String -> String -> [(Char, Char, Char)]
allCombosLetters = makeABA

justP :: String -> String -> [(Char, Char, Char)]
justP v s = filter startsWithP (allCombosLetters v s)
  where
    startsWithP ('p', _, _) = True
    startsWithP _           = False

nouns = ["Rodney", "house", "billiards", "18-wheeler", "George", "canasta", "gooseberry pie"]
verbs = ["ruins", "destroys", "drives", "eats", "rides", "plays"]

allComboWords :: [String] -> [String] -> [(String, String, String)]
allComboWords = makeABA

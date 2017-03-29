--charEx.hs
module CharEx where

import Data.Char

onlyCaps :: String -> String
onlyCaps = filter isUpper

capitalize :: String -> String
capitalize n = (:tail n) . toUpper . head $ n

allCaps :: String -> String
allCaps "" = []
allCaps (c:cs) = toUpper c : allCaps cs

onlyFirstUpper :: String -> Char
onlyFirstUpper = Maybe $ head . capitalize
--ciphers.hs
module Ciphers where

import Data.Char

abcLen :: Int
abcLen = length ['a'..'z']

letterToInt :: Char -> Int
letterToInt c = fromIntegral $ ord c - ord 'a'

intToLetter :: Int -> Char
intToLetter n = chr $ ord 'a' + n

shiftN :: Char -> Int -> Char
shiftN c n
     | not $ isAlpha c = c
     | otherwise = intToLetter.(`mod` abcLen).(+n).letterToInt.toLower $ c

caesar :: String -> Int -> String
caesar p n = [ shiftN c n | c <- p ]

unCaesar :: String -> Int -> String
unCaesar s n = caesar s (abcLen - n)

--TODO this doesn't preserve spaces
vigenere :: String -> String -> String
vigenere p k = zipWith shiftN (concat $ words p) keyVals
    where
        keyVals = [ letterToInt x | x <- take (length p) $ cycle k ] 
        
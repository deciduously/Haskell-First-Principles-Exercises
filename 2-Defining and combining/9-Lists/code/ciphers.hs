--ciphers.hs
module Ciphers where

import Data.Char

abcLen :: Int
abcLen = length ['a'..'z']

caesar :: String -> Int -> String
caesar s n = [ shift n c | c <- s ]
    where
      a = ord 'a'
      shift n c
          | not $ isAlphaNum c = c 
          | otherwise          = chr.(+a).(`mod` abcLen).(+n).(+(negate a)).ord.toLower $ c

unCaesar :: String -> Int -> String
unCaesar s n = caesar s (abcLen - n)
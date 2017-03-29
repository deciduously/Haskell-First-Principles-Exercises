module Manip where

addBang :: String -> String
addBang s = s ++ "!"

letterIndex :: Int -> Char
letterIndex x = (!!) "Curry is awesome!" x

rvrs :: String -> String
rvrs x = drop 9 x ++ take 4 (drop 5 x) ++ take 5 x

dropNine :: String -> String
dropNine = drop 9
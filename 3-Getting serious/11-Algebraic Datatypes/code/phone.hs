--phone.hs
module Phone where

import Data.Bool
import Data.Char
import Data.List

type Phone = [Key]
type Digit = Char
type Presses = Int
data Key = Key Digit String deriving (Eq, Show)

phone :: Phone
phone = [ Key '1' "1"
        , Key '2' "ABC2"
        , Key '3' "DEF3"
        , Key '4' "GHI4"
        , Key '5' "JKL5"
        , Key '6' "MNO6"
        , Key '7' "PQRS7"
        , Key '8' "TUV8"
        , Key '9' "WXYZ9"
        , Key '0' " 0"
        , Key '*' "^"
        , Key '#' "./#"
        ]

convo :: [String]
convo =
  [ "Wanna play 20 questions"
  , "Ya"
  , "U 1st haha"
  , "Lol ok.  Have u ever tasted alcohol lol"
  , "Lol ya"
  , "Wow ur cool haha.  Ur turn."
  , "Ok. Do you think I am pretty Lol"
  , "Lol ya"
  , "Haha thanks just making sure rofl your turn"
  ]

freqFold ::  [a] -> (a, Int) -> (a, Int)
freqFold a b = if length a > snd b
               then (head a, length a)
               else b

getDigit :: Key -> Digit
getDigit (Key d _) = d

getPresses :: Char -> Key -> Presses
getPresses c (Key _ l) = case elemIndex (toUpper c) l of
                          Just n -> n + 1
                          Nothing -> 0

reverseTaps :: Phone -> Char -> [(Digit, Presses)]
reverseTaps p c = if isUpper c
                   then [(getDigit getKey, getPresses c getKey)]
                   else [('*', 1), (getDigit getKey, getPresses c getKey)]
  where
    getKey = head $ filter (\(Key _ l) -> elem (toUpper c) l) p -- TODO head is a ⊥ waiting to happen

fullString :: Phone -> String -> [(Digit, Presses)]
fullString p s = concatMap (reverseTaps p) s

fingerTaps :: [(Digit, Presses)] -> Presses
fingerTaps = foldr ((+).snd) 0

mostPopularLetter :: String -> Char
mostPopularLetter s = fst $ foldr freqFold (' ', 0 :: Int) (group s)

mostPopularWord :: String -> String
mostPopularWord s = fst $ foldr freqFold ("", 0 :: Int) (group $ words s)

coolestLetter :: [String] -> Char
coolestLetter = mostPopularLetter . unwords

coolestWord :: [String] -> String
coolestWord = mostPopularWord . unwords
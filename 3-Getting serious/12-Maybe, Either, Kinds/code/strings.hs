--strings.hs
module Strings where

import Data.Bool
import Data.List
import Data.Maybe

vowels :: String
vowels = "aeiou"

notThe :: String -> Maybe String
notThe s
     | elem s ["The", "the"] = Nothing
     | otherwise           = Just s

replaceThe :: String -> String
replaceThe = unwords . map (fromMaybe "a".notThe) . words

countBeforeVowel :: String -> Integer
countBeforeVowel p = foldr theBeforeV 0 (zip (words p) (tail.words $ p)) --apparently zip <*> tail is a thing too
  where
    theBeforeV a b = bool b (succ b) (elem (head.snd $ a) vowels && (flip elem ["The", "the"].fst $ a))

countVowels :: String -> Int
countVowels = length.filter (flip elem vowels)

newtype Word' =
  Word' String deriving (Eq, Show)

mkWord :: String -> Maybe Word'
mkWord s =
  let
    numVowels = countVowels s
  in
    bool (Just (Word' s)) Nothing (numVowels > (length s - numVowels))
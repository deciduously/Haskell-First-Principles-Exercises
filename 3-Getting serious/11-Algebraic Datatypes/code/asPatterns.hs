--asPatterns.hs
module AsPatterns where

import Data.Bool
import Data.Char
import Data.List

myChunks :: String -> Char -> [String]
myChunks n c
      | n == ""   = []
      | otherwise = firstChunk : myChunks (dropWhile (/= c) $ tail n) c
      where
        firstChunk = if head n == c then
                       takeWhile (/= c) $ tail n else
                       takeWhile (/= c) n

isSubSequenceOf :: (Eq a) => [a] -> [a] -> Bool
isSubSequenceOf x y = foldr ((&&).(flip elem) y) True x -- you didnt even use the as-pattern, dingus

capitalizeWords :: String -> [(String, String)]
capitalizeWords s = map (\s@(c:cs) -> (s, toUpper c : cs)) (words s)

capitalizeWord :: String -> String
capitalizeWord "" = ""
capitalizeWord (' ':xs) = capitalizeWord xs
capitalizeWord s@(c:cs) = toUpper c : cs

capitalizeParagraph :: String -> String
capitalizeParagraph []     = []
capitalizeParagraph p = reverse.tail.reverse.concat.intersperse ". " $ map capSentence (sentences p)
  where
    sentences s = map dropInitialSpaces (myChunks s '.')
      where dropInitialSpaces s
                            | s == []       = []
                            | otherwise     = dropWhile (== ' ') s

    capSentence [] = []
    capSentence s  = capitalizeWord (takeWhile (/= ' ') s) ++ drop (length (takeWhile (/= ' ') s)) s
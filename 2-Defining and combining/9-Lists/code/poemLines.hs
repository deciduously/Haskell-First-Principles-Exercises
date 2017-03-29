--poemLines.hs
module PoemLines where

firstSen = "Tyger Tyger, burning bright\n"
secondSen = "In the forests of the night\n"
thirdSen = "What immortal hand or eye\n"
fourthSen = "Could frame thy fearful symmetry?"
sentences = firstSen ++ secondSen ++ thirdSen ++ fourthSen

myLines :: String -> [String]
myLines n
      | n == ""   = []
      | otherwise = firstLine : (myLines $ dropWhile (/= '\n') $ tail n)
      where
        firstLine = if head n == '\n' then
                       takeWhile (/= '\n') $ tail n else
                       takeWhile (/= '\n') n

shouldEqual :: [String]
shouldEqual =
  [ "Tyger Tyger, burning bright"
  , "In the forests of the night"
  , "What immortal hand or eye"
  , "Could frame thy fearful symmetry?"
  ]

myChunks :: String -> Char -> [String]
myChunks n c
      | n == ""   = []
      | otherwise = firstChunk : myChunks (dropWhile (/= c) $ tail n) c
      where
        firstChunk = if head n == c then
                       takeWhile (/= c) $ tail n else
                       takeWhile (/= c) n

main :: IO ()
main = 
  print $ "Are they equal?" ++ show (myChunks sentences '\n' == shouldEqual)
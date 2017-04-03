--ciphers.hs
module Ciphers where

import Control.Monad (forever)
import Data.Char
import Data.Maybe
import Data.List
import Data.String
import System.Exit (exitSuccess)

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

intFromString :: String -> Maybe Int
intFromString s
            | all isNumber s = Just (getInt s)
            | otherwise      = Nothing
  where
    getInt s = foldr placeValue 0 s
        where
            placeValue a = (+) ((digitToInt a) * 10 ^ (length s - (fromMaybe 0 (elemIndex a s)) - 1))

getStringInt :: IO (String, Int)
getStringInt = forever $ do
    putStr "Plaintext: "
    p <- getLine
    putStr "Rotate: "
    n <- getLine
    let n' = intFromString n
    case n' of
        Nothing -> return ("", 0)
        Just x  -> return (p, x)

getStringString :: IO (String, String)
getStringString = do
    putStr "Plaintext: "
    p <- getLine
    putStr "Key: "
    k <- getLine
    return (p,k)

main :: IO ()
main = forever $ do
    putStr "[c]aesar, [u]ncaesar,  [v]igenere, or [q]uit: "
    cipher <- getLine
    case cipher of
        "c" -> do
           input <- getStringInt
           putStrLn $ uncurry caesar input
        "u" -> do
           input <- getStringInt
           putStrLn $ uncurry unCaesar input
        "v" -> do
           input <- getStringString
           putStrLn $ uncurry vigenere input
        "q" -> exitSuccess
        _   -> putStrLn "Come on, those are clear instructions"
        
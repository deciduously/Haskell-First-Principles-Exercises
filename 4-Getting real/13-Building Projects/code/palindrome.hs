--palindrome.hs
module Palindrome where

import Control.Monad
import Data.Char (isAlpha, toLower)
import System.Exit (exitSuccess)

isPalindrome :: String -> Bool
isPalindrome s = squished == reverse squished
  where
    squished = map toLower.filter isAlpha $ s

palindrome :: IO ()
palindrome = forever $ do
  line1 <- getLine
  case isPalindrome line1 of
    True -> putStrLn "Palindrome!"
    False -> do
      putStrLn "Not a palindrome!"
      exitSuccess
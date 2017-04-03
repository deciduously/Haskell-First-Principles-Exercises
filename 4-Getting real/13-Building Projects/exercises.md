### Intermission
#### Check Understanding
1. `forever` and `when`
2. `Data.Bits` and `Database.Blacktip.Types`
3. Types defined for the package
4. ` Control.Concurrent.Mvar`, `Filesystem.Path.CurrentOS`, and `Control.Concurrent`
5. `Filesystem.writeFile`
6. `Control.Monad`
### Chapter Exercises
#### Complete Hangman
```haskell
module Main where

import Control.Monad (forever)
import Data.Char (toLower)
import Data.Maybe (fromMaybe, isJust)
import Data.List (intersperse)
import System.Exit (exitSuccess)
import System.Random (randomRIO)

newtype WordList =
  WordList [String]
  deriving (Eq, Show)

minWordLength :: Int
minWordLength = 5

maxWordLength :: Int
maxWordLength = 9

allWords :: IO WordList
allWords = do
  dict <- readFile ("data/dict.txt")
  return $ WordList (lines dict)

gameWords :: IO WordList
gameWords = do
  (WordList aw) <- allWords
  return $ WordList (filter gameLength aw)
  where gameLength w =
          let l = length (w :: String)
          in l > minWordLength && l < maxWordLength

randomWord :: WordList -> IO String
randomWord (WordList wl) = do
  randomIndex <- randomRIO (0, length wl - 1 )
  return $ wl !! randomIndex

randomWord' :: IO String
randomWord' = gameWords >>= randomWord

data Puzzle = Puzzle String [Maybe Char] [Char]

instance Show Puzzle where
  show (Puzzle _ discovered guessed) =
    (intersperse ' ' $ fmap renderPuzzleChar discovered)
    ++ " Guessed so far: " ++ guessed

freshPuzzle :: String -> Puzzle
freshPuzzle s = Puzzle s (map (const Nothing) s) []

charInWord :: Puzzle -> Char -> Bool
charInWord (Puzzle s _ _) = flip elem s

alreadyGuessed :: Puzzle -> Char -> Bool
alreadyGuessed (Puzzle _ filledInSoFar g) c = elem c g || foldr isGuessed False filledInSoFar
  where isGuessed a = (||) (c == fromMaybe ' ' a)

renderPuzzleChar :: Maybe Char -> Char
renderPuzzleChar Nothing  = '_'
renderPuzzleChar (Just c) = c

fillInCharacter :: Puzzle -> Char -> Puzzle
fillInCharacter p@(Puzzle word filledInSoFar s) c =
  if charInWord p c
   then Puzzle word newFilledInSoFar (s)
   else Puzzle word newFilledInSoFar (c : s)
    where zipper guessed wordChar guessChar =
            if wordChar == guessed
            then Just wordChar
            else guessChar
          
          newFilledInSoFar =
            zipWith (zipper c) word filledInSoFar

handleGuess :: Puzzle -> Char -> IO Puzzle
handleGuess puzzle guess = do
  putStrLn $ "You guessed: " ++ [guess]
  case (charInWord puzzle guess
      , alreadyGuessed puzzle guess) of
        (_, True) -> do
          putStrLn "You already guessed that character,\
                    \  you dingus.  pick something else!"
          return puzzle
        (True, _) -> do
          putStrLn "Congration!  You done it!"
          return (fillInCharacter puzzle guess)
        (False, _) -> do
          putStrLn "Nope.  You're awful at this"
          return (fillInCharacter puzzle guess)

gameOver :: Puzzle -> IO ()
gameOver (Puzzle wordToGuess _ guessedWrong) =
  if (length guessedWrong) > 7 then
    do putStrLn "You lose!"
       putStrLn $ "The word obviously was: " ++ wordToGuess
       exitSuccess
  else return ()

gameWin :: Puzzle -> IO ()
gameWin (Puzzle _ filledInSoFar _) =
  if all isJust filledInSoFar then
    do putStrLn "You win!"
       exitSuccess
  else return ()

runGame :: Puzzle -> IO ()
runGame puzzle = forever $ do
  gameOver puzzle
  gameWin puzzle
  putStrLn $ "Current puzzle is: " ++ show puzzle
  putStr "Guess a letter: "
  guess <- getLine
  case guess of
    [c] -> handleGuess puzzle c >>= runGame
    _   -> putStrLn "Your guess must be a single character!"

main :: IO ()
main = do
  word <- randomWord'
  let puzzle = freshPuzzle (fmap toLower word)
  runGame puzzle
```
#### Adding User Input to Ciphers
```haskell
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
```
#### Palindrome
```haskell
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
```
#### gimmePerson
```haskell
gimmePerson :: IO ()
gimmePerson = do
  putStr "Name: "
  name <- getLine
  putStr "Age: "
  age <- getLine
  let result = mkPerson name (read age) in
    case result of
      Right p -> putStrLn $ "Yay! " ++ show p
      Left p -> putStrLn $ "Oh No! " ++ show p
```
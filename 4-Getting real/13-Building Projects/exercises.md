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
(Full code)[https://github.com/deciduously/Haskell-First-Principles-Exercises/tree/master/4-Getting%20real/13-Building%20Projects/code/hangman]
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
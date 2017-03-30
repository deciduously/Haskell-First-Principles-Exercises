#### Understanding Folds
```haskell
1. 
b & c, (*) is commutative

2.
foldl (flip (*)) 1 [1..3]
((([] * 1) * 2) * 3)
(((1*1)*2)*3)
((1*2)*3)
(2*3)
6

3. c

4. a

5.
  a. foldr (++) [] ["woot", "WOOT", "woot"] -- add second argument

  b. foldr max 'a' "fear is the little death" -- change [] to 'a'

  c. foldr (&&) True [False, True] -- change and to (&&)

  d. foldr (||) False [False, False] -- change True to False

  e. foldl (flip ((++).show)) [] [1..5] -- add flip

  f. foldr const 0 [1..5] -- 'a' to 0

  g. foldr const 'a' "tacos" -- 0 to 'a' 

  h. foldl (flip const) 'a' "burritos"  -- add quotes

  i. foldl (flip const) 0 [1..5] -- 'a' to 0
```
#### Database Processing
```haskell
1.
filterDbDate :: [DataBaseItem] -> [UTCTime]
filterDbDate = foldr grabUTC []
  where
    grabUTC (DbDate d) b = [d] ++ b
    grabUTC _ b = [] ++ b

2.
filterDbNumber :: [DataBaseItem] -> [Integer]
filterDbNumber = foldr grabNum []
  where
    grabNum (DbNumber n) b = [n] ++ b
    grabNum _ b = [] ++ b

3.
mostRecent :: [DataBaseItem] -> UTCTime
mostRecent = maximum.filterDbDate

4.
sumDb :: [DataBaseItem] -> Integer
sumDb = sum.filterDbNumber

5.
avgDb :: [DataBaseItem] -> Double
avgDb = getAvg.filterDbNumber
  where
    l = fromIntegral.length
    getAvg xs = (/ l xs).fromInteger.sum $ xs
```
#### Scans
```haskell
1.
fibs = 1 : scanl (+) 1 fibs
fibsToN n = take n $ fibs

2.
smallFibs = takeWhile (< 100) fibs

3.
factorialScan n = scanl (*) 1 [1..n]
```
### Chapter Exercises
#### Warm-up/Review
```haskell
1.
stops = "pbtdkg"
vowels = "aeiou"

--This general helper answers both 1 and 3
--put the middle value first
--This is inefficient because it generates dupliates and then sorts them out
--Call it a TODO :-)
makeABA :: (Eq a, Eq b) => [b] -> [a] -> [(a,b,a)]
makeABA b a = nub.concat $ [ getTuples x y z | x <- b, y <- a, z <- a, y /= z]
  where
    getTuples x y z = [(y, x, z), (z, x, y)]

a.
allCombosLetters :: String -> String -> [(Char, Char, Char)]
allCombosLetters = allCombos 

b.
justP :: String -> String -> [(Char, Char, Char)]
justP v s = filter startsWithP (allCombos v s)
  where
    startsWithP ('p', _, _) = True
    startsWithP _           = False

c.
nouns = ["Rodney", "house", "billiards", "18-wheeler", "George", "canasta", "gooseberry pie"]
verbs = ["ruins", "destroys", "drives", "eats", "rides", "plays"]

allCombosWords :: [String] -> [String] -> [(String, String, String)]
allCombosWords = allCombos

2. Gets the average word length in a String

3.
(/) (fromIntegral (sum (map length (words x)))) (fromIntegral (length (words x)))
```
#### Rewriting standard functions using folds
```haskell
--to avoid importing Data.Bool
bool :: a -> a -> Bool -> a
bool x y b
   | b         = x
   | otherwise = y

myOr :: [Bool] -> Bool
myOr = foldr (||) False

myAny :: (a -> Bool) -> [a] -> Bool
myAny = flip foldr False . ((||) .)

myElem :: Eq a => a -> [a] -> Bool
myElem = flip foldr False . ((||) .) . (==)

myElem' :: Eq a => a -> [a] -> Bool
myElem' = myAny.(==)

myReverse :: [a] -> [a]
myReverse = foldl (flip (:)) []

myMap :: (a -> b) -> [a] -> [b]
myMap = flip foldr [] . ((:) .)

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter f = foldr (\a -> (++) (bool [a] [] (f a))) []

squish :: [[a]] -> [a]
squish = foldr (++) []

squishMap :: (a -> [b]) -> [a] -> [b]
squishMap = flip foldr [] . ((++) .)

squishAgain :: [[a]] -> [a]
squishAgain = squishMap (\(x:xs) -> x:xs)

myMaximumBy :: (a -> a -> Ordering) -> [a] -> Maybe a
myMaximumBy _ []     = Nothing
myMaximumBy f (x:xs) = Just $ foldl (\a b -> bool a b (f a b == GT)) x xs

myMinimumBy :: (a -> a -> Ordering) -> [a] -> Maybe a
myMinimumBy _ []     = Nothing
myMinimumBy f (x:xs) = Just $ foldl (\a b -> bool a b (f a b == LT)) x xs
```
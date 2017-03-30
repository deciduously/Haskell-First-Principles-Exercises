#### EnumFromTo
```haskell
eftBool :: Bool -> Bool -> [Bool]
eftBool a b
      | a         = a : []  
      | otherwise = a : eftBool (succ a) b

eftOrd :: Ordering -> Ordering -> [Ordering]
eftOrd a b
     | a > b     = []
     | a == GT   = a : []
     | otherwise = a : eftOrd (succ a) b

eftInt :: Int -> Int -> [Int]
eftInt a b
     | a > b     = []
     | a == b    = a : []
     | otherwise = a : eftInt (succ a) b

eftChar :: Char -> Char -> [Char]
eftChar a b
      | a > b     = []
      | a == b    = a : []
      | otherwise = a : eftChar (succ a) b
```
#### Thy Fearful Symmetry
```haskell
1.
myWords :: String -> [String]
myWords n
      | n == ""   = []
      | otherwise = firstWord : (myWords $ dropWhile (/= ' ') $ tail n)
      where
        firstWord = if head n == ' ' then
                       takeWhile (/= ' ') $ tail n else
                       takeWhile (/= ' ') n

2.
myLines :: String -> [String]
myLines n
      | n == ""   = []
      | otherwise = firstLine : (myLines $ dropWhile (/= '\n') $ tail n)
      where
        firstLine = if head n == '\n' then
                       takeWhile (/= '\n') $ tail n else
                       takeWhile (/= '\n') n
3.
myChunks :: String -> Char -> [String]
myChunks n c
      | n == ""   = []
      | otherwise = firstChunk : myChunks (dropWhile (/= c) $ tail n) c
      where
        firstChunk = if head n == c then
                       takeWhile (/= c) $ tail n else
                       takeWhile (/= c) n
```
#### Comprehend Thy Lists
```haskell
mySqr = [x^2 | x <- [1..5]]

1.
[ x | x <- mySqr, rem x 2 == 0]
[4, 16]

2.
[(x, y) | x <- mySqr, y <- mySqr, x < 50, y > 50 ]
[]

3. 
take 5 [(x, y) | x <- mySqr, y <- mySqr, x < 50, y > 50]
[]
```
#### Square Cube
```haskell
--implementations elided
mySqr :: (Num t, Enum t) => [t]
myCube :: (Num t, Enum t) => [t]

1.
[(x,y) | x <- mySqr, y <- myCube ]

2.
[(x,y) | x <- mySqr, y <- myCube, x < 50, y < 50 ]

3.
length [(x,y) | x <- mySqr, y <- myCube, x < 50, y < 50 ] --15
```
#### Will it blow up
###### Will it return a value or ⊥?
```haskell
1. ⊥

2.
[1] :: (Enum a, Num a) => [a]

3. ⊥

4.
3 :: Int

5. ⊥

6.
[2] :: Integral a => [a]

7. ⊥

8.
[1] :: Integral a => [a]

9.
[1,3] :: Integral a => [a]

10. ⊥
```
#### Intermission: Is It Normal Form?
1. NF
2. WHNF
3. neither
4. neither
5. neither
6. neither 
7. WHNF
#### More Bottoms
```haskell
1. ⊥

2.
[2] :: Num a => [a]

3. ⊥

4. Return a [Bool] with True for each vowel otherwise False

 --                   [a]                       [b]           [c]
5. [[1, 4, 9, 16, 25, 36, 49, 64, 81, 100], [1, 10, 20], [15, 15, 15]]

6. 
mapBool = map (\x -> let b = x == 3 in bool x (-3) b)
```
#### Filtering
```haskell
1.
mult3 :: Integral a => [a]
mult3 = filter (\x -> x `rem` 3 == 0) [1..30]

2.
lengthMult :: Int
lengthMult = length . filter (\x -> x `rem` 3 == 0) $ [1..30]

3.
myFilter :: String -> [String]
myFilter = filter (\x -> not $ elem x ["the", "a", "an"]) . words
```
#### Zipping Exercises
```haskell
1.
myZip :: [a] -> [b] -> [(a, b)]
myZip [] _ = []
myZip _ [] = []
myZip (x:xs) (y:ys) = (x,y) : myZip xs ys

2.
myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith _ [] _          = []
myZipWith _ _ []          = []
myZipWith f (x:xs) (y:ys) = f x y : myZipWith f xs 

3.
myZipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith' _ [] _          = []
myZipWith' _ _ []          = []
myZipWith' f x y = map (\(x, y) -> f x y) $ myZip x y
```
### Chapter Exercises
#### Data.Char
```haskell
1.
isUpper :: Char -> Bool
toUpper :: Char -> Char

2.
onlyCaps :: String -> String
onlyCaps = filter isUpper

3.
capitalize :: String -> String
capitalize n = (:tail n) . toUpper . head $ n

4.
allCaps :: String -> String
allCaps "" = []
allCaps (c:cs) = toUpper c : allCaps cs

5.
onlyFirstUpper :: String -> Char
onlyFirstUpper = Maybe $ head . capitalize

6. as is
```
#### Ciphers
```haskell
import Data.Char

abcLen :: Int
abcLen = length ['a'..'z']

caesar :: String -> Int -> String
caesar s n = [ shift n c | c <- s ]
    where
      a = ord 'a'
      shift n c
          | not $ isAlphaNum c = c 
          | otherwise          = chr.(+a).(`mod` abcLen).(+n).(+(negate a)).ord.toLower $ c

unCaesar :: String -> Int -> String
unCaesar s n = caesar s (abcLen - n)
```
#### Writing Standard Functions
```haskell
1.
myOr :: [Bool] -> Bool
myOr []     = True
myOr (x:xs) = x || myOr xs

2.
myAny :: (a -> Bool) -> [a] -> Bool
myAny _ []     = False
myAny f (x:xs) = f x || myAny f xs

3.
myElem :: Eq a => a -> [a] -> Bool
myElem _ [] = False
myElem a (x:xs) = a == x || myElem a xs

myElem' :: Eq a => a -> [a] -> Bool
myElem' a = any (==a)               --or myAny, defined above

4.
myReverse :: [a] -> [a]
myReverse [] = []
myReverse xs = xs !! lenMinusOne xs : myReverse (take (lenMinusOne xs) xs)
        where
          lenMinusOne x = (-) (length x) 1

5.
mySquish :: [[a]] -> [a]
mySquish []     = []
mySquish (x:xs) =  x ++ mySquish xs

6.
mySquishMap :: (a -> [b]) -> [a] -> [b]
mySquishMap _ [] = []
mySquishMap f (x:xs) = f x ++ mySquishMap f xs

7.
mySquishAgain :: [[a]] -> [a]
mySquishAgain xs = mySquishMap (\(x:xs) -> x : xs) xs

8.
myMaximumBy :: (a -> a -> Ordering) -> [a] -> a
myMaximumBy _ (x:[]) = x
myMaximumBy f l = myMaximumBy f (gts l)
   where
      gts l = filter (\x -> f x (head.tail $ l) == GT) l

9.
myMinimumBy :: (a -> a -> Ordering) -> [a] -> a
myMinimumBy _ (x:[]) = x
myMinimumBy f l = myMinimumBy f (lts l)
    where
      lts l = filter (\x -> f x (head.tail $ l) == LT) l

10.
myMaximum :: (Ord a) => [a] -> a
myMaximum = myMaximumBy compare

myMinimum :: (Ord a) => [a] -> a
myMinimum = myMinimumBy compare
```
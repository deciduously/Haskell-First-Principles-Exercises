#### Intermission
```haskell
applyTimes (Eq a, Num a) => a -> (b -> b) -> b -> b
applyTimes 0 f b = b
applyTimes n f b = f . applyTimes (n-1) f $ b

applyTimes 5 (+1) 5
(applyTimes (5-1) (+1) 5) + 1
((applyTimes (4-1) (+1) 5) + 1) + 1
(((applyTimes (3-1) (+1) 5) + 1) + 1) + 1
((((applyTimes (2-1) (+1) 5) + 1) + 1) + 1) + 1
(((((applyTimes (1-1) (+1) 5) + 1) + 1) + 1) + 1) + 1 -- base case
(((((5) + 1) + 1) + 1) + 1) + 1
10
```
### Chapter Exercises
#### Review of Types
1. d
2. b
3. d
4. b
#### Reviewing Currying
```haskell
cattyConny :: String -> String -> String
cattyConny x y = x ++ " mrow " ++ y

flippy :: String -> String -> String
flippy = flip cattyConny

appedCatty :: String -> String
appedCatty = cattyConny "woops"
frappe :: String -> String
frappe = flippy "haha"

1. appedCatty "woohoo" -> "woops mrow woohoo!"
2. frappe "1" -> "1 mrow haha"
3. frappe (appedCatty "2") -> "woops mrow 2 mrow haha"
4. appedCatty (frappe "blue") -> "woops mrow blue mrow haha"
5. cattyConny (frappe "pink")
              (cattyConny "green" (appedCatty "blue")) -> "pink mrow haha mrow green mrow woops mrow blue"
6. cattyConny (flippy "Pugs" "are") "awesome" -> "are mrow Pugs mrow awesome"
```
#### Recursion
```haskell
dividedBy :: Integral a => a -> a -> (a,a)
dividedBy num denom = go num denom 0
  where go n d count 
         | n < d = (count, n)
         | otherwise = go (n - d) d (count + 1)

1.
dividedBy 15 2
go 15 2 0
go (13) 2 1
go (11) 2 2
go (9) 2 3
go (7) 2 4
go (5) 2 5
go (3) 2 6
go (1) 2 7 == (7, 1) -- n < d

2.
sumR :: (Eq a, Num a) => a -> a
sumR 0 = 0
sumR n = n + sumR (n - 1)

3.
multR :: Integral a => a -> a -> a
multR 0 _ = 0 -- optionally leave out, probably quicker when included though
multR _ 0 = 0
multR x y = x + multR x (y - 1)
```
#### Fixing dividedBy
```haskell
data DividedResult =
    Result (Integer, Integer)
  | DividedByZero deriving Show

dividedBy :: Integer -> Integer -> DividedResult
dividedBy num denom = go (abs num) (abs denom) 0
  where go n d count
         | d == 0    = DividedByZero
         | n < d     = if signum num /= signum denom then Result (negate count, n) else Result (count, n)
         | otherwise = go (n - d) d (count + 1)
```
#### McCarthy 91
```haskell
mc91 :: Integral a => a -> a
mc91 x
   | x > 100 = x - 10
   | x <= 100 = mc91 . mc91 $ x + 11
```
#### Numbers into words
```haskell
import Data.List (intersperse)

digitToWord :: Int -> String
digitToWord n 
          | n < 0  = "negative"
          | n == 0 = "zero"
          | n == 1 = "one"
          | n == 2 = "two"
          | n == 3 = "three"
          | n == 4 = "four"
          | n == 5 = "five"
          | n == 6 = "six"
          | n == 7 = "seven"
          | n == 8 = "eight"
          | n == 9 = "nine"

digits :: Int -> [Int]
digits n
     | n < 0 = (-1 :: Int) : (digits $ abs n) -- this is hacky but at least it doesn't crash 
     | n < 10 = n : []
     | otherwise = snd x : digits (fst x) where x = divMod n 10

wordNumber :: Int -> String
wordNumber = concat . intersperse "-" . map digitToWord . reverse . digits
```
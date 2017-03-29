#### Grab Bag
```haskell
1. All equivalent
2. d
3.
  a. (\n -> case odd n of True -> (\x -> x + 1) n; False -> n)
  b. (\x -> \y -> (if x > y then y else x) + 5)
  c. mflip f y x = f y x
```
#### Variety Pack
```haskell
1. 
k (x, y) = x
k1 = k ((4-1), 10)
k2 = k ("three", (1 + 2))
k3 = k (3, True)
  a. k :: (t1, t) -> t1
  b. k2 :: String; k3 :: Num a => a; k1 :: Num a => a
  c. k3 returns 3

2.
f :: (a,b,c) -> (d,e,f) -> ((a, d), (c, f))
f (a,_,c) (d,_,f) = ((a, d), (c, f))
```
#### Case Practice
```haskell
1.
functionC x y =
  case x > y of
    True -> x
    False -> y

2.
ifEvenAdd2 n =
  case even n of
    True -> n + 2
    False -> n

3.
nums x =
  case compare x 0 of
    LT -> -1
    GT -> 1
    EQ -> 0
```
#### Artful Dodgy
```haskell
dodgy :: Num a => a -> a -> a
dodgy x y = x + y * 10

oneIsOne :: Integer -> Integer
oneIsOne = dodgy 1

oneIsTwo :: Integer -> Integer
oneIsTwo = (flip dodgy) 2

1. dodgy 1 0   = 1
2. dodgy 1 1   = 11
3. dodgy 2 2   = 22
4. dodgy 1 2   = 21
5. dodgy 2 1   = 12
6. oneIsOne 1  = 11
7. oneIsOne 2  = 21
8. oneIsTwo 1  = 21
9. oneIsTwo 2  = 22
10. oneIsOne 3 = 31
11. oneIsTwo 3 = 23
```
#### Guard Duty
```haskell
1. all evaluate to otherwise guard
2. Evaluates top to bottom, so you could bury a branch
3. b
pal xs
  | xs == reverse xs = True
  | otherwise = False
4. Eq a
5. Eq a => [a] -> Bool
6. c
numbers x
  | x < 0  = -1
  | x == 0 = 0
  | x > 0  = 1
7. Ord, Num
8. numbers :: (Ord a, Num, a, Num t) => a -> t
```
### Chapter Exercises
#### Multiple Choice
1. d
2. b
3. d
4. b
5. a
#### Write Code
```haskell
1.
tensDigit :: Integral a => a -> a
tensDigit x = d
  where xLast = x `div` 10
        d     = xLast `mod` 10
a.
tensDigit' :: Integral a => a -> a
tensDigit' x = (fst $ divMod x 10) `mod` 10

b. yes
c.
hunsD x = tensDigit' $ (fst $ divMod x 10) `mod` 100

2.
foldBool :: a -> a -> Bool -> a
foldBool x y b =
  case b of
    True -> x
    False -> y

foldBool' x y b
  | b         = x
  | otherwise = y

3.
g :: (a -> b) -> (a, c) -> (b, c)
g aToB (a, c) = (aToB a, c)

4.
see code/

5.
roundTripPF = read . show

6.
roundTrip 4 :: Integer
```
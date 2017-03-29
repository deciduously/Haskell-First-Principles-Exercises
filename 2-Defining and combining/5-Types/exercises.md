#### Type Matching
1. a - c
2. b - d
3. c - b
4. d - a
5. e - e
#### Type Arguments
1. a
2. d
3. d
4. c
5. a
6. e
7. d
8. a
9. c
#### Parametricity
```haskell
1. --can't be done
2. f x y = id id y
3. t :: a -> b -> b; t a b = id b
   --b can be any type
```
#### Apply Types
```haskell
1.  (++) :: [a] -> [a] -> [a] 
    myConcat x = x ++ "yo"
    myConcat :: [Char] ++ [Char]

2. (*) :: Num a => a -> a -> a
    myMult x = (x / 3) * 5
    myMult :: Fractional a => a -> a

3.  take :: Int [a] -> [a]
    myTake x = take x "hey you"
    myTake :: Int -> [Char] 

4.  (>) :: Ord a => a -> a -> Bool
    myCom x = x > (length [1..10])
    myCom :: Int -> Bool

5.  (<) :: Ord a => a -> a -> Bool
    myAlph x = x < 'z'
    myAlph :: Char -> Bool
```
### Chapter Exercises
#### Multiple Choice
1. c
2. a
3. b
4. c
#### Determine the type
```haskell
 1. 
    a. 54 :: Num a => a
    b. (0, "doge") :: Num a => (a, String)
    c. (0, "doge") :: (Integer, String)
    d. False :: Bool
    e. 5 :: Int
    f. False :: Bool
2. Num a => a
3. Num a => a -> a
4. Fractional a => a
5. --Illegal!  Hah!
```
#### Does it compile?
```haskell
1. bigNum x = (^) 5 $ x --changed
   wahoo = bigNum $ 10

2. x = print
   y = print "woohoo!"
   z = x "Hello world!"
   --all good here!

3. a = (+)
   b = 5
   c = a b --changed
   d = c 200

4. a = 12 + b
   b = 10000 * c
   c = 1 -- added
```
#### Type variable or specific type constructor?
```haskell
1. f :: Num a => a -> b -> Int -> Int
        1. constrained polymorphic
        2. fully polymorphic
        3. concrete
        4. concrete
2. f :: zed -> Zed -> Blah
        1. fully polymorphic
        2. concrete
        3. concrete
3. f :: Enum b => a -> b -> C
        1. fully polymorphic
        2. constrained polymorphic
        3. concrete
4. f :: f -> g -> C
        1. fully polymorphic
        2. fully polymorphic
        3. concrete
```
#### Write a type signature
```haskell
1.  functionH :: [a] -> a
    functionH (x:_) = x

2.  functionC :: Ord a => a -> a -> Bool
    functionC x y = if (x > y) then True else False

3.  functionS :: (a, b) -> b
    functionS (x, y) = y
```
#### Given a type, write the function
```haskell
1.  i :: a -> a
    i = id a

2.  c :: a -> b -> a
    c a b = a

3.  c'' :: b -> a -> b
    c'' b a = a
    -- α-equivalent to 2

4.  c' :: a -> b -> b
    c' a b = b

5.  r :: [a] -> [a]
    r = take 2 -- etc, etc, etc

6.  co :: (b -> c) -> (a -> b) -> a -> c
    co bToC aToB a = bToC $ aToB a

7.  a :: (a -> c) -> a -> a
    a _ a = a
    -- Is there a way that type checks more specifically?

8.  a' :: (a -> b) -> a -> b
    a' aToB a = aToB a
```
#### Fix It
```haskell
1.
module Sing where

fstString :: [Char] -> [Char]
fstString x = x ++ " in the rain"

sndString :: [Char] -> [Char]
sndString x = x ++ " over the rainbow"

sing = if (x > y) then fstString x else sndString y
      where
        x = "Singin"
        y = "Somewhere"

2. s/>/</g
3.
module Arith3Broken where

main :: IO ()
main = do
  print (1 + 2)
  putStrLn $ show 10
  print (negate (-1))
  print ((+) 0 blah)
    where
      blah = negate 1
```
#### Type-Kwon-Do
```haskell
1.
f :: Int -> String
f = undefined

g :: String -> Char
g = undefined

h :: Int -> Char
h = g $ f n

2.
data A
data B
data C

q :: A -> B
q = undefined

w :: B -> C
w = undefined

e :: A -> C
e = a = w $ q a

3.  
data X
data Y
data Z

xz :: X -> Z
xz = undefined

yz :: Y -> Z
yz = undefined

xform :: (X, Y) -> (Z, Z)
xform (x, y) = (xz x, yz y)

4.  
munge :: (x -> y) -> (y ->(w, z)) -> x -> w
munge = xToY yToWZ x = fst $ yToWZ $ xToY x
```
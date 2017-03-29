#### Write Eq Instances
```haskell
1.
data TisAnInteger =
      TisAn Integer
    
instance Eq TisAnInteger where
  (==) (TisAn n) (TisAn n') = n == n'

2.
data TwoIntegers = 
  Two Integer Integer

instance Eq TwoIntegers where
  (==) (Two n m) (Two n' m') = n == n' && m == m' 

3.
data StringOrInt
  = TisAnInt Int
  | TisAString String

instance Eq StringOrInt where
  (==) (TisAnInt n) (TisAnInt n')     = n == n'
  (==) (TisAString s) (TisAString s') = s == s'
  (==) _ _                            = False

4.
data Pair a =
  Pair a a deriving Show

instance Eq a => Eq (Pair a) where
  (==) (Pair a _) (Pair a' _) = a == a'

5.
data Tuple a b =
  Tuple a b

instance (Eq a, Eq b) => Eq (Tuple a b) where
  (==) (Tuple a b) (Tuple a' b') = a == a' && b == b'

6.
data Which a =
    ThisOne a
  | ThatOne a

instance Eq a => Eq (Which a) where
  (==) (ThisOne a) (ThisOne a') = a == a'
  (==) (ThatOne a) (ThatOne a') = a == a'
  (==) _ _                      = False

7.
data EitherOr a b = 
    Hello a
  | Goodbye b

instance (Eq a, Eq b) => Eq (EitherOr a b) where
  (==) (Hello a) (Hello a')      = a == a'
  (==) (Goodbye b) (Goodbye b')  = b == b'
  (==) _ _                      = False
```
#### Tuple Experiment
1. `divMov` returns a 2-tuple: `(div x y, mod x y)` e.g.
#### Will They Work?
```haskell
1. max (length [1,2,3,4]) (length [8,9,10,11,12]) --yes, 5
2. compare (3 * 4) (3 * 5)                        --yes, LT
3. compare "Julie" True                           --no, String cannot Eq with Bool
4. (5 + 3) > (3 + 6)                              --yes, false
```
### Chapter Exercises
#### Multiple Choice
1. c
2. b
3. a
4. c
5. a
#### Does It Typecheck
```haskell
1.
-- had to derive Show
data Person = Person Bool deriving Show

printPerson :: Person -> IO ()
printPerson person = putStrLn (show person)

2.
-- Had to derive Eq, add type signature for settleDown
data Mood = Blah
          | Woot deriving (Eq, Show)

settleDown :: Mood -> Mood
settleDown x = if x == Woot
                then Blah
                else x

3.
  a. Blah | Woot :: Mood
  b. No instance for (Num Mood)
  c. No instance for (Ord Mood)

4.
-- Added third argument to s1, type signatures
type Subject = String
type Verb = String
type Object = String

data Sentence =
  Sentence Subject Verb Object
  deriving (Eq, Show)

s1 :: Sentence
s1 = Sentence "dogs" "drool" "everywhere"

s2 :: Sentence
s2 = Sentence "Julie" "loves" "dogs"
```
#### Given a datatype declaration, what can we do?
```haskell
data Rocks =
  Rocks String deriving (Eq, Show)

data Yeah =
  Yeah Bool deriving (Eq, Show)

data Papu =
  Papu Rocks Yeah
  deriving (Eq, Show)

1.
phew = Papu "chases" True --No
phew = Papu (Rocks "chases") (Yeah True)

2.
truth = Papu (Rocks "chomskydoz")
              (Yeah True) --Yes

3.
equalityForAll :: Papu -> Papu -> Bool
equalityForAll pp' = p == p' --yes

4.
comparePapus :: Papu -> Papu -> Bool
comparePapus p p' = p > p' --no, must derive Ord for all three types
```
#### Match the types
```haskell
1.
i :: Num a => a
i = 1

i :: a -- no, 1 is Num

2.
f :: Float
f = 1.0

f :: Num a -> a -- no, 1.0 is Fractional, Num is a superset

3. 
f :: Float
f = 1.0

f :: Fractional a => a -- yes

4.
f :: Float
f = 1.0

f :: RealFrac a => a -- yes, RealFrac is a subset of Fractional

5.
freud :: a -> a
freud x = x

freud :: Ord a => a -> a -- yes, Ord satisfies a

6.
freud' :: a -> a
freud' x = x

freud' :: Int -> Int -- yes, Int satisfies a

7.
myX = 1 :: Int

sigmund :: Int -> Int
sigmund x = myX

sigmund :: a -> a -- no, must return Int

8.
myX = 1 :: Int

sigmund' :: Int -> Int
sigmund' x = myX

sigmund' :: Num a => a -> a -- no, Int is more specific than Num 

9.
jung :: Ord a => [a] -> a
jung xs = head (sort xs)

jung :: [Int] -> Int -- yes, Int implies Ord

10.
young :: [Char] -> Char
young xs = head (sort xs)

young :: Ord a => [a] -> a -- yes, Char implies Ord

11.
mySort :: [Char] -> [Char]
mySort = sort

signifier :: [Char] -> Char
signifier xs = head (mySort xs)

signifier :: Ord a => [a] -> a -- no, mySort constrains to Char even though Char implies Ord
```
#### Type-Kwon-Do Two
```haskell
1.
chk :: Eq b => (a -> b) -> a -> b -> Bool
chk aToB a b = aToB a == b

2.
arith :: Num b => (a -> b) -> Integer -> a -> b
arith aToB n a = aToB a + fromInteger n
```
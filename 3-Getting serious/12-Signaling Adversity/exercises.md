### Chapter Exercises
#### Determine the Kinds
1. `a :: *`
2. `a :: *`, `f :: * -> *`
#### String processing
```haskell
vowels :: String
vowels = "aeiou"

1.
notThe :: String -> Maybe String
notThe s
     | elem s ["The", "the"] = Nothing
     | otherwise           = Just s

replaceThe :: String -> String
replaceThe = unwords . map (fromMaybe "a".notThe) . words

2.
countBeforeVowel :: String -> Integer
countBeforeVowel p = foldr theBeforeV 0 (zip (words p) (tail.words $ p)) --apparently zip <*> tail is a thing too
  where
    theBeforeV a b = bool b (succ b) (elem (head.snd $ a) vowels && (flip elem ["The", "the"].fst $ a))

3.
countVowels :: String -> Int
countVowels = length.filter (flip elem vowels)
```
#### Validate the word
```haskell
newtype Word' =
  Word' String deriving (Eq, Show)

mkWord :: String -> Maybe Word'
mkWord s =
  let
    numVowels = countVowels s
  in
    bool (Just (Word' s)) Nothing (numVowels > (length s - numVowels))
```
#### It's Only Natural
```haskell
data Nat =
    Zero
  | Succ Nat
  deriving (Eq, Show)

natToInteger :: Nat -> Integer
natToInteger Zero     = 0
natToInteger (Succ n) = succ.natToInteger $ n

integerToNat :: Integer -> Maybe Nat
integerToNat n
           | n < 0     = Nothing
           | n == 0    = Just Zero
           | otherwise = Just (Succ (fromMaybe Zero (integerToNat (n - 1))))
```
#### Small Maybe Library
```haskell
isJust :: Maybe a -> Bool
isJust Nothing = False
isJust _       = True

isNothing :: Maybe a -> Bool
isNothing = not.isJust

mayybee :: b -> (a -> b) -> Maybe a -> b
mayybee b _ Nothing  = b
mayybee b f (Just a) = f a

fromMaybe :: a -> Maybe a -> a
fromMaybe = flip mayybee id

listToMaybe :: [a] -> Maybe a
listToMaybe [] = Nothing
listToMaybe l = Just $ head l

maybeToList :: Maybe a -> [a]
maybeToList Nothing  = []
maybeToList (Just a) = [a]

catMaybes :: [Maybe a] -> [a]
catMaybes = concat . map maybeToList

flipMaybe :: [Maybe a] -> Maybe [a]
flipMaybe l =
    bool Nothing (Just $ catMaybes l) (length l == length (catMaybes l)) 
  where -- or import Data.Bool
    bool x y b
       | b         = y
       | otherwise = x
```
#### Small Either Library
```haskell
lefts' :: [Either a b] -> [a]
lefts' = foldr keepLeft []
  where 
    keepLeft (Left a) = (:) a
    keepLeft _        = (++) []

rights' :: [Either a b] -> [b]
rights' = foldr keepRights []
  where
    keepRights (Right b) = (:) b
    keepRights _         = (++) []

partitionEithers' :: [Either a b] -> ([a],[b])
partitionEithers' l = (lefts' l, rights' l) --liftM2?

eitherMaybe' :: (b -> c) -> Either a b -> Maybe c
eitherMaybe' _ (Left _)       = Nothing
eitherMaybe' f (Right b)      = Just $ f b

either' :: (a -> c) -> (b -> c) -> Either a b -> c
either' f _ (Left a)  = f a
either' _ g (Right b) = g b

eitherMaybe'' :: (b -> c) -> Either a b -> Maybe c
eitherMaybe'' = either' (const Nothing) . (Just .)
```
#### Unfolds
```haskell
myIterate :: (a -> a) -> a -> [a]
myIterate f z = z : myIterate f (f z)

myUnfoldr :: (b -> Maybe (a,b)) -> b -> [a]
myUnfoldr f z = go f (f z)
  where
    go f Nothing      = []
    go f (Just (a,b)) = a : go f (f b)

betterIterate :: (a -> a) -> a -> [a]
betterIterate f = myUnfoldr (\b -> Just (b, f b))
```
#### Unfold Binary Tree
```haskell
unfold :: (a -> Maybe (a,b,a)) -> a -> BinaryTree b
unfold f z = go f (f z)
  where
    go f Nothing        = Leaf
    go f (Just (x,y,z)) = Node (go f (f x)) y (go f (f z))

--TODO this builds the tree in the reverse of what is specified
--I'll come back to this.
treeBuild :: Integer -> BinaryTree Integer
treeBuild = unfold treeFrom
  where
    treeFrom 0 = Nothing
    treeFrom n = Just (n-1,n,n-1)
```
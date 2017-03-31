#### Dog Types
```haskell
1. type constructor
2. * -> *
3. Doggies String :: *
4. Num a => Doggies a
5. Doggies Integer
6. Doggies String
7. exists as both
8. a -> DoDeBoa
9. DoDeBo String
```
#### Vehicles
```haskell
1. Vehicle

2.
isCar :: Vehicle -> Bool
isCar (Car _ _) = True
isCar _         = False

isPlane :: Vehicle -> Bool
isPlane (Plane _) = True
isPlane _         = False

areCars :: [Vehicle] -> [Bool]
areCars = foldr ((:).isCar) []

3/4.
getManu :: Vehicle -> Maybe Manufacturer
getManu (Car m _) = Just m
getManu _         = Nothing

5. 
data Size = Size Integer deriving (Eq, Show)

data Vehicle = Car Manufacturer Price
             | Plane Airline Size
             deriving (Eq, Show)

isPlane :: Vehicle -> Bool
isPlane (Plane _ _) = True
isPlane _         = False
```
#### Cardinality
1. 1
2. 3
3. 65536
4. `Int` is finite (but large), `Integer` is infinite
5. (^2) - 8 bits with two possible values each
#### For Example
1. `MakeExample:: Example` - canot query :t for Example, but use :k to get kind
2. Shows invocation, typeclass instances
3. `MakeExample :: Integer -> Example`
#### Logic Goats
```haskell
1.
instance TooMany (Int, String) where
  tooMany (n, _) = tooMany n

2.
instance TooMany (Int, Int) where
  tooMany (n, m) = tooMany $ n + m

3.
instance (Num a, TooMany a) => TooMany (a, a) where
  tooMany x = tooMany $ fst x + snd x
```
#### Pity The Bool
1. 4 (2 + 2)
2. 258 (256 + 2)
#### How does your garden grow?
```haskell
data Garden = Gardenia Gardener
            | Daisy Gardener
            | Rose Gardener
            | Lilac Gardener
            deriving Show
--my instinct is that it already is a sum of products:
--data Garden = Garden Gardener FlowerType deriving Show
```
#### Programmers
```haskell
allProgrammers :: [Programmer]
allProgrammers = [ Programmer x y | x <- allOS, y <- allLang ]
```
#### The Quad
1. 8
2. 16
3. 256
4. 8
5. 16
6. 65536
#### Binary Tree
```haskell
data BinaryTree a = Leaf
                  | Node (BinaryTree a) a (BinaryTree a)
                  deriving (Eq, Ord, Show)

mapTree :: (a -> b) -> BinaryTree a -> BinaryTree b
mapTree _ Leaf                = Leaf
mapTree f (Node left a right) = Node (mapTree f left) (f a) (mapTree f right)

preorder :: BinaryTree a -> [a]
preorder Leaf                = []
preorder (Node left a right) = concat [[a], preorder left, preorder right]

inorder :: BinaryTree a -> [a]
inorder Leaf                = []
inorder (Node left a right) = concat [inorder left, [a], inorder right]

postorder :: BinaryTree a -> [a]
postorder Leaf                = []
postorder (Node left a right) = concat [postorder left, postorder right, [a]]

foldTree :: (a -> b -> b) -> b -> BinaryTree a -> b
foldTree f z bt = foldr f z (inorder bt)
```
### Chapter Exercises
#### Multiple Choice
1. a
2. c
3. b
4. c
#### Ciphers
```haskell
letterToInt :: Char -> Int
letterToInt c = fromIntegral $ ord c - ord 'a'

intToLetter :: Int -> Char
intToLetter n = chr $ ord 'a' + n

shiftN :: Char -> Int -> Char
shiftN c n
     | not $ isAlpha c = c

--TODO this doesn't preserve spaces
vigenere :: String -> String -> String
vigenere p k = zipWith shiftN (concat $ words p) keyVals
    where keyVals = [ letterToInt x | x <- take (length p) $ cycle k ]
```
#### As-patterns
```haskell
1.
--TODO whoops, didn't use the as-pattern - it's concise at least
isSubSequenceOf :: (Eq a) => [a] -> [a] -> Bool
isSubSequenceOf x y = foldr ((&&).(flip elem) y) True x

2.
import Data.Char

capitalizeWords :: String -> [(String, String)]
capitalizeWords s = map (\s@(c:cs) -> (s, toUpper c : cs)) (words s)
```
#### Language exercises
```haskell
1.
capitalizeWord :: String -> String
capitalizeWord s@(c:cs) = toUpper c : cs

2.
capitalizeParagraph :: String -> String
capitalizeParagraph []     = []
capitalizeParagraph p = init.concat.intersperse ". " $ map capSentence (sentences p)
  where
    sentences s = map dropInitialSpaces (myChunks s '.')          -- myChunks lives in the Ch 9 exercises
      where dropInitialSpaces s                                   -- Data.List.Split.SplitOn works too but
                            | s == []       = []                  -- I wanted to use my own implementation
                            | otherwise     = dropWhile (== ' ') s

    capSentence [] = []
    capSentence s  = capitalizeWord (takeWhile (/= ' ') s) ++ drop (length (takeWhile (/= ' ') s)) s
```
#### Phone Exercise
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
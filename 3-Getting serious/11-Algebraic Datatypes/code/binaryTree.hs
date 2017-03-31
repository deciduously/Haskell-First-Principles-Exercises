--binaryTree.hs
module BinaryTree where

data BinaryTree a = Leaf
                  | Node (BinaryTree a) a (BinaryTree a)
                  deriving (Eq, Ord, Show)

insert' :: Ord a => a -> BinaryTree a -> BinaryTree a
insert' b Leaf = Node Leaf b Leaf
insert' b (Node left a right)
      | b == a = Node left a right
      | b < a  = Node (insert' b left) a right
      | b > a  = Node left a (insert' b right)

mapTree :: (a -> b) -> BinaryTree a -> BinaryTree b
mapTree _ Leaf = Leaf
mapTree f (Node left a right) = Node (mapTree f left) (f a) (mapTree f right)

testTree' :: BinaryTree Integer
testTree' = Node (Node Leaf 3 Leaf) 1 (Node Leaf 4 (Node Leaf 7 Leaf))

mapExpected :: BinaryTree Integer
mapExpected = Node (Node Leaf 4 Leaf) 2 (Node Leaf 5 (Node Leaf 8 Leaf))

mapOkay :: IO ()
mapOkay = if mapTree (+1) testTree' == mapExpected
          then print "all good in the hood!"
          else error "back to the drawing board!"

preorder :: BinaryTree a -> [a]
preorder Leaf                = []
preorder (Node left a right) = concat [[a], preorder left, preorder right]

inorder :: BinaryTree a -> [a]
inorder Leaf                = []
inorder (Node left a right) = concat [inorder left, [a], inorder right]

postorder :: BinaryTree a -> [a]
postorder Leaf                = []
postorder (Node left a right) = concat [postorder left, postorder right, [a]] 

testTree :: BinaryTree Integer
testTree = Node (Node Leaf 1 Leaf) 2 (Node Leaf 3 Leaf)

testPreorder :: IO ()
testPreorder =
  if preorder testTree == [2,1,3]
  then putStrLn "preorder fine!"
  else putStrLn "preorder borked"

testInorder :: IO ()
testInorder =
  if inorder testTree == [1,2,3]
  then putStrLn "inorder fine!"
  else putStrLn "inorder screwy"

testPostorder :: IO ()
testPostorder =
  if postorder testTree == [1,3,2]
  then putStrLn "postorder fine!"
  else putStrLn "postorder hopeless"

main :: IO ()
main = do
  testPreorder
  testInorder
  testPostorder

foldTree :: (a -> b -> b) -> b -> BinaryTree a -> b
foldTree f z bt = foldr f z (inorder bt)
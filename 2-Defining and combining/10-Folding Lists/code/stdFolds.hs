--stdFolds.hs
module StdFolds where

--Data.List not used here, in practice import and use foldl'
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
--stdFolds.hs
module StdFolds where

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

--these work for f := compare, but not (\_ _ -> GT || LT)
--Stuck on why, going to revisit
myMaximumBy :: (a -> a -> Ordering) -> [a] -> a
myMaximumBy f xs = foldr (\a b -> bool a b (f a b == GT)) (head xs) xs

myMinimumBy :: (a -> a -> Ordering) -> [a] -> a
myMinimumBy f xs = foldr (\a b -> bool a b (f a b == LT)) (head xs) xs
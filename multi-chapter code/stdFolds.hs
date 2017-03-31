--stdFolds.hs
module StdFolds where

--Data.List not used here, in practice import and use foldl'

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
  where
    bool x y b
       | b         = x
       | otherwise = y

squish :: [[a]] -> [a]
squish = foldr (++) []

squishMap :: (a -> [b]) -> [a] -> [b]
squishMap = flip foldr [] . ((++) .)

squishAgain :: [[a]] -> [a]
squishAgain = squishMap (\(x:xs) -> x:xs)

myMaximumBy :: (a -> a -> Ordering) -> [a] -> Maybe a
myMaximumBy _ []     = Nothing
myMaximumBy f (x:xs) = Just $ foldl (\a b -> keepG a b (f a b)) x xs
  where
      keepG x y o
          | o == GT   = x
          | otherwise = y

myMinimumBy :: (a -> a -> Ordering) -> [a] -> Maybe a
myMinimumBy _ []     = Nothing
myMinimumBy f (x:xs) = Just $ foldl (\a b -> keepL a b (f a b)) x xs
  where
      keepL x y o
          | o == LT   = x
          | otherwise = y
--myStd.hs
module MyStd where

myOr :: [Bool] -> Bool
myOr []     = True
myOr (x:xs) = x || myOr xs

myAny :: (a -> Bool) -> [a] -> Bool
myAny _ []     = False
myAny f (x:xs) = f x || myAny f xs

myElem :: Eq a => a -> [a] -> Bool
myElem _ [] = False
myElem a (x:xs) = a == x || myElem a xs

myElem' :: Eq a => a -> [a] -> Bool
myElem' a = myAny (==a)

myReverse :: [a] -> [a]
myReverse [] = []
myReverse xs = xs !! lenMinusOne xs : myReverse (take (lenMinusOne xs) xs)
        where
          lenMinusOne x = (-) (length x) 1

mySquish :: [[a]] -> [a]
mySquish []     = []
mySquish (x:xs) =  x ++ mySquish xs

mySquishMap :: (a -> [b]) -> [a] -> [b]
mySquishMap _ [] = []
mySquishMap f (x:xs) = f x ++ mySquishMap f xs

mySquishAgain :: [[a]] -> [a]
mySquishAgain xs = mySquishMap (\(x:xs) -> x : xs) xs

myMaximumBy :: (a -> a -> Ordering) -> [a] -> a
myMaximumBy _ (x:[]) = x
myMaximumBy f l = myMaximumBy f (gts l)
   where
      gts l = filter (\x -> f x (head.tail $ l) == GT) l

myMinimumBy :: (a -> a -> Ordering) -> [a] -> a
myMinimumBy _ (x:[]) = x
myMinimumBy f l = myMinimumBy f (lts l)
    where
      lts l = filter (\x -> f x (head.tail $ l) == LT) l

myMaximum :: (Ord a) => [a] -> a
myMaximum = myMaximumBy compare

myMinimum :: (Ord a) => [a] -> a
myMinimum = myMinimumBy compare

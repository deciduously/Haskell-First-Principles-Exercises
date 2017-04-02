--unfolds.hs
module Unfolds where

myIterate :: (a -> a) -> a -> [a]
myIterate f z = z : myIterate f (f z)

myUnfoldr :: (b -> Maybe (a,b)) -> b -> [a]
myUnfoldr f z = go f (f z)
  where
    go f Nothing      = []
    go f (Just (a,b)) = a : go f (f b)

betterIterate :: (a -> a) -> a -> [a]
betterIterate f = myUnfoldr (\b -> Just (b, f b))
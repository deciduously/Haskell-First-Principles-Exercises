--myEither.hs
module MyEither where

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
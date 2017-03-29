--bottom.hs
module Bottom where

f :: Bool -> Maybe Int
f False = Just 0
f True = Nothing

multR :: (Integral a) => a -> a -> a
--multR 0 _ = 0
multR _ 0 = 0
multR x y = x + multR x (y - 1)

data DividedResult =
    Result (Integer, Integer)
  | DividedByZero deriving Show

dividedBy :: Integer -> Integer -> DividedResult
dividedBy num denom = go (abs num) (abs denom) 0
  where go n d count
         | d == 0    = DividedByZero
         | n < d     = if signum num /= signum denom then Result (negate count, n) else Result (count, n)
         | otherwise = go (n - d) d (count + 1)

mc91 :: Integral a => a -> a
mc91 x
   | x > 100 = x - 10
   | x <= 100 = mc91 . mc91 $ x + 11


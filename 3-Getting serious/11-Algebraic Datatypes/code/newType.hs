--newType.hs
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module NewType where

class TooMany a where
  tooMany :: a -> Bool

newtype Goats = Goats Int deriving (Eq, Show, TooMany)

instance TooMany Int where
  tooMany n = n > 42

instance TooMany (Int, String) where
  tooMany (n, _) = tooMany n

instance (Num a, TooMany a) => TooMany (a, a) where
  tooMany x = tooMany $ fst x + snd x
--another.hs
module Another where

import Control.Monad
import Data.Monoid
import Data.Optional
import Test.QuickCheck

newtype First' a =
  First' { getFirst' :: Optional a}
  deriving (Eq, Show)

instance Arbitrary a => Arbitrary (First' a) where
  arbitrary = do
    a <- arbitrary
    frequency [ (1, return $ First' Default)
              , (2, return $ First' $ Specific a)]

instance Monoid (First' a) where
  mempty = First' Default
  mappend (First' Default) (First' x) = First' x
  mappend (First' x) (First' _) = First' x

monoidAssoc :: (Eq m, Monoid m) => m -> m -> m -> Bool
monoidAssoc  a b c = a <> (b <> c) == (a <> b) <> c

monoidLeftIdentity :: (Eq m, Monoid m) => m -> Bool
monoidLeftIdentity a = (mempty <> a) == a

monoidRightIdentity :: (Eq m, Monoid m) => m -> Bool
monoidRightIdentity a = (a <> mempty) == a

firstMappend :: First' a -> First' a -> First' a
firstMappend = mappend

type FirstMappend = First' String -> First' String -> First' String -> Bool

type FstId = First' String -> Bool

main :: IO ()
main = do
  quickCheck (monoidAssoc :: FirstMappend)
  quickCheck (monoidLeftIdentity :: FstId)
  quickCheck (monoidRightIdentity :: FstId)

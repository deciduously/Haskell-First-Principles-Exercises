--quickc.hs
module QuickC where

import           Data.List       (sort)
import           GHC.Generics
import           Test.QuickCheck

half :: Fractional a => a -> a
half x = x / 2

halfIdentity :: Fractional a => a -> a
halfIdentity = (*2) . half

trueGen :: Gen Int
trueGen = coarbitrary True arbitrary

listOrdered :: (Ord a) => [a] -> Bool
listOrdered xs =
  snd $ foldr go (Nothing, True) xs
    where go _ status@(_, False) = status
          go y (Nothing, t)      = (Just y, t)
          go y (Just x, _)       = (Just y, x >= y)

prop_halfIdentify :: Property
prop_halfIdentify =
  forAll arbitrary (\x -> (x::Double) == halfIdentity x)

prop_sort :: Property
prop_sort =
  forAll arbitrary (\x -> listOrdered $ sort [x::Int])

prop_plusAssociative :: Property
prop_plusAssociative =
    forAll arbitrary (\x y z -> (x::Int) + (y::Int) + (z::Int) == x + (y + z))

prop_plusCommutative :: Property
prop_plusCommutative =
    forAll arbitrary (\x y -> (x::Int) + (y::Int) == y + x)

prop_multAssociative :: Property
prop_multAssociative =
    forAll arbitrary (\x y z -> (x::Int) * (y::Int) * (z::Int) == x * (y * z))

prop_multCommutative :: Property
prop_multCommutative =
    forAll arbitrary (\x y -> (x::Int) * (y::Int) == y * x)

prop_quotRem :: Positive Int -> Positive Int -> Bool
prop_quotRem (Positive n) (Positive m) =
  quot n m * m + rem n m == n

prop_divMod :: Positive Int -> Positive Int -> Bool
prop_divMod (Positive n) (Positive m) =
  div n m * m + mod n m == n

prop_expAssociative :: Positive Int -> Positive Int -> Positive Int -> Bool
prop_expAssociative (Positive n) (Positive m) (Positive o) =
  (n ^ m) ^ o == n ^ (m ^ o)

prop_expCommutative :: Positive Int -> Positive Int -> Bool
prop_expCommutative (Positive n) (Positive m) =
  n ^ m == m ^ n

prop_reverseRoundTrip :: [Integer] ->  Bool
prop_reverseRoundTrip xs =
  reverse (reverse xs) == xs

--TODO having trouble with Arbitrary - come back to this
--prop_dollarSign :: Property
--prop_dollarSign =
--  forall (coarbitrary arbitrary) (\f -> f $ arbitrary == f arbitrary)

square :: Num a => a -> a
square x = x * x

prop_squareIdentity :: Double -> Bool
prop_squareIdentity x =
  square (sqrt x) == x

twice f = f . f
fourTimes = twice . twice


prop_idempotentSort :: [Int] -> Bool
prop_idempotentSort s =
  sort s == fourTimes sort s

main :: IO ()
main = do
  quickCheck prop_idempotentSort

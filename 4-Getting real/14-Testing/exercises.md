### Intermission
#### Short Exercise
```haskell
    it "x * 0 is always 0" $ do
      property $ \x -> multR (x :: Int) 0 == 0
    it "x * 1 is always x" $ do
      property $ \x -> multR (x :: Int) 1 == x
```
#### Morse
[Full Code](https://github.com/deciduously/Haskell-First-Principles-Exercises/tree/master/4-Getting%20real/14-Testing/code/morse)
### Chapter Exercises
#### Using Hspec
```haskell
main :: IO ()
main = hspec $ do
  describe "digitToWord" $ do
    it "returns zero for 0" $ do
      digitToWord 0 `shouldBe` "zero"
    it "returns one for 1" $ do
      digitToWord 1 `shouldBe` "one"

  describe "digits" $ do
    it "returns [1] for 1" $ do
      digits 1 `shouldBe` [1]
    it "returns [1, 0, 0] for 100" $ do
      digits 100 `shouldBe` [1, 0, 0]

  describe "wordNumber" $ do
    it "one-zero-zero given  100" $ do
      wordNumber 100 `shouldBe` "one-zero-zero"
    it "nine-zero-zero-one for 9001" $ do
      wordNumber 9001 `shouldBe` "nine-zero-zero-one"
```
#### Using Quickcheck

```haskell
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

--TODO having trouble with Coarbitrary - come back to this
```
#### Failure
Floating point imprecision in sqrt
#### Idempotence
```haskell
prop_idempotentSort :: [Int] -> Bool
prop_idempotentSort s =
  sort s == fourTimes sort s
```
#### Make a Gen for the type
```haskell
genFool :: Gen Fool
genFool =
  choose (Fulse, Frue)

genSkew :: Gen Fool
genSkew = 
  frequency [ (2, return Frue)
            , (1, return Fulse)]
```
#### Hangman Tests


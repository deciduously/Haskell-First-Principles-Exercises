### Intermission
#### Short Exercise
```haskell
    it "x * 0 is always 0" $ do
      property $ \x -> multR (x :: Int) 0 == 0
    it "x * 1 is always x" $ do
      property $ \x -> multR (x :: Int) 1 == x
```
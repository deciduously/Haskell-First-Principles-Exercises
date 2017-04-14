#### Optional Monoid
```haskell
instance Monoid a => Monoid (Optional a) where
  mempty = Nada
  mappend Nada x = x
  mappend x Nada = x
  mappend (Only x) (Only y) = Only (x `mappend` y)
```
#### Madlibs
```haskell
madlibbinBetter' :: Exclamation
           -> Adverb
           -> Noun
           -> Adjective
           -> String
```
#### Maybe Another Monoid
```haskell
instance Arbitrary a => Arbitrary (First' a) where
  arbitrary = do
    a <- arbitrary
    frequency [ (1, return $ First' Default)
              , (2, return $ First' $ Specific a)]

instance Monoid (First' a) where
  mempty = First' Default
  mappend (First' Default) (First' x) = First' x
  mappend (First' x) (First' _) = First' x
```

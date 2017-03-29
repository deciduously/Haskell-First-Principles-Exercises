--grabBag.hs
module GrabBag where

addOneIfOdd n = case odd n of
  True -> f n
  False -> n
  where
    f n = n + 1

anonAOIO = (\n -> case odd n of True -> (\x -> x + 1) n; False -> n)

addFive x y = (if x > y then y else x) + 5

anonAF = (\x -> \y -> (if x > y then y else x) + 5)

anonMF f = (\x -> \y -> f y x)

mflip f y x = f y x
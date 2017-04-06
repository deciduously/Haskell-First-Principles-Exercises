--newGen.hs
module newGen where

import Test.QuickCheck

data Fool = Fulse | Frue deriving (Eq, Show)


genFool :: Gen Fool
genFool =
  choose (Fulse, Frue)

genSkew :: Gen Fool
genSkew = 
  frequency [ (2, return Frue)
            , (1, return Fulse)]

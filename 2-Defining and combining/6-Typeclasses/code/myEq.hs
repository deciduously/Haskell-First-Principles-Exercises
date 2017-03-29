--myEq.hs
module MyEq where

data Trivial
  = Trivial' --deriving Eq would usually do, or anything that derives Eq, etc

-- NOTE keep typeclass instances in the same file as that type

instance Eq Trivial where
  (==) Trivial' Trivial' = True
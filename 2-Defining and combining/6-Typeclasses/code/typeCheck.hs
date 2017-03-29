--typeCheck.hs
module TypeCheck where

--1
data Person = Person Bool deriving Show

printPerson :: Person -> IO ()
printPerson person = putStrLn (show person)
--2
data Mood = Blah
          | Woot deriving (Eq, Show)

settleDown :: Mood -> Mood
settleDown x = if x == Woot
                then Blah
                else x
--4
type Subject = String
type Verb = String
type Object = String

data Sentence =
  Sentence Subject Verb Object
  deriving (Eq, Show)

s1 :: Sentence
s1 = Sentence "dogs" "drool" "everywhere"

s2 :: Sentence
s2 = Sentence "Julie" "loves" "dogs"
----
data Rocks =
  Rocks String deriving (Eq, Show, Ord)

data Yeah =
  Yeah Bool deriving (Eq, Show, Ord)

data Papu =
  Papu Rocks Yeah
  deriving (Eq, Show, Ord)
--distribute.hs
module Distribute where

--data Fiction = Fiction' deriving Show

--data Nonfiction = Nonfiction' deriving Show

data BookType = FictionBook Fiction
              | NonfictionBook Nonfiction
              deriving Show

type AuthorName = String

data Author = Fiction AuthorName
            | Nonfiction AuthorName
            deriving (Eq, Show)
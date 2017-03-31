--programmers.hs
module Programmers where

data OperatingSystem = GnuPlusLinux
                     | OpenBSD
                     | Mac
                     | Windows
                     deriving (Eq, Show)

data ProgrammingLanguage = Haskell
                        | Idris
                        | Agda
                        | Purescript
                        deriving (Eq, Show)

data Programmer =
  Programmer { os :: OperatingSystem
             , lang :: ProgrammingLanguage }
             deriving (Eq, Show)

allOS :: [OperatingSystem]
allOS =
  [ GnuPlusLinux
  , OpenBSD
  , Mac
  , Windows
  ]

allLang :: [ProgrammingLanguage]
allLang = [Haskell, Idris, Agda, Purescript]

allProgrammers :: [Programmer]
allProgrammers = [ Programmer x y | x <- allOS, y <- allLang ]



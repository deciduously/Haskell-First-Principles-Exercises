--scans.hs
module Scans where

fibs = 1 : scanl (+) 1 fibs
fibsN = (!!) fibs
fibsToN n = take n $ fibs

smallFibs = takeWhile (< 100) fibs

factorialScan n = scanl (*) 1 [1..n]
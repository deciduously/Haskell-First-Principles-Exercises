#### Mood Swing
```haskell
1. Mood
2. Blah or Woot
3. changeMood :: Mood -> Mood
4. changeMood Woot = Blah
   changeMood _ = Woot
```
#### Find Mistakes
```haskell
1. not True && True
2. not (x == 6)
3. ok
4. ["Merry"] > ["Happy"]
5. ['1', '2', '3'] ++ "look at me!"
```
### Chapter Exercises
```haskell
1. length :: List -> Integer
2.
      a. 5
      b. 3
      c. 2
      d. 5
3. length returns an Integer
4. use `div`
5. Bool, True
6. Bool, False
7. 
   a. 2
   b. differing types in List
   c. 8
   d. False
   e. differing types
8. isPalindrome x = x == reverse x
9. myAbs = if x >= 0 then x else -x
10. f a b = ((snd a, snd b), (fst a, fst b))
```
#### Correcting Syntax
```haskell
1. f xs = w `x` 1 where w = length xs
2. \x -> x
3. \x(x : xs) -> x
4. f (a, b) = a
```
#### Match names to types
1. c
2. b
3. a
4. d
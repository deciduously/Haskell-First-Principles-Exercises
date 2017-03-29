--print2.hs

module Print2 where

main :: IO ()
main = do
  putStrLn "Count!"
  putStr "one, two"
  putStr " three, and "
  putStrLn "four!"

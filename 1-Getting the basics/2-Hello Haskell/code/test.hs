-- test.hs

sayHello :: String -> IO ()
sayHello x = putStrLn ("Hello, " ++ x ++ "!")

ex1 = x * 3 + y
    where
      x = 3
      y = 1000

ex2 = x * 5
    where
      y = 10
      x = 10 * 5 + y

ex3 = z / x + y
    where
      x = 7
      y = negate x
      z = y * 10

waxOn = x * 5
      where
        z = 7
        y = z + 8
        x = y ^ 2

triple x = x * 3

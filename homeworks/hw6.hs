import Data.List

fib :: Integer -> Integer
fib 0 = 0
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)

fibs1 :: [Integer]
fibs1 = fmap fib [0..]

-- Not finish yet
fibs2Helper :: [Integer] -> Integer -> [Integer]
fibs2Helper xs n = xs ++ [fib n]

fibs2 :: [Integer]
fibs2 = foldl' fibs2Helper [] [0..]

main = do
    print (fib 0)
    print (fib 1)
    print (fib 7)
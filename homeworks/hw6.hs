import Data.List

fib :: Integer -> Integer
fib 0 = 0
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)

fibs1 :: [Integer]
fibs1 = fmap fib [0..]

-- Not finish `fibs2` yet
fibs2Helper :: [Integer] -> Integer -> [Integer]
fibs2Helper xs n = xs ++ [fib n]

fibs2 :: [Integer]
fibs2 = foldl' fibs2Helper [] [0..]

data Stream a = Stream a

streamToList :: Stream a -> [a]
streamToList (Stream a) = repeat a 

instance Show a => Show (Stream a) where
    show s = show $ take 20 (streamToList s)

main = do
    print (fib 0)
    print (fib 1)
    print (fib 7)
    print (Stream 9)
-- https://www.seas.upenn.edu/~cis194/spring13/hw/04-higher-order.pdf

fun1 :: [Integer] -> Integer
fun1 [] = 1
fun1 (x:xs)
    | even x = (x - 2) * fun1 xs
    | otherwise = fun1 xs

fun1' :: [Integer] -> Integer
fun1' = foldl (*) 1 . map (\x -> x - 2) . filter even

fun2 :: Integer -> Integer
fun2 1 = 0
fun2 n 
    | even n = n + fun2 (n `div` 2)
    | otherwise = fun2 (3 * n + 1)

-- fun2' :: Integer -> Integer
-- fun2' = 

countTrue :: Integer -> Bool -> Integer
countTrue n x
    | x == True = n + 1
    | otherwise = n

xor :: [Bool] -> Bool
xor = odd . foldl countTrue 0

main = do
    print (fun1 [1, 2, 3])
    print (fun1' [1, 2, 3])
    print (fun2 9)
    print (xor [False, True, False, False, True])
    print (xor [False, True, False])
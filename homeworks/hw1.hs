-- https://www.seas.upenn.edu/~cis194/spring13/hw/01-intro.pdf

import Data.Char

toDigits :: Integer -> [Integer]
toDigits n
    | n <= 0 = []
    | otherwise = map (toInteger . digitToInt) (show n)

toDigitsRev :: Integer -> [Integer]
toDigitsRev = reverse . toDigits

doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther [] = []
doubleEveryOther (x:xs)
    | (odd . length) xs = [x + x] ++ doubleEveryOther xs
    | otherwise = [x] ++ doubleEveryOther xs

sumd :: Integer -> Integer
sumd 0 = 0
sumd x = (x `mod` 10) + sumd (x `div` 10)

sumDigits :: [Integer] -> Integer
sumDigits [] = 0
sumDigits (x:xs) = sumd x + sumDigits xs

-- validate :: Integer -> Bool


main = do
    -- print (toDigits 1234)
    -- print (toDigits 0)
    -- print (toDigits (-3))
    -- print (toDigitsRev 4012888888881881)
    -- print (toDigitsRev 0)
    -- print (toDigitsRev (-3))
    -- print (doubleEveryOther [8, 7, 6, 5])
    -- print (doubleEveryOther [1, 2, 3])
    -- print (sumDigits [16, 7, 12, 5])
    -- print (sumDigits [1, 4, 3])
    print ((sumDigits . doubleEveryOther . toDigitsRev) 4012888888881881)

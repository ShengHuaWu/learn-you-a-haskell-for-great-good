-- https://www.seas.upenn.edu/~cis194/spring13/hw/03-rec-poly.pdf

everyNth :: Int -> [a] -> [a]
everyNth _ [] = []
everyNth n xs = case drop (n-1) xs of
    (y:ys) -> y: everyNth n ys
    [] -> []

skips :: [a] -> [[a]]
skips [] = []
skips [x] = [[x]]
skips xs = [xs] ++ map (\n -> everyNth n xs) [2, 3..(length xs)]

getMidMax :: [Integer] -> [Integer]
getMidMax (x:y:xs) 
    | y == m = [y]
    | otherwise = []
    where
        m = max (max x y) (head xs)

localMax :: [Integer] -> [Integer]
localMax ns = case take 3 ns of
    [] -> []
    [_] -> []
    (_:_:[]) -> []
    xs -> getMidMax xs ++ localMax (drop 1 ns)

main = do
    -- print (skips "ABCD")
    -- print (skips "hello!")
    -- print (skips [True, False])
    print (localMax [2,9,5,6,1])
    print (localMax [])
    print (localMax [1, 5])
    print (localMax [2,3,4,1,5])

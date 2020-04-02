import Data.Char

-- main = putStrLn "Hello, World!!!"

{-
-- Each of these steps is an I/O action. 
-- By putting them together with do syntax, we glued them into one I/O action. 
-- The action that we got has a type of IO (), 
-- because that's the type of the last I/O action inside.
main = do
    putStrLn "Let go Haskell!!"
    name <- getLine
    putStrLn ("Hey " ++ name ++ "123") 
    -- Notice that we didn't bind the last `putStrLn` to anything. 
    -- That's because in a do block, 
    -- the last action cannot be bound to a name like the first two were.
-}

{-
main = do
    putStrLn "What is your first name?"
    firstName <- getLine
    putStrLn "what is your last name?"
    lastName <- getLine
    let upperFirstName = map toUpper firstName
        upperLastName = map toUpper lastName
    putStrLn $ "Hey " ++ upperFirstName ++ " " ++ upperLastName ++ ", how are you?"
-}

-- It's just a normal function that takes a string like "hey there man"
-- and then calls `words` with it to produce a list of words like ["hey","there","man"]. 
-- Then we `map reverse` on the list, getting ["yeh","ereht","nam"] 
-- and then we put that back into one string by using `unwords`
-- and the final result is "yeh ereht nam"
reverseWords :: String -> String
reverseWords = unwords . map reverse . words

main = do
    line <- getLine
    if null line 
        then return ()
        else do
            putStrLn $ reverseWords line
            main
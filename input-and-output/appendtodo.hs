import System.IO

main = do
    item <- getLine
    appendFile "todo.txt" (item ++ "\n")
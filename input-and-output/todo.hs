import System.Environment   
import System.Directory  
import System.IO  
import Data.List 

dispatch :: [(String, [String] -> IO ())]
dispatch = [("add", add),
            ("view", view),
            ("remove", remove)]

add :: [String] -> IO ()
add [fileName, todoItem] = appendFile fileName (todoItem ++ "\n")

view :: [String] -> IO ()
view [fileName] = do
    contents <- readFile fileName
    let todoTakes = lines contents
        numberedTasks = zipWith (\n line -> show n ++ " - " ++ line) [0..] todoTakes
    putStr $ unlines numberedTasks

remove :: [String] -> IO ()
remove [fileName, numberString] = do
    handle <- openFile fileName ReadMode
    (tempName, tempHandle) <- openTempFile "." "temp"
    contents <- hGetContents handle
    let number = read numberString
        todoTakes = lines contents
        newTodoTakes = delete (todoTakes !! number) todoTakes
    hPutStr tempHandle $ unlines newTodoTakes
    hClose handle
    hClose tempHandle
    removeFile fileName
    renameFile tempName fileName

-- We made a dispatch association that maps from commands to functions that take some command line arguments and return an I/O action. 
-- We see what the command is and based on that we get the appropriate function from the dispatch list. 
-- We call that function with the rest of the command line arguments to get back an I/O action that will do the appropriate thing and then just perform that action.
main = do
    (command:args) <- getArgs
    let (Just action) = lookup command dispatch
    action args
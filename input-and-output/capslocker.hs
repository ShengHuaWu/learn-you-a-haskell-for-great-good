import Data.Char  
  
main = do  
    -- It will print out the capslocked version as it reads it, 
    -- because it will only read a line from the input when it really needs to.
    contents <- getContents 
    putStr (map toUpper contents) 
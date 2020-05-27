-- https://www.seas.upenn.edu/~cis194/spring13/hw/02-ADTs.pdf

import Data.Char

data MessageType = Info
                    | Warning
                    | Error Int
                    deriving (Show, Eq)

type TimeStamp = Int

data LogMessage = LogMessage MessageType TimeStamp String 
                    | Unknown String
                    deriving (Show, Eq)

data MessageTree = Leaf
                    | Node MessageTree LogMessage MessageTree
                    deriving (Show)

getTime :: LogMessage -> TimeStamp
getTime (LogMessage _ time _) = time

readFirstInt :: String -> (Int, String)
readFirstInt text = (read . head $ xs, unwords . tail $ xs)
    where
        xs = words text

parseMessageType :: String -> (Maybe MessageType, String)
parseMessageType (x:xs)
    | x == 'I' = (Just Info, tail xs)
    | x == 'W' = (Just Warning, tail xs)
    | x == 'E' = (Just (Error level), reminder)
    | otherwise = (Nothing, x:xs)
    where
        (level, reminder) = readFirstInt xs

parseMessage :: String -> LogMessage
parseMessage text = case first of
    Just messageType -> LogMessage messageType time message
    Nothing          -> Unknown reminder
    where
        (first, reminder) = parseMessageType text
        (time, message) = readFirstInt reminder

parse :: String -> [LogMessage]
parse = (fmap parseMessage) . lines

insert :: LogMessage -> MessageTree -> MessageTree
insert log Leaf = Node Leaf log Leaf
insert log1 (Node l log2 r)
    | time1 > time2 = Node l log2 (insert log1 r)
    | otherwise = Node (insert log1 l) log2 r
    where
        time1 = getTime log1
        time2 = getTime log2

build :: [LogMessage] -> MessageTree
build = foldl (\result log -> insert log result) Leaf

inOrder :: MessageTree -> [LogMessage]
inOrder Leaf = []
inOrder (Node l log r) = (inOrder l) ++ [log] ++ (inOrder r)

main = do
    let text = "W 1234 This is a warning\n\
    \I 6543 This is a information\n\
    \E 99 124 This is an error\n\
    \I 6 Completed armadillo processing\n\
    \I 1 Nothing to report\n\
    \E 99 10 Flange failed!\n\
    \I 4 Everything normal\n\
    \I 11 Initiating self-destruct sequence\n\
    \E 70 3 Way too many pickles\n\
    \E 65 8 Bad pickle-flange interaction detected\n\
    \W 5 Flange is due for a check-up\n\
    \I 7 Out for lunch, back in two time steps\n\
    \E 20 2 Too many pickles\n\
    \I 9 Back from lunch"
    print . inOrder . build . parse $ text
    -- print . parseMessage $ "K xyz whatever"
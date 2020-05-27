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

main = do
    let text = "W 1234 This is a warning\n\
    \I 6543 This is a information\n\
    \E 99 124 This is an error"
    print . parse $ text
    -- print . parseMessage $ "K xyz whatever"
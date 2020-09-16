-- https://www.seas.upenn.edu/~cis194/spring13/hw/10-applicative.pdf

import Data.Char

newtype Parser a = Parser { runParser :: String -> Maybe (a, String) }

first :: (a -> b) -> (a, c) -> (b, c)
first f (a, c) = (f a, c)

instance Functor Parser where
    fmap f p = Parser (\s -> (first f) <$> runParser p s)

instance Applicative Parser where
    pure a = Parser (\s -> Just (a, s))
    p1 <*> p2 = Parser (\s -> case runParser p1 s of 
        Nothing -> Nothing
        Just (f, rest) -> runParser (f <$> p2) rest)

satisfy :: (Char -> Bool) -> Parser Char
satisfy p = Parser f
    where 
        f [] = Nothing
        f (x:xs)
            | p x = Just (x, xs)
            | otherwise = Nothing

char :: Char -> Parser Char
char c = satisfy (== c)

tuple :: Char -> Char -> (Char, Char)
tuple a b = (a, b)

abParser :: Parser (Char, Char)
abParser = tuple <$> char 'a' <*> char 'b'

abParser_ :: Parser ()
abParser_ =  (\x -> ()) <$> abParser

posInt :: Parser Integer
posInt = Parser f
    where
        f xs
            | null ns = Nothing
            | otherwise = Just (read ns, rest)
            where (ns, rest) = span isDigit xs

pair :: Integer -> Integer -> [Integer]
pair x y = x:[y]

ignoreFirst :: Char -> Integer -> Integer
ignoreFirst _ i = i

secondPosInt :: Parser Integer
secondPosInt = ignoreFirst <$> char ' ' <*> posInt

intPair :: Parser [Integer]
intPair = pair <$> posInt <*> secondPosInt

main = do
    print(first (+2) (1, True))
    print(runParser abParser "abcdefg")
    print(runParser abParser "aubcdefg")
    print(runParser abParser_ "abcdefg")
    print(runParser abParser_ "aubcdefg")
    print(runParser intPair "12 34")
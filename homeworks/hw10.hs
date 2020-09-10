-- https://www.seas.upenn.edu/~cis194/spring13/hw/10-applicative.pdf

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

main = do
    print(first (+2) (1, True))
type Expected = String
type Encountered = String
data ParserError = ParserError Expected Encountered

newtype Parser a = Parser {
  runParser :: String -> (String, Either ParserError a)
}

any :: Parser Char
any = Parser $ \input -> case input of
  (x:xs) -> (xs, Right x)
  []     -> ("", Left $ ParserError "any character" "the end of the input")

eof :: Parser ()
eof = Parser $ \input -> case input of
  (x:_) -> (input, Left $ ParserError "the end of the input" [x])
  []    -> ("", Right ())

-- This is `>>=`
andThen :: Parser a -> (a -> Parser b) -> Parser b
andThen parserA f = Parser $ \input ->
  case runParser parserA input of
    (reminders, Right a) -> runParser (f a) reminders
    (reminders, Left e)  -> (reminders, Left e)

-- backtracking
try :: Parser a -> Parser a
try p = Parser $ \input ->
  case runParser p input of
    (_, Left e) -> (input, Left e)
    success     -> success

-- Ignore the error from the first parser for now
(<|>) :: Parser a -> Parser a -> Parser a
p1 <|> p2 = Parser $ \input ->
  case runParser p1 input of
    (_, Left e) -> runParser p2 input
    success     -> success

newMap :: (a -> b) -> Parser a -> Parser b
newMap f parserA = Parser $ \input ->
  case runParser parserA input of
    (reminders, Right a) -> (reminders, Right $ f a)
    (reminders, Left e)  -> (reminders, Left e)

instance Functor Parser where
  fmap = newMap

apply :: Parser (a -> b) -> Parser a -> Parser b
apply parserF parserA = Parser $ \input ->
  case runParser parserF input of
    (reminders, Right f) -> runParser (fmap f parserA) reminders
    (reminders, Left e)  -> (reminders, Left e)

instance Applicative Parser where
  pure a = Parser $ \s -> ("", Right a)
  (<*>) = apply

instance Monad Parser where
  return = pure
  (>>=) = andThen

-- zero or more occurrences
many :: Parser a -> Parser [a]
many p = many1 p <|> return []

-- one or more occurrences
many1 :: Parser a -> Parser [a]
many1 p = do
  first  <- p
  others <- many p
  return (first:others)

-- match zero or more occurrences of a given parser with a given separator between them
sepBy :: Parser a -> Parser s -> Parser [a]
sepBy p s = sepBy1 p s <|> return []

-- match one or more occurrences of a given parser with a given separator between them
sepBy1 :: Parser a -> Parser s -> Parser [a]
sepBy1 p s = (:) <$> (s >> p) <*> (sepBy p s)

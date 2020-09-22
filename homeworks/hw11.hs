import AParser -- From AParser.hs
import Data.Char
import Control.Applicative

-- Applicative exerices
mapA :: Applicative f => (a -> f b) -> ([a] -> f [b])
mapA _ [] = pure []
mapA g (x:xs) = (:) <$> g x <*> mapA g xs

sequenceA1 :: Applicative f => [f a] -> f [a]
sequenceA1 [] = pure []
sequenceA1 (x:xs) = (:) <$> x <*> sequenceA1 xs

replicateA :: Applicative f => Int -> f a -> f [a]
replicateA 0 _ = pure []
replicateA count x = (:) <$> x <*> replicateA (count-1) x

-- Parsers
zeroOrMore :: Parser a -> Parser [a]
zeroOrMore p = (oneOrMore p) <|> pure []

oneOrMore :: Parser a -> Parser [a]
oneOrMore p = (:) <$> p <*> zeroOrMore p

spaces :: Parser String
spaces = zeroOrMore (satisfy isSpace)

ident :: Parser String
ident = (:) <$> satisfy isAlpha <*> zeroOrMore (satisfy isAlphaNum)

type Ident = String
data Atom = N Integer | I Ident deriving Show
data SExpr = A Atom | Comb [SExpr] deriving Show

parseAtomInteger :: Parser Atom
parseAtomInteger = N <$> posInt

parseAtomIdent :: Parser Atom
parseAtomIdent = I <$> ident

parseSExprAtom :: Parser SExpr
parseSExprAtom = A <$> (parseAtomInteger <|> parseAtomIdent)

openParenthesis :: Parser [Char]
openParenthesis = zeroOrMore (satisfy (=='('))

closeParenthesis :: Parser [Char]
closeParenthesis = zeroOrMore (satisfy (==')'))

-- How to ensure there are a pair of open and close parethesis?
parseSExprComb :: Parser SExpr
parseSExprComb = Comb <$> oneOrMore (openParenthesis *> spaces *> parseSExprAtom <* spaces <* closeParenthesis)

parseSExpr :: Parser SExpr
parseSExpr = parseSExprAtom <|> parseSExprComb

main = do
    print(runParser (zeroOrMore (satisfy isUpper)) "ABCdEfgH")
    print(runParser (oneOrMore (satisfy isUpper)) "ABCdEfgH")
    print(runParser (zeroOrMore (satisfy isUpper)) "abcdeFGh")
    print(runParser (oneOrMore (satisfy isUpper)) "abcdeFGh")
    print(runParser ident "foobar baz")
    print(runParser ident "foo33fA")
    print(runParser ident "2bad")
    print(runParser ident "")
    print(runParser parseSExpr "5")
    print(runParser parseSExpr "foo3")
    print(runParser parseSExpr "(bar8 (foo))")
    print(runParser parseSExpr "( bar8 ( foo ) 3 5 789 )")

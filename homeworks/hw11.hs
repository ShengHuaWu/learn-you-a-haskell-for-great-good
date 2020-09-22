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

zeroOrMore :: Parser a -> Parser [a]
zeroOrMore p = (oneOrMore p) <|> pure []

oneOrMore :: Parser a -> Parser [a]
oneOrMore p = (:) <$> p <*> zeroOrMore p

main = do
    print(runParser (zeroOrMore (satisfy isUpper)) "ABCdEfgH")
    print(runParser (oneOrMore (satisfy isUpper)) "ABCdEfgH")
    print(runParser (zeroOrMore (satisfy isUpper)) "abcdeFGh")
    print(runParser (oneOrMore (satisfy isUpper)) "abcdeFGh")

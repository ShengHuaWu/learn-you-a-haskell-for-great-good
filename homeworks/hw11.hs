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

main = do
    print "Hello World!!!"

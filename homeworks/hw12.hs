-- https://www.seas.upenn.edu/~cis194/spring13/hw/12-monads.pdf

import Control.Monad.Random
import Data.List

newtype DieValue = DV { unDV :: Int } deriving Show

first :: (a -> b) -> (a, c) -> (b, c)
first f (a, c) = (f a, c)

instance Random DieValue where
  random           = first DV . randomR (1,6)
  randomR (low,hi) = first DV . randomR (max 1 (unDV low), min 6 (unDV hi))

die :: Rand StdGen DieValue
die = getRandom

instance Eq DieValue where
    d1 == d2 = unDV d1 == unDV d2

instance Ord DieValue where
    compare d1 d2 = compare (unDV d1) (unDV d2)

type Army = Int
data Battlefield = Battlefield { attackers :: Army, defenders :: Army } deriving Show

testStdGen :: StdGen
testStdGen = mkStdGen 100

replicateA :: Applicative f => Int -> f a -> f [a]
replicateA 0 _ = pure []
replicateA count x = (:) <$> x <*> replicateA (count-1) x

attacherDice :: Army -> Rand StdGen [DieValue]
attacherDice n
    | n > 2 = sort <$> replicateA 2 die
    | otherwise = sort <$> replicateA n die

defendersDice :: Army -> Rand StdGen [DieValue]
defendersDice n
    | n > 2 = sort <$> replicateA 2 die
    | otherwise = sort <$> replicateA n die

compareDice :: [DieValue] -> [DieValue] -> [Bool]
compareDice attackers defenders = zipWith (>) attackers defenders

updateArmy :: Battlefield -> [Bool] -> Battlefield
updateArmy b [] = b
updateArmy b (r:rs)
    | r == True = updateArmy (Battlefield (attackers b) ((defenders b)-1)) rs
    | otherwise = updateArmy (Battlefield ((attackers b)-1) (defenders b)) rs

battle :: Battlefield -> Rand StdGen Battlefield
battle b = 
    let aDice = attacherDice (attackers b)
        dDice = defendersDice (defenders b)
        results = compareDice <$> aDice <*> dDice
    in
        updateArmy b <$> results

invade :: Battlefield -> Rand StdGen Battlefield
invade b
    | attackers b < 2 = return b
    | defenders b == 0 = return b
    | otherwise = battle b >>= invade

nextSuccess :: Int -> Battlefield -> Int
nextSuccess n b
    | defenders b == 0 = n + 1
    | otherwise = n

checkResults :: [Battlefield] -> Double
checkResults bs = (fromIntegral $ foldl nextSuccess 0 bs) / (fromIntegral $ length bs) -- Cannot use `div` here

successProb :: Battlefield -> Rand StdGen Double
successProb b = checkResults <$> replicateA 1000 (invade b)

main = do 
    print "Hello World"

    let b1 = Battlefield 4 6
    print $ evalRand (successProb b1) testStdGen

    let b2 = Battlefield 6 3
    print $ evalRand (successProb b2) testStdGen
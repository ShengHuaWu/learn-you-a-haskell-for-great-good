data ExprT = Lit Integer
    | Add ExprT ExprT
    | Mul ExprT ExprT
    deriving (Show, Eq)

eval :: ExprT -> Integer
eval (Lit int) = int
eval (Add e1 e2) = eval e1 + eval e2
eval (Mul e1 e2) = eval e1 * eval e2

class Expr a where
    lit :: Integer -> a
    add :: a -> a -> a
    mul :: a -> a -> a

instance Expr ExprT where
    lit i = Lit i
    add x y = Add x y
    mul x y = Mul x y

instance Expr Integer where
    lit i = i
    add x y = x + y
    mul x y = x * y

instance Expr Bool where
    lit i
        | i > 0 = True
        | otherwise = False
    add x y = x || y
    mul x y = x && y

main = do 
    print(eval (Mul (Add (Lit 2) (Lit 3)) (Lit 4)))
    print(eval (Add (Mul (Lit 2) (Lit 3)) (Lit 4)))
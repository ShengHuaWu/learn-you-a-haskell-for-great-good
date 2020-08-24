import Data.Tree

type Name = String
type Fun = Integer

data Employee = Emp { empName :: Name, empFun :: Fun } 
    deriving (Show, Read, Eq)

testCompany :: Tree Employee
testCompany
  = Node (Emp "Stan" 9)
    [ Node (Emp "Bob" 2)
      [ Node (Emp "Joe" 5)
        [ Node (Emp "John" 1) []
        , Node (Emp "Sue" 5) []
        ]
      , Node (Emp "Fred" 3) []
      ]
    , Node (Emp "Sarah" 17)
      [ Node (Emp "Sam" 4) []
      ]
    ]

testCompany2 :: Tree Employee
testCompany2
  = Node (Emp "Stan" 9)
    [ Node (Emp "Bob" 3) -- (8, 8)
      [ Node (Emp "Joe" 5) -- (5, 6)
        [ Node (Emp "John" 1) [] -- (1, 0)
        , Node (Emp "Sue" 5) [] -- (5, 0)
        ]
      , Node (Emp "Fred" 3) [] -- (3, 0)
      ]
    , Node (Emp "Sarah" 17) -- (17, 4)
      [ Node (Emp "Sam" 4) [] -- (4, 0)
      ]
    ]

data GuestList = GL [Employee] Fun 
    deriving (Show, Eq)

instance Ord GuestList where
  compare (GL _ f1) (GL _ f2) = compare f1 f2

glCons :: Employee -> GuestList -> GuestList
glCons (Emp n f) (GL xs fun) = GL ((Emp { empName = n, empFun = f }):xs) (f+fun)

instance Semigroup GuestList where
    (GL xs f1) <> (GL ys f2) = GL (xs++ys) (f1+f2)

instance Monoid GuestList where -- Monoid needs Semigroup
    mempty = GL [] 0

moreFun :: GuestList -> GuestList -> GuestList
moreFun (GL xs f1) (GL ys f2) 
  | f1 > f2 = GL xs f1
  | otherwise = GL ys f2

treeFold :: (b -> a -> b) -> b -> Tree a -> b
treeFold f initial (Node label []) = f initial label
treeFold f initial tree = 
  let result = f initial (rootLabel tree) 
      nextResult = (\r t -> treeFold f r t) in
  foldl nextResult result (subForest tree) -- foldl :: (b -> Tree a -> b) -> b -> [Tree a] -> b


main = do
    print (glCons (Emp "Stan" 9) (GL [] 0))
    print (glCons (Emp "Sam" 4) (GL [Emp {empName = "Stan", empFun = 9}] 9))
    print (moreFun (GL [] 0) (GL [Emp {empName = "Stan", empFun = 9}] 9))
    print (treeFold (\r e -> r + (empFun e)) 0 testCompany)
    print (treeFold (\r e -> r + (empFun e)) 0 testCompany2)
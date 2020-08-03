## Zippers

### A trail of breadcrumbs
With a pair of `Tree a` and `Breadcrumbs a`, we have all the information to rebuild the whole tree and we also have a focus on a sub-tree. This scheme also enables us to easily move up, left and right. Such a pair that contains a focused part of a data structure and its surroundings is called a zipper, because moving our focus up and down the data structure resembles the operation of a zipper on a regular pair of pants.
```Haskell
-- We have a `LeftCrumb` that also contains the element in the node that we moved from and the right tree that we didn't visit.
data Crumb a = LeftCrumb a (Tree a) | RightCrumb a (Tree a) deriving (Show) 
type Breadcrumbs a = [Crumb a] 
type Zipper a = (Tree a, Breadcrumbs a) 
```

### Manipulating trees under focus

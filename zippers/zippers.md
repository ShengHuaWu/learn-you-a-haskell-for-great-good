## Zippers

### A trail of breadcrumbs
With a pair of `Tree a` and `Breadcrumbs a`, we have all the information to rebuild the whole tree and we also have a focus on a sub-tree. This scheme also enables us to easily move up, left and right. Such a pair that contains a focused part of a data structure and its surroundings is called a zipper, because moving our focus up and down the data structure resembles the operation of a zipper on a regular pair of pants.
```Haskell
-- We have a `LeftCrumb` that also contains the element in the node that we moved from and the right tree that we didn't visit.
data Crumb a = LeftCrumb a (Tree a) | RightCrumb a (Tree a) deriving (Show) 
type Breadcrumbs a = [Crumb a] 
type Zipper a = (Tree a, Breadcrumbs a) 
```

### Focusing on lists
```Haskell
-- The first list represents the list that we're focusing on and the second list is the list of breadcrumbs. 
type ListZipper a = ([a],[a])

goForward :: ListZipper a -> ListZipper a  
goForward (x:xs, bs) = (xs, x:bs)  
  
goBack :: ListZipper a -> ListZipper a  
goBack (xs, b:bs) = (b:xs, bs) 
```
The breadcrumbs in the case of lists are nothing more but a reversed part of our list.

### A very simple file system
```Haskell
type Name = String  
type Data = String  
data FSItem = File Name Data | Folder Name [FSItem] deriving (Show)  

data FSCrumb = FSCrumb Name [FSItem] [FSItem] deriving (Show)
type FSZipper = (FSItem, [FSCrumb]) 
```

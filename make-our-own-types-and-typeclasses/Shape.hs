module Shapes   
( Point(..) -- Export all the value constructors
, Shape(..) -- We could also not to export any value constructors for Shape by just writing `Shape` in the export statement. 
            -- That way, someone importing our module could only make shapes by using the auxilliary functions `baseCircle` and `baseRect`.
, baseCircle
, baseRect
) where  

data Point = Point Float Float deriving (Show)
data Shape = Circle Point Float | Rectangle Point Point deriving (Show)

baseCircle :: Float -> Shape  
baseCircle r = Circle (Point 0 0) r  
  
baseRect :: Float -> Float -> Shape  
baseRect width height = Rectangle (Point 0 0) (Point width height) 
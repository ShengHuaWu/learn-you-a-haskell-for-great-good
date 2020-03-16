## Higher Order Functions
### Curried functions
All the functions that accepted several parameters have been curried functions. If we call a function with too few parameters, we get back a partially applied function, meaning a function that takes as many parameters as we left out. Infix functions can also be partially applied by using sections. To section an infix function, simply surround it with parentheses and only supply a parameter on one side. 

### Some higher-orderism is in order
Imperative programming usually uses stuff like for loops, while loops, setting something to a variable, checking its state, etc. to achieve some behavior and then wrap it around an interface, like a function. Functional programming uses higher order functions to abstract away common patterns

### Lambdas
To make a lambda, we write a `\` and then we write the parameters, separated by spaces. After that comes a `->` and then the function body. We usually surround them by parentheses, because otherwise they extend all the way to the right. We can't define several patterns for one parameter in lambdas, like making a `[]` and a `(x:xs)` pattern for the same parameter and then having values fall through. If a pattern matching fails in a lambda, a runtime error occurs, so be careful when pattern matching in lambdas.

### Folds
A fold takes a binary function, a starting value (I like to call it the accumulator) and a list to fold up. The binary function itself takes two parameters. The binary function is called with the accumulator and the first (or last) element and produces a new accumulator. Then, the binary function is called again with the new accumulator and the now new first (or last) element, and so on. 

### Function application $
```Haskell
($) :: (a -> b) -> a -> b  
f $ x = f x  
```
When a `$` is encountered, the expression on its right is applied as the parameter to the function on its left, for example, `sum (map sqrt [1..130])` is equal to `sum $ map sqrt [1..130]`.

### Function composition
```Haskell
(.) :: (b -> c) -> (a -> b) -> a -> c  
f . g = \x -> f (g x) 
```
`f` must take as its parameter a value that has the same type as `g`'s return value. So the resulting function takes a parameter of the same type that `g` takes and returns a value of the same type that `f` returns. Function composition is right-associative, so we can compose many functions at a time. The expression `f (g (z x))` is equivalent to `(f . g . z) x`. 

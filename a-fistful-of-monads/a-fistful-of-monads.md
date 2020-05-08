## A Fistful of Monads

### Getting our feet wet with Maybe
`>>=` takes a monadic value, and a function that takes a normal value and returns a monadic value and manages to apply that function to the monadic value.

We did this by keeping in mind that a `Maybe` value represents a computation that might have failed.

### The Monad type class
The final function of the `Monad` type class is `fail`. We never use it explicitly in our code. Instead, it's used by Haskell to enable failure in a special syntactic construct for monads that we'll meet later.

### Walk the line
Normally, passing some value to a function that ignores its parameter and always just returns some predetermined value would always result in that predetermined value. With monads however, their context and meaning has to be considered as well.
```Haskell
(>>) :: (Monad m) => m a -> m b -> m b  
m >> n = m >>= \_ -> n 
```

By turning those values into `Maybe` values and replacing normal function application with `>>=`, we got a mechanism for handling failure pretty much for free, because `>>=` is supposed to preserve the context of the value to which it applies functions. In this case, the context was that our values were values with failure and so when we applied functions to such values, the possibility of failure was always taken into account.
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

### do notation
It turns out, `do` notation isn't just for `IO`, but can be used for any monad. Its principle is still the same: gluing together monadic values in sequence. 

Because `do` expressions are written line by line, they may look like imperative code to some people. But the thing is, they're just sequential, as each value in each line relies on the result of the previous ones, along with their contexts.

When we write a line in `do` notation without binding the monadic value with `<-`, it's just like putting `>>` after the monadic value whose result we want to ignore. We sequence the monadic value but we ignore its result because we don't care what it is.

In `do` notation, when we bind monadic values to names, we can utilize pattern matching, just like in `let` expressions and function parameters, for example,
```Haskell
justH :: Maybe Char  
justH = do  
    (x:xs) <- Just "hello"  
    return x  
```

When pattern matching fails in a do expression, the `fail` function is called. It's part of the `Monad` type class and it enables failed pattern matching to result in a failure in the context of the current monad instead of making our program crash.

### The list monad
In fact, list comprehensions are just syntactic sugar for using lists as monads. In the end, list comprehensions and lists in `do` notation translate to using `>>=` to do computations that feature non-determinism.

### Monad Laws
Left identity: `return x >>= f` is the same thing as `f x`.
Right identity: `m >>= return` is no different than just `m`.
Associativity: Doing `(m >>= f) >>= g` is just like doing `m >>= (\x -> f x >>= g)`.

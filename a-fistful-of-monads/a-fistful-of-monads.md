## A Fistful of Monads

### Getting our feet wet with Maybe
`>>=` takes a monadic value, and a function that takes a normal value and returns a monadic value and manages to apply that function to the monadic value.

We did this by keeping in mind that a `Maybe` value represents a computation that might have failed.

### The Monad type class
The final function of the `Monad` type class is `fail`. We never use it explicitly in our code. Instead, it's used by Haskell to enable failure in a special syntactic construct for monads that we'll meet later.
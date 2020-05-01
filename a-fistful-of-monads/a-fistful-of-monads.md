## A Fistful of Monads

### Getting our feet wet with Maybe
`>>=` takes a monadic value, and a function that takes a normal value and returns a monadic value and manages to apply that function to the monadic value.

We did this by keeping in mind that a `Maybe` value represents a computation that might have failed.
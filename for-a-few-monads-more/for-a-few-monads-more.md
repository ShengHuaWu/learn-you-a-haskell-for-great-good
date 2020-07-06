## For a Few Monads More

### Writer
The `Writer` monad is for values that have another value attached that acts as a sort of log value. `Writer` allows us to do computations while making sure that all the log values are combined into one log value that then gets attached to the result.

We're free to use do notation for `Writer` values. It's handy for when we have a several `Writer` values and we want to do stuff with them. Like with other monads, we can treat them as normal values and the context gets taken for us. In this case, all the monoid values that come attached get `mappend`ed and so are reflected in the final result. 

If we're not careful, using the `Writer` monad can produce list appending that looks like this:
```Haskell
((((a ++ b) ++ c) ++ d) ++ e) ++ f  
```
This associates to the left instead of to the right. This is inefficient because every time it wants to add the right part to the left part, it has to construct the left part all the way from the beginning.

A difference list is similar to a list, only instead of being a normal list, it's a function that takes a list and prepends another list to it. The difference list equivalent of a list like `[1,2,3]` would be the function `\xs -> [1,2,3] ++ xs`. A normal empty list is `[]`, whereas an empty difference list is the function `\xs -> [] ++ xs`.

### Reader
```Haskell
let f = (+) <$> (*2) <*> (+10)
f 3 -- 19
```
The expression `(+) <$> (*2) <*> (+10)` makes a function that takes a number, gives that number to `(*2)` and `(+10)` and then adds together the results. For instance, if we apply this function to 3, it applies both `(*2)` and `(+10)` to 3, giving 6 and 13. Then, it calls `(+)` with 6 and 13 and the result is 19.

### Tasteful stateful computations
Haskell features a thing called the state monad, which makes dealing with stateful problems a breeze while still keeping everything nice and pure.

### Error error on the wall
The `Either e a` type allows us to incorporate a context of possible failure to our values while also being able to attach values to the failure, so that they can describe what went wrong or provide some other useful info regarding the failure. An `Either e a` value can either be a `Right` value, signifying the right answer and a success, or it can be a `Left` value, signifying failure.

### Some useful monadic functions
```Haskell
liftM :: (Monad m) => (a -> b) -> m a -> m b 
liftM f m = m >>= (\x -> return (f x))
```
Doing `fmap` or `liftM` over a stateful computation results in another stateful computation, only its eventual result is modified by the supplied function.

```Haskell
ap :: (Monad m) => m (a -> b) -> m a -> m b  
ap mf m = do  
    f <- mf  
    x <- m  
    return (f x)
```
The `ap` function is basically `<*>`, only it has a `Monad` constraint instead of an `Applicative` one. 
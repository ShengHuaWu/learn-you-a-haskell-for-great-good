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
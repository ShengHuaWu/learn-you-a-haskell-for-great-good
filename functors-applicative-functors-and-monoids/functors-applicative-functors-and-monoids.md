## Functors Applicative Functors and Monoids
### Functors redux
A more correct term for what a functor is would be computational context. The context might be that the computation can have a value or it might have failed (Maybe and Either a) or that there might be more values (lists), stuff like that.

We can't write `instance Functor Either where`, but we can write `instance Functor (Either a) where` and then if we imagine that `fmap` is only for `Either a`, it would have a type declaration of `fmap :: (b -> c) -> Either a b -> Either a c`.

The first functor law states that if we map the `id` function over a functor, the functor that we get back should be the same as the original functor. This means that `fmap id = id`.

The second law says that composing two functions and then mapping the resulting function over a functor should be the same as first mapping one function over the functor and then mapping the other one. Formally written, that means that `fmap (f . g) = fmap f . fmap g`.

### Applicative functors
Doing `fmap (*) (Just 3)` results in `Just ((*) 3)`, which can also be written as `Just (* 3)` if we use sections.

A better way of thinking about `pure` would be to say that it takes a value and puts it in some sort of default (or pure) context—a minimal context that still yields that value.

 `<*>` takes a functor that has a function in it and another functor and sort of extracts that function from the first functor and then maps it over the second one.

 Applicative functors and the applicative style of doing `pure f <*> x <*> y <*> ...` allow us to take a function that expects parameters that aren't necessarily wrapped in functors and use that function to operate on several values that are in functor contexts. The function can take as many parameters as we want, because it's always partially applied step by step between occurences of `<*>`.

 Using the applicative style on lists is often a good replacement for list comprehensions, for example,
 ```Haskell
 ghci> [ x*y | x <- [2,5,10], y <- [8,10,11]]     
[16,20,22,40,50,55,80,100,110]

ghci> (*) <$> [2,5,10] <*> [8,10,11]  
[16,20,22,40,50,55,80,100,110]  
 ```

 If we ever find ourself binding some I/O actions to names and then calling some function on them and presenting that as the result by using return, consider using the applicative style because it's arguably a bit more concise and terse.

 The `(,,)` function is the same as `\x y z -> (x,y,z)`. Also, the `(,)` function is the same as `\x y -> (x,y)`.

 It seems that we can combine any amount of applicatives into one applicative that has a list of the results of those applicatives inside it.
 ```Haskell
sequenceA :: (Applicative f) => [f a] -> f [a]  
sequenceA [] = pure []  
sequenceA (x:xs) = (:) <$> x <*> sequenceA xs
 ```

 Like normal functors, applicative functors come with a few laws. The most important one is the one that we already mentioned, namely that `pure f <*> x = fmap f x` holds.

 ### The newtype keyword
 The `newtype` keyword in Haskell is made exactly for these cases when we want to just take one type and wrap it in something to present it as another type.

 If we use the `data` keyword to wrap a type, there's some overhead to all that wrapping and unwrapping when our program is running. But if we use `newtype`, Haskell knows that we're just using it to wrap an existing type into a new type (hence the name), because we want it to be the same internally but have a different type. With that in mind, Haskell can get rid of the wrapping and unwrapping once it resolves which value is of what type.

 When we make a new type from an existing type by using the `newtype` keyword, we can only have one value constructor and that value constructor can only have one field. But with `data`, we can make data types that have several value constructors and each constructor can have zero or more fields.

 The `type` keyword is for making type synonyms. What that means is that we just give another name to an already existing type so that the type is easier to refer to. The new type and the original type can be used interchangeably.

 The `newtype` keyword is for taking existing types and wrapping them in new types, mostly so that it's easier to make them instances of certain type classes. When we use newtype to wrap an existing type, the type that we get is separate from the original type.

 The `data` keyword is for making our own data types and with them. They can have as many constructors and fields as we wish and can be used to implement any algebraic data type by ourselves.

 If we just want your type signatures to look cleaner and be more descriptive, we probably want `type` synonyms. If we want to take an existing type and wrap it in a new type in order to make it an instance of a type class, chances are we're looking for a `newtype`. And if we want to make something completely new, odds are good that we're looking for the `data` keyword.
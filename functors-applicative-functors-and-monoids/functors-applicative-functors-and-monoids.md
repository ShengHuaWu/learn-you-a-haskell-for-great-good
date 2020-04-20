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
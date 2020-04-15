## Functors Applicative Functors and Monoids
### Functors redux
A more correct term for what a functor is would be computational context. The context might be that the computation can have a value or it might have failed (Maybe and Either a) or that there might be more values (lists), stuff like that.

We can't write `instance Functor Either where`, but we can write `instance Functor (Either a) where` and then if we imagine that `fmap` is only for `Either a`, it would have a type declaration of `fmap :: (b -> c) -> Either a b -> Either a c`.

The first functor law states that if we map the `id` function over a functor, the functor that we get back should be the same as the original functor. This means that `fmap id = id`.

The second law says that composing two functions and then mapping the resulting function over a functor should be the same as first mapping one function over the functor and then mapping the other one. Formally written, that means that `fmap (f . g) = fmap f . fmap g`.

## Make Our Own Types and Typeclasses

### Type parameters
Type parameter is like generic in other languages.

It's a very strong convention in Haskell to never add typeclass constraints in data declarations,
because we don't benefit a lot, but we end up writing more class constraints, even when we don't need them. 
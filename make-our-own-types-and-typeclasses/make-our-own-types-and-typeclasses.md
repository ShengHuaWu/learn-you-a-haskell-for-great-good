## Make Our Own Types and Typeclasses

### Type parameters
Type parameter is like generic in other languages.

It's a very strong convention in Haskell to never add typeclass constraints in data declarations,
because we don't benefit a lot, but we end up writing more class constraints, even when we don't need them. 

### Derived instance
Typeclasses are more like interfaces. We don't make data from typeclasses. Instead, we first make our data type and then we think about what it can act like.

Deriving in Haskell is similar to conforming protocol in Swift, for example `data Person = Person { ... } deriving (Eq)` is similar to `struct Person: Equatable { ... }`.

When we use the `read` function, we have to use an explicit type annotation to tell Haskell which type we want to get as a result.

The `Enum` typeclass is for things that have predecessors and successors. The `Bounded` typeclass is for things that have a lowest possible value and highest possible value.
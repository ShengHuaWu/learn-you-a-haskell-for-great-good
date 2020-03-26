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

### Type synonyms
The `type` keyword might be misleading to some, because we're not actually making anything new (we did that with the data keyword), but we're just making a synonym for an already existing type.

Giving the `String` type synonyms is something that Haskell programmers do when they want to convey more information about what strings in their functions should be used as and what they represent, for example, `type PhoneNumber = String`.

Type synonyms can also be parameterized, for instance, `type AssocList k v = [(k, v)]`. Just like we call a function with too few parameters to get back a new function, we can specify a type constructor with too few type parameters and get back a partially applied type constructor. 
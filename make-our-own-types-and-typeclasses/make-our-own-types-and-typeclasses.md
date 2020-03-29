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

### Recursive data structures
When we define functions as operators, we can use that to give them a fixity (but we don't have to). A fixity states how tightly the operator binds and whether it's left-associative or right-associative. For instance, `*`'s fixity is `infixl 7 *` and `+`'s fixity is `infixl 6`. That means that they're both left-associative (`4 * 3 * 2` is `(4 * 3) * 2`) but `*` binds tighter than `+`, because it has a greater fixity, so `5 * 4 + 3` is `(5 * 4) + 3`.

### Typeclasses 102
A quick recap on typeclasses: typeclasses are like interfaces. A typeclass defines some behavior (like comparing for equality, comparing for ordering, enumeration) and then types that can behave in that way are made instances of that typeclass. The behavior of typeclasses is achieved by defining functions or just type declarations that we then implement. So when we say that a type is an instance of a typeclass, we mean that we can use the functions that the typeclass defines with that type.

This is how the `Eq` class is defined in the standard prelude:
```Haskell
class Eq a where  
    (==) :: a -> a -> Bool  
    (/=) :: a -> a -> Bool  
    x == y = not (x /= y)  
    x /= y = not (x == y)
```

Here's how we make it an instance of `Eq`.
```Haskell
data TrafficLight = Red | Yellow | Green

instance Eq TrafficLight where  
    Red == Red = True  
    Green == Green = True  
    Yellow == Yellow = True  
    _ == _ = False
```
Again, it is similar to conforming a protocol or an interface in other programming languages.

Most of the times, class constraints in class declarations are used for making a typeclass a subclass of another typeclass and class constraints in instance declarations are used to express requirements about the contents of some type. For instance, here we required the contents of the Maybe to also be part of the Eq typeclass. This is similar to associated type of protocols in Swift.

 If we want to see what the instances of a typeclass are, just do `:info YourTypeClass` in GHCI, for example, `:info Num`. If we do `:info Maybe`, it will show all the typeclasses that `Maybe` is an instance of. Also `:info` can show the type declaration of a function.
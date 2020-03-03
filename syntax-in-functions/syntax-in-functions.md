## Syntax in Functions
### Pattern Matching
When defining functions, you can define separate function bodies for different patterns. This leads to really neat code that's simple and readable. You can pattern match on any data type — numbers, characters, lists, tuples, etc.

Pattern matching can also fail, if we have non-exhaustive patterns, for example,
```Haskell
charName :: Char -> String  
charName 'a' = "Albert"  
charName 'b' = "Broseph"  
charName 'c' = "Cecil"  

charName 'h'
"*** Exception: <interactive>:(6,1)-(8,20): Non-exhaustive patterns in function charName
```
When making patterns, we should always include a catch-all pattern so that our program doesn't crash if we get some unexpected input.

We can also pattern match in list comprehensions, for example,
```Haskell
let xs = [(1,3), (4,3), (2,4), (5,3), (5,6), (3,1)]  
[a + b | (a, b) <- xs]  
[4,7,6,8,11,4]   
```

Lists themselves can also be used in pattern matching. You can match with the empty list `[]` or any pattern that involves `:` and the empty list. But since `[1,2,3]` is just syntactic sugar for `1:2:3:[]`, you can also use the former pattern. A pattern like `x:xs` will bind the head of the list to `x` and the rest of it to `xs`, even if there's only one element so `xs` ends up being an empty list.

There's also a thing called as patterns. Those are a handy way of breaking something up according to a pattern and binding it to names whilst still keeping a reference to the whole thing. You do that by putting a name and an `@` in front of a pattern. For instance, the pattern `xs@(x:y:ys)`. This pattern will match exactly the same thing as `x:y:ys` but you can easily get the whole list via `xs` instead of repeating yourself by typing out `x:y:ys` in the function body again, for example,
```Haskell
capital :: String -> String  
capital "" = "Empty string, whoops!"  
capital all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]
```

### Guards
Guards are indicated by pipes that follow a function's name and its parameters. Usually, they're indented a bit to the right and lined up. A guard is basically a boolean expression. If it evaluates to `True`, then the corresponding function body is used. If it evaluates to `False`, checking drops through to the next guard and so on.

Note that there's no `=` right after the function name and its parameters, before the first guard. Many newbies get syntax errors because they sometimes put it there.

### Where
We can also use `where` bindings to pattern match.
Just like we've defined constants in `where` blocks, we can also define functions.
`where` bindings can also be nested. It's a common idiom to make a function and define some helper function in its `where` clause and then to give those functions helper functions as well, each with its own `where` clause.

### Let
Let bindings let you bind to variables anywhere and are expressions themselves, but are very local, so they don't span across guards. Just like any construct in Haskell that is used to bind values to names, let bindings can be used for pattern matching. The difference between let and where bindings is that let bindings are expressions themselves but where bindings are just syntactic constructs.
```Haskell
4 * (let a = 9 in a + 1) + 2  -- 42
```
We can also put let bindings inside list comprehensions.
```Haskell
calcBmis :: (RealFloat a) => [(a, a)] -> [a]  
calcBmis xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2] 
```
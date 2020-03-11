## Higher Order Functions
### Curried functions
All the functions that accepted several parameters have been curried functions. If we call a function with too few parameters, we get back a partially applied function, meaning a function that takes as many parameters as we left out. Infix functions can also be partially applied by using sections. To section an infix function, simply surround it with parentheses and only supply a parameter on one side. 

### Some higher-orderism is in order
Imperative programming usually uses stuff like for loops, while loops, setting something to a variable, checking its state, etc. to achieve some behavior and then wrap it around an interface, like a function. Functional programming uses higher order functions to abstract away common patterns

### Lambdas
To make a lambda, we write a `\` and then we write the parameters, separated by spaces. After that comes a `->` and then the function body. We usually surround them by parentheses, because otherwise they extend all the way to the right. We can't define several patterns for one parameter in lambdas, like making a `[]` and a `(x:xs)` pattern for the same parameter and then having values fall through. If a pattern matching fails in a lambda, a runtime error occurs, so be careful when pattern matching in lambdas.
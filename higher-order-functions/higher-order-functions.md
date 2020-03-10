## Higher Order Functions
### Curried functions
All the functions that accepted several parameters have been curried functions. If we call a function with too few parameters, we get back a partially applied function, meaning a function that takes as many parameters as we left out. Infix functions can also be partially applied by using sections. To section an infix function, simply surround it with parentheses and only supply a parameter on one side. 

### Some higher-orderism is in order
Imperative programming usually uses stuff like for loops, while loops, setting something to a variable, checking its state, etc. to achieve some behavior and then wrap it around an interface, like a function. Functional programming uses higher order functions to abstract away common patterns
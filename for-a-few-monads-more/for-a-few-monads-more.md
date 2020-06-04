## For a Few Monads More

### Writer
 The `Writer` monad is for values that have another value attached that acts as a sort of log value. `Writer` allows us to do computations while making sure that all the log values are combined into one log value that then gets attached to the result.
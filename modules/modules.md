## Modules
### Loading modules
When we do `import Data.List`, all the functions that `Data.List` exports become available in the global namespace. 

If we just need a couple of functions from a module, we can selectively import just those functions, for example, `import Data.List (nub, sort)`.

We can also choose to import all of the functions of a module except a few select ones. That's often useful when several modules export functions with the same name and we want to get rid of the offending ones, for example, `import Data.List hiding (nub)`.

Another way of dealing with name clashes is to do qualified imports. `import qualified Data.Map` makes it so that if we want to reference `Data.Map`'s `filter` function, we have to do `Data.Map.filter`, whereas just `filter` still refers to the normal `filter` we all know. However, typing out `Data.Map` in front of every function from that module is kind of tedious. That's why we can rename the qualified import to something shorter: `import qualified Data.Map as M`. Now, to reference `Data.Map`'s `filter` function, we just use `M.filter`.
## Input and Output

### Hello world
`putStrLn` takes a string and returns an I/O action that has a result type of `()`. An I/O action is something that, when performed, will carry out an action with a side-effect (that's usually either reading from the input or printing stuff to the screen) and will also contain some kind of return value inside it. Printing a string to the terminal doesn't really have any kind of meaningful return value, so a dummy value of `()` is used.

`main` always has a type signature of `main :: IO something`, where `something` is some concrete type. By convention, we don't usually specify a type declaration for `main`.

We can read `name <- getLine` like this: perform the I/O action getLine and then bind its result value to name. `getLine` has a type of `IO String`, so `name` will have a type of `String`. We can think of an I/O action as a box with little feet that will go out into the real world and do something there (like write some graffiti on a wall) and maybe bring back some data. Once it's fetched that data for us, the only way to open the box and get the data inside it is to use the `<-` construct. When we do `name <- getLine`, `name` is just a normal string, because it represents what's inside the box.

All `name = getLine` does is giving the getLine I/O action a different name called, well, `name`. Remember, to get the value out of an I/O action, you have to perform it inside another I/O action by binding it to a name with `<-`.

I/O actions will only be performed when they are given a name of `main` or when they're inside a bigger I/O action that we composed with a do block. We can also use a do block to glue together a few I/O actions and then we can use that I/O action in another do block and so on. Either way, they'll be performed only if they eventually fall into `main`.

In Haskell, every `if` must have a corresponding `else` because every expression has to have some sort of value. 

The `return` in Haskell is really nothing like the return in most other languages. In Haskell (in I/O actions specifically), it makes an I/O action out of a pure value. If you think about the box analogy from before, it takes a value and wraps it up in a box. The resulting I/O action doesn't actually do anything, it just has that value encapsulated as its result.

Using `return` doesn't cause the I/O do block to end in execution or anything like that.

### Files and streams
`getContents` is an I/O action that reads everything from the standard input until it encounters an end-of-file character. Its type is `getContents :: IO String`. What's cool about `getContents` is that it does lazy I/O. When we do `foo <- getContents`, it doesn't read all of the input at once, store it in memory and then bind it to `foo`.

`FilePath` is just a type synonym for `String`. `type FilePath = String`.

Note the difference between the handle used to identify a file and the contents of the file. The handle is just something by which we know what our file is. If we imagine our whole file system to be a really big book and each file is a chapter in the book, the handle is a bookmark that shows where we're currently reading (or writing) a chapter, whereas the contents are the actual chapter.

For text files, the default buffering is line-buffering usually. That means that the smallest part of the file to be read at once is one line. That's why in this case it actually reads a line, prints it to the output, reads the next line, prints it, etc. For binary files, the default buffering is usually block-buffering. That means that it will read the file chunk by chunk. The chunk size is some size that your operating system thinks is cool.

When we're doing line-buffering, the buffer is flushed after every line. When we're doing block-buffering, it's after we've read a chunk. It's also flushed after closing a handle. That means that when we've reached a newline character, the reading (or writing) mechanism reports all the data so far. 

### Randomness
Referential transparency means a function, if given the same parameters twice, must produce the same result twice. 

In Haskell, we can make a random number then if we make a function that takes as its parameter that randomness and based on that returns some number (or other data type).
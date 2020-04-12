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

### Bytestrings
Remember that `[1,2,3,4]` is syntactic sugar for `1:2:3:4:[]`. When the first element of the list is forcibly evaluated (say by printing it), the rest of the list `2:3:4:[]` is still just a promise of a list, and so on. 

Bytestrings are sort of like lists, only each element is one byte (or 8 bits) in size. The way they handle laziness is also different.

Strict bytestrings reside in `Data.ByteString` and they do away with the laziness completely. There are no promises involved; a strict bytestring represents a series of bytes in an array. You can't have things like infinite strict bytestrings. If you evaluate the first byte of a strict bytestring, you have to evaluate it whole.

The other variety of bytestrings resides in `Data.ByteString.Lazy`. They're lazy, but not quite as lazy as lists. Lazy bytestrings take a different approach — they are stored in chunks, each chunk has a size of 64K. So if we evaluate a byte in a lazy bytestring (by printing it or something), the first 64K will be evaluated. After that, it's just a promise for the rest of the chunks.

What's the deal with that `Word8` type? Well, it's like `Int`, only that it has a much smaller range, namely 0-255. It represents an 8-bit number. And just like Int, it's in the `Num` typeclass. For instance, we know that the value `5` is polymorphic in that it can act like any numeral type. Well, it can also take the type of `Word8`.

### Exceptions
Even though doing some logic in I/O is necessary (like opening files and the like), it should preferably be kept to a minimum. 

Pure functions are lazy by default, which means that we don't know when they will be evaluated and that it really shouldn't matter. However, once pure functions start throwing exceptions, it matters when they are evaluated. That's why we can only catch exceptions thrown from pure functions in the I/O part of our code. However, if we don't catch them in the I/O part of our code, our program crashes. The solution? Don't mix exceptions and pure code. Take advantage of Haskell's powerful type system and use types like `Either` and `Maybe` to represent results that may have failed.

How `IOError` type is implemented depends on the implementation of the language itself, which means that we can't inspect values of the type `IOError` by pattern matching against them, just like we can't pattern match against values of type `IO something`. We can use a bunch of useful predicates to find out stuff about values of type `IOError` , for example, `isDoesNotExistError` is a predicate over `IOErrors`, which means that it's a function that takes an `IOError` and returns a `True` or `False`, meaning it has a type of `isDoesNotExistError :: IOError -> Bool`.

Be sure to re-throw exceptions if they don't match any of our criteria, otherwise we're causing our program to fail silently in some cases where it shouldn't.
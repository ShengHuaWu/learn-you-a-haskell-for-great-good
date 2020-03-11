## Recursion
The fibonacci sequence is defined recursively. First, we define the first two fibonacci numbers non-recursively. We say that F(0) = 0 and F(1) = 1, meaning that the 0th and 1st fibonacci numbers are 0 and 1, respectively. Then we say that for any other natural number, that fibonacci number is the sum of the previous two fibonacci numbers. So F(n) = F(n-1) + F(n-2). That way, F(3) is F(2) + F(1), which is (F(1) + F(0)) + F(1). Because we've now come down to only non-recursively defined fibonacci numbers, we can safely say that F(3) is 2. Having an element or two in a recursion definition defined non-recursively (like F(0) and F(1) here) is also called the edge condition and is important if you want your recursive function to terminate.

Usually we define an edge case and then we define a function that does something between some element and the function applied to the rest. Usually the edge case is some scenario where a recursive application doesn't make sense. When dealing with lists, the edge case is most often the empty list. If we're dealing with trees, the edge case is usually a node that doesn't have any children.
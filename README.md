# Assignment 2: Classify
## abs.s
For cases less than zero, I store 0 - t0 into t0, achieving the effect of negation.
## argmax.s
This part requires a loop to traverse the entire array. If a larger value is found, it is stored as the maximum value. I convert the array index to an address by using a shift left by 2, which achieves the effect of multiplying the index by 4, and then add the starting address to get the target element's address.

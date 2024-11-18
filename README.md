# Assignment 2: Classify
## abs.s
For cases less than zero, I store 0 - t0 into t0, achieving the effect of negation.
## argmax.s
This part requires a loop to traverse the entire array. If a larger value is found, it is stored as the maximum value. I convert the array index to an address by using a shift left by 2, which achieves the effect of multiplying the index by 4, and then add the starting address to get the target element's address.
## relu.s
This function needs to traverse the entire array and replace any number less than 0 with 0.
## dot.s
To complete this part, I first wrote a multiplication function. It begins by XOR the two input integers and then left-shifting the result by 31 bits to determine the sign of the product. Next, it takes the absolute values of the two inputs and performs multiplication using a long-multiplication approach. This involves iterating through the LSB of the multiplier: if it is 1, the result is incremented by the multiplicand. The multiplier is then shifted right by one bit, and the multiplicand is shifted left by one bit, repeating until the multiplier becomes zero. In the end, adjust the product to the appropriate sign. 
As for the multiplication function, I used a5 and a6 as input/output because these registers are less commonly used. Which reduces the number of data exchanges with memory, improving performance.
In the dot function, this multiplication is used in two places: for calculating index * stride and for multiplying two elements.
## read_matrix.s and write_matrix.s
Both of these functions only require modifying the part with the mul instruction. I directly copied the multiplication function from dot.s for use.

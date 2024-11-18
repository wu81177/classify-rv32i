.globl dot

.text
# =======================================================
# FUNCTION: Strided Dot Product Calculator
#
# Calculates sum(arr0[i * stride0] * arr1[i * stride1])
# where i ranges from 0 to (element_count - 1)
#
# Args:
#   a0 (int *): Pointer to first input array
#   a1 (int *): Pointer to second input array
#   a2 (int):   Number of elements to process
#   a3 (int):   Skip distance in first array
#   a4 (int):   Skip distance in second array
#
# Returns:
#   a0 (int):   Resulting dot product value
#
# Preconditions:
#   - Element count must be positive (>= 1)
#   - Both strides must be positive (>= 1)
#
# Error Handling:
#   - Exits with code 36 if element count < 1
#   - Exits with code 37 if any stride < 1
# =======================================================
dot:
    li t0, 1
    blt a2, t0, error_terminate  
    blt a3, t0, error_terminate   
    blt a4, t0, error_terminate  

    li t0, 0            
    li t1, 0         

loop_start:
    bge t1, a2, loop_end
    # TODO: Add your own implementation
    # Load elements from arr0 and arr1
    mv a5, t1
    mv a6, a3 
    addi sp, sp, -4
    sw ra, 0(sp)
    jal start_mul
    lw ra, 0(sp)
    addi sp, sp, 4
    slli a5, a5, 2 
    add a5, a5, a0       
    lw t4, 0(a5)              # arr0[i * stride0]

    mv a5, t1
    mv a6, a4 
    addi sp, sp, -4
    sw ra, 0(sp)
    jal start_mul
    lw ra, 0(sp)
    addi sp, sp, 4
    slli a5, a5, 2 
    add a5, a5, a1       
    lw t5, 0(a5)               # arr1[i * stride1]

    mv a5, t4
    mv a6, t5
    addi sp, sp, -4
    sw ra, 0(sp)
    jal start_mul
    lw ra, 0(sp)
    addi sp, sp, 4

    # return
    add t0, t0, a5
    addi t1, t1, 1
    j loop_start

loop_end:
    mv a0, t0
    jr ra

error_terminate:
    blt a2, t0, set_error_36
    li a0, 37
    j exit

set_error_36:
    li a0, 36
    j exit

# multiplier (a5*a6; return a5)
start_mul:
    xor t6, a5, a6            # mul sign
    srli t6, t6, 31
    li t3, 0

    bge a5, zero, skip_0abs
    sub a5, zero, a5
skip_0abs:
    bge a6, zero, mul_loop
    sub a6, zero, a6

mul_loop:
    beq a6, zero, mul_end
    andi t2, a6, 1
    beq t2, zero, skip_accu

    add t3, t3, a5

skip_accu:
    slli a5, a5, 1
    srli a6, a6, 1
    j mul_loop

mul_end:
    beq t6, zero, positive
    sub t3, zero, t3
positive:
    add a5, zero, t3
    jr ra
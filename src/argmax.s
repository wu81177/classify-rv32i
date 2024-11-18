.globl argmax

.text
# =================================================================
# FUNCTION: Maximum Element First Index Finder
#
# Scans an integer array to find its maximum value and returns the
# position of its first occurrence. In cases where multiple elements
# share the maximum value, returns the smallest index.
#
# Arguments:
#   a0 (int *): Pointer to the first element of the array
#   a1 (int):  Number of elements in the array
#
# Returns:
#   a0 (int):  Position of the first maximum element (0-based index)
#
# Preconditions:
#   - Array must contain at least one element
#
# Error Cases:
#   - Terminates program with exit code 36 if array length < 1
# =================================================================
argmax:
    li t6, 1
    blt a1, t6, handle_error

    lw t0, 0(a0)

    li t1, 0
    li t2, 1
loop_start:
    # TODO: Add your own implementation
    bge t2, a1, loop_end
    slli t3, t1, 2
    add t3, t3, a0
    lw t3, 0(t3)
    slli t4, t2, 2
    add t4, t4, a0
    lw t4, 0(t4)
    bge t3, t4, after_compair
    addi t1, t2, 0
after_compair:
    addi t2, t2, 1
    j loop_start

loop_end:
    addi a0, t1, 0 
    jr ra


handle_error:
    li a0, 36
    j exit

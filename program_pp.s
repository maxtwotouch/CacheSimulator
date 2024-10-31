# 0 "asm.S"
# 1 "/src//"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 0 "<command-line>" 2
# 1 "asm.S"
.text
.global asm_function
.type asm_function, @function

asm_function:
    # Input: rdi = pointer to array, rsi = size of array

    # r8 will hold the size of the array - 1
    movq %rsi, %r8
    subq $1, %r8

    # r9 will be our outer loop counter, set it to 0
    xorq %r9, %r9

.outer_loop:
    # r10 will be our inner loop counter, set it to 0
    xorq %r10, %r10

.inner_loop:
    # calculate the offset for the current element (r10 * 4 since these are int (4 bytes))
    movq %r10, %r11
    shlq $2, %r11

    # load the current element and the next element
    movl (%rdi, %r11, 1), %eax
    movl 4(%rdi, %r11, 1), %ecx

    # compare the elements and swap if necessary
    cmpl %ecx, %eax
    jle .no_swap

    movl %ecx, (%rdi, %r11, 1)
    movl %eax, 4(%rdi, %r11, 1)

.no_swap:
    # increment the inner loop counter
    incq %r10

    cmpq %r8, %r10
    jge .outer_loop_done

    # repeat the inner loop
    jmp .inner_loop

.outer_loop_done:
    # increment the outer loop counter
    incq %r9

    cmpq %r8, %r9
    jl .outer_loop

    ret

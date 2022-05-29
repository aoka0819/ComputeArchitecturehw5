# This example demonstrates an implementation of  Multiply two polynomials with integer coefficients, 
# and find the sum of all coefficients of multiplication polynomial
# We provided three strings in global for simplify.
# The ouput of test pattern 1 should be => Product polynomial is: 5 + 10x^1 + 30x^2 + 26x^3 + 52x^4 + 24x^5
# The ouput of test pattern 2 should be => Product polynomial is: 1 + 3x^1 + 9x^2 + 15x^3 + 29x^4 + 43x^5 + 20x^6
# Reference link : https://www.geeksforgeeks.org/multiply-two-polynomials-2/

.data
.align 4
# test pattern 1
polynomialA: .word 5, 0, 10, 6
polynomialB: .word 1, 2, 4
ASize: .word 4
BSize: .word 3
# test pattern 2
# polynomialA: .word 1, 3, 7, 4
# polynomialB: .word 1, 0, 2, 5
# ASize: .word 4
# BSize: .word 4

str1: .string "Product polynomial is: "
str2: .string "x^"
str3: .string " + "
ans: .word 0, 0, 0, 0, 0, 0, 0, 0
# ans: .word 1, 1, 1, 1, 1, 1, 1, 1

.text
.global _start
# Start coding in the section below, don't change the values above #
_start:
    # print str1
    la a0, str1
    li a7, 4
    ecall

    la a5, ASize
    la a4, BSize
    lw a5, 0(a5)
    lw a4, 0(a4)

    mv t0, zero
    jal calci

continue:
    add a5, a4, a5
    addi a3, a5, -1

    # addi a0, a3, 0        # print_int ecall
    # addi a7, zero, 1        # add t1 value to print
    # ecall

    add t0, zero, zero
    jal print

    j end

calci:
    mv t1, zero
    jal calcj

calcj:
    la a2, polynomialA
    la a1, polynomialB
    slli t2, t0, 2   # A[i] + addr
    slli t3, t1, 2   # B[j] + addr
    add a2, a2, t2
    add a1, a1, t3
    lw a2, 0(a2)    # A[i]
    lw a1, 0(a1)    # B[j]

    add t2, t0, t1
    slli t2, t2, 2
    la a0, ans
    add a0, a0, t2  # ans[i+j]
    mul a1, a1, a2
    lw a2, 0(a0)
    add a1, a1, a2
    sw a1, 0(a0)

    addi t1, t1, 1
    blt t1, a4, calcj
    jal judge

judge:
    addi t0, t0, 1
    blt t0, a5, calci
    jal continue

print:
    la a5, ans
    slli a4, t0, 2
    add a5, a5, a4

    lw a0, 0(a5)
    li a7, 1
    ecall

    bne t0, zero, L1
    addi t1, a3, -1
    bne t0, t1, L2
    jal L0

L0:
    addi t0, t0, 1
    blt t0, a3, print
    j end

L1:
    la a0, str2
    li a7, 4
    ecall
    mv a0, t0
    li a7, 1
    ecall
    addi t1, a3, -1
    bne t0, t1, L2
    jal L0

L2:
    la a0, str3
    li a7, 4
    ecall
    jal L0

end:nop
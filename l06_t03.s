/*
-------------------------------------------------------
l06_t03.s
-------------------------------------------------------
Author:Benjamin Okojie
ID:169075607
Email: okoj5607@mylaurier.ca
Date:    2025-03-07
-------------------------------------------------------
Working with stack frames.
Finds the common prefix of two null-terminate strings.
-------------------------------------------------------
*/
// Constants
.equ SIZE, 80

.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

//=======================================================

// push parameters onto the stack
mov r1, #SIZE
stmfd sp!, {r1}
ldr r1, =Common
stmfd sp!,{r1}
ldr r1, =Second
stmfd sp!, {r1}
ldr r1, =First
stmfd sp!, {r1}

//=======================================================

bl     FindCommon

//=======================================================
add sp, sp, #12
// clean up stack

//=======================================================

_stop:
b      _stop

//-------------------------------------------------------
FindCommon:
/*
-------------------------------------------------------
Equivalent of: FindCommon(*first, *second, *common, size)
Finds the common parts of two null-terminated strings from the beginning of the
strings. Example:
first: "pandemic"
second: "pandemonium"
common: "pandem", length 6
-------------------------------------------------------
Parameters:
  first - pointer to start of first string
  second - pointer to start of second string
  common - pointer to storage of common string
  size - maximum size of common
Uses:
  r0 - address of first
  r1 - address of second
  r2 - address of common
  r3 - value of max length of common
  r4 - character in first
  r5 - character in second
-------------------------------------------------------
*/

//=======================================================

// prologue: save registers and get parameters from stack
stmfd sp!, {fp}
mov fp, sp
sub sp, sp, #8
stmfd   sp!, {r0-r5} 
ldr     r0, [fp, #4]    // get address of first 
ldr     r1, [fp, #8]    // get address of second
ldr     r2, [fp, #12]    // get common address
ldr     r3, [fp, #16]    // get size
//=======================================================


FCLoop:
cmp    r3, #1          // is there room left in common?
beq    _FindCommon     // no, leave subroutine
ldrb   r4, [r0], #1    // get next character in first
ldrb   r5, [r1], #1    // get next character in second
cmp    r4, r5
bne    _FindCommon     // if characters don't match, leave subroutine
cmp    r5, #0          // reached end of first/second?
beq    _FindCommon
strb   r4, [r2], #1    // copy character to common
sub    r3, r3, #1      // decrement space left in common
b      FCLoop

_FindCommon:
mov    r4, #0
strb   r4, [r2]        // terminate common with null character

//=======================================================
ldmfd sp!,{r0-r5}
add sp,sp,#8
ldmfd sp!, {fp}
bx lr
// epilogue: clean up stack and return from subroutine

//=======================================================

//-------------------------------------------------------
.data
First:
.asciz "pandemic"
Second:
.asciz "pandemonium"
Common:
.space SIZE

.end
Apollo

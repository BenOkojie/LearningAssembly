/*
-------------------------------------------------------
l05_t01.s
-------------------------------------------------------
Author:Benjamin Okojie
ID:169075607
Email:okoj5607@mylaurier.ca
Date:    2024-02-21
-------------------------------------------------------
Does a running total of an integer list.
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

ldr    r1, =Data    // Store address of start of list
ldr    r2, =_Data   // Store address of end of list
bl     list_total   // Call subroutine - total returned in r0

_stop:
b      _stop

//-------------------------------------------------------
list_total:
/*
-------------------------------------------------------
Totals values in a list.
Equivalent of: int total(*start, *end)
-------------------------------------------------------
Parameters:
  r1 - start address of list
  r2 - end address of list
Uses:
  r3 - temporary value
Returns:
  r0 - total of values in list
-------------------------------------------------------
*/

// your code here
list_total:
stmfd   sp!, {r1,r2}
mov    r0 , #0
b Loop 

Loop:
ldr    r3, [r1], #4 // Read address with post-increment (r0 = *r2, r2 += 4)
add r0,r0,r3
cmp    r2, r1       // Compare current address with end of list
bne    Loop         // If not at end, continue
ldmfd   sp!, {r1,r2}    // pop preserved registers
bx LR

.data
.align
Data:
.word   4,5,-9,0,3,0,8,-7,12    // The list of data
_Data: // End of list address

.end
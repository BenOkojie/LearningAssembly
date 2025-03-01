/*
-------------------------------------------------------
OKOJ5607_A2.s
-------------------------------------------------------
Author:Benjamin Okojie
ID:169075607
Email:okoj5607@mylaurier.ca
Date:    2024-02-28
-------------------------------------------------------
-------------------------------------------------------
*/
.org 0x1000 // Start at memory location 1000
.text           // Code section
.global _start
_start:

ldr    r2, =Data    // Store address of start of list
ldr    r3, =_Data   // Store address of end of list
ldr    r4, =ASCII    // Store address of start of list
LDR    r5, =0x1500 


Loop:
ldr    r0, [r2], #4 
mov    r6, #4
mul    r0, r0, r6
add    r1,r4,r0
ldrb   r7,[r1]
strb   r7, [r5], #1
cmp    r3, r2 
bne    Loop         // If not at end, continue   
_stop:
b _stop

.data
.align
Data:
.word   0xA, 0xB, 0xC, 0x1, 0x2, 0x4, 0x9, 0x3 
.word   0xD, 0xF, 0xE, 0x7, 0x5, 0x6, 0x8, 0x0 
_Data: // End of list address

ASCII:
.byte 0x30,0x31,0x32,0x33,0x34,0x35,0x36,0x37
.byte 0x38,0x39,0x41,0x42,0x43,0x44,0x45,0x46
_ASCII: // End of list address
.end
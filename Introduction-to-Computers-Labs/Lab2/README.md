Lab 2: Parity Zeros Function in Assembly
Overview:
In this lab, we wrote a function in Assembly that calculates the number of zero bits in each element of an ID array and stores the result in a Parity Zeros array. The task was implemented using the IAR Embedded Workbench.

Key Steps:
Define Arrays in RAM:

ID1, ID2: Arrays containing identification numbers.
ParityZeros1, ParityZeros2: Arrays to store the number of zero bits in the corresponding IDs.
Function Implementation:

ParityZerosFunc(ID[], size, ParityZeros[]): Calculates and stores the count of zero bits in each ID element.
The function is called twice, once for ID1 and once for ID2.
Debug and Verify:

Use the IAR simulator to run and check the program.
Files:
task2.s43: Assembly code implementing the function.

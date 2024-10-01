# Lab 1: Assembly Language - Comparing ID Arrays

### Overview:
This lab implements an assembly program to compare two arrays of identification numbers (ID1 and ID2) and calculates the number of differing bits between corresponding elements.

### Task Definition:
- Define two ID arrays, `ID1` and `ID2`, each of length 8.
- Create a RAM array, `Different_indices_amount`, to store the count of differing indices:
  \[
  \forall i \in [0, 7]: \quad \text{Different_indices_amount}[i] = \text{Count of differing bits between } ID1[i] \text{ and } ID2[i]
  \]
  
#### Example:
For:
```
ID1[8] = {1, 2, 3, 4, 5, 6, 7, 8}
ID2[8] = {8, 7, 6, 5, 4, 3, 2, 1}
```
The value for `Different_indices_amount[7]` is:
```
Different_indices_amount[7] = 0x0002 = 2
```
This is because the binary representations differ in two bits.

### Implementation Details:
- **Main**: Moved data from memory to registers:
  - `R4`: Size of the arrays.
  - `R5`, `R6`: Pointers to each ID array.
  - `R7`: Pointer to the result array.
  - `R10`: Register for summing bits.

- **Loop**: For each index, decremented the counter, loaded corresponding values into registers, and performed XOR to find differing bits.

- **SumOnes**: Shifted the number right and summed the LSB until all bits were processed.

- **ArrAdd**: Stored the sum of differing bits in the result array and advanced the index.

### Size of the Program:
- Size = \(0x212E - 0x2100 = 0x002E = 46\) (decimal)

### Runtime:
- \( \text{runtime} = 264 \times T_{MCLK} = 264 \times 2^{-20} \approx 2.5177 \times 10^{-4} \text{ seconds} \)

### Files:
- `task1.s43`: Source code implementing the comparison logic.

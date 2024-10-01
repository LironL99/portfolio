# Lab 2: Assembly Language - Parity Zeros Function

### Overview:
This lab implements an assembly program to calculate the number of zero bits in each element of two identification arrays (`ID1` and `ID2`) and stores the results in two separate arrays (`ParityZeros1` and `ParityZeros2`).

### Task Definition:
- Define two ID arrays, `ID1` and `ID2`, each of length 8.
- Create two RAM arrays, `ParityZeros1` and `ParityZeros2`, to store the number of zero bits:
  
  ```
  ParityZeros1 DS16 8
  ParityZeros2 DS16 8
  ```

- Implement the following function:
  
  \[
  \text{ParityZerosFunc}(int ID[], int size, int ParityZero[])
  \]

- The function calculates the count of zero bits for each ID element:

  \[
  \forall i \in [0, 7]: \quad \text{ParityZeros}[i] = \text{Number of zeros in } ID[i]
  \]

- Call the function twice in the main program:
  ```
  ParityZerosFunc(ID1, IDsize, ParityZeros1);
  ParityZerosFunc(ID2, IDsize, ParityZeros2);
  ```

### Implementation Details:
- **Main**: Loaded data into the stack (result array pointer, array size, and ID array pointer) and called the function twice, once for each ID.
  
- **ParityZerosFunc**:
  - Retrieved values from the stack into registers.
  
- **Loop**: For each iteration, decremented the counter and loaded the corresponding value into register `R8`.
  - After completing iterations, executed the `RET` instruction to finish the function.
  
- **SumOnes**: Shifted the number right to sum the least significant bit (LSB) until all bits were processed, resulting in the count of zeros in register `R9`.
  
- **ArrAdd**: Calculated the number of zeros by taking the two's complement of `R9` and subtracted it from 16 (the total bits) to find the number of zeros, storing the result in the appropriate index of the result array.

### Size of the Program:
- Size = \(0x2158 - 0x2100 = 0x0058 = 88\) (decimal)

### Runtime:
- \[
\text{runtime} = 575 \times T_{MCLK} = 575 \times 2^{-20} \approx 5.4836 \times 10^{-4} \text{ seconds}
\]

### Files:
- `task2.s43`: Source code implementing the parity zeros calculation.

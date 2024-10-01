# Lab 4: Interrupt GPIO

### Overview:
This lab implements an interrupt-driven program for GPIO that generates a square wave signal using the function `void bip(int delay_sec)`.

### Task Definition:
- Define the function:
  
```
void bip(int delay_sec)
```

- This function takes a value in seconds as an argument and generates a square wave signal at a frequency of **2 kHz** for the duration of `delay_sec` seconds. Precision is important; check the quality of the output using an oscilloscope.
- The function `bip` must rely on appropriate functions from the HAL layer.

- Add the following section to the menu in the original requirements:

When pressing button `PB3`, the system generates a square wave signal (Duty Cycle = 50%) on pin `P2.7` at a frequency of \( f = 2 kHz \) according to the call to `bip(5)`, meaning it lasts for **5 seconds**.

### Implementation Details:
- **Main**: Checked the current state, and when the button `PB3` was pressed, ensured that other interrupts did not interfere. Cleared the LED display, pushed the function value onto the stack, and called the wave function from the API layer. After completing this operation, called the action that resets the flag and returned to sleep mode.

- **API**: Cleared pin `P2.7`, retrieved the function value from the stack, and executed a loop that loads the number of cycles into register `R7`.

- **PWMLoop2**: Built a loop based on `R7`.
  - Toggled the bit in `P2.7` and called the **Delay** function. Toggled the bits again and called the **Delay** function once more.
  - After finishing the number of cycles, returned to **MAIN**.

#### Building the Wave:
- Initially, calculated the period of the given frequency:
  
```
T = 1/f = 1/(2.5*10^3) = 0.4*10^(-3)
```

- Determined `T1` using the DC ratio.
- Checked how many cycles were required for `T1`; each cycle is:
  
```
Cycle = 1/2^20
```

- Subtracted the cycles used for assignments and checks; remaining cycles were utilized with the **Delay** function.
- Performed similar calculations for the complement of the time for DC.

- **HAL**: Managed the port hierarchy. Checked which button was pressed and accordingly determined which interrupt to execute.

### Size of the Program:
- Size = \(0xC1F2 - 0xC020 = 0x01D2 = 466\) (decimal)

### Files:
- `api`: Source code for the API layer.
- `bsp`: Source code for the Board Support Package.
- `hal`: Source code for the Hardware Abstraction Layer.
- `main.s43`: Main source code implementing the interrupt-driven GPIO functionality.

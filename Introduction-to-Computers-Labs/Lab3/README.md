# Lab 3: GPIO (General Purpose Input Output)

### Overview:
This lab implements PWM signal output and wave generation using GPIO pins in the IAR Embedded Workbench.

### Task Definition:
Add one of the following options to the menu while ensuring the original menu requirements remain intact:

#### Option 1 (100 points):
- When `SWstate = 0x05`, the program generates a PWM signal on pin `P7.1` at a frequency of **0.8 kHz** with **25% DC** for **5 seconds**, then switches to **1.6 kHz** with **75% DC** for **5 seconds**, and repeats this cycle. 
- Ensure the signal frequency is maximally resolved, accurately measured using an oscilloscope.
- Use the cycle counter to calculate clock cycles needed for execution (including code delays and condition checks).

#### Option 2 (90 points):
- When `SWstate = 0x05`, display each digit of the ID values on the LEDs, with a **1-second** delay between each digit, referencing a 16-element array.

### Implementation Details:
- **Main**: Configured `P1` as input and `P2` as output.
- **Check**: Checked switch states and called the appropriate function.

#### Building the Wave:
- Calculated the period of the given frequency:
  \[
  T = \frac{1}{f} = \frac{1}{0.8 \times 10^3} = 1.25 \times 10^{-3} \text{ seconds}
  \]

- Determined the cycles required for `T1`. Each cycle is:
  \[
  \text{Cycle} = \frac{1}{2^{20}}
  \]

- Subtracted the cycles used for assignments and checks; remaining cycles were used with the **Delay** function.

- **WAVE1**: Created a loop running 4000 times for a 5-second wave. 
  - Toggled bit `1.7 P` and called the **Delay** function. Checked switch states after 5 seconds before switching to **WAVE2**.

- **WAVE2**: Created a loop running 8000 times for another 5-second wave.
  - Toggled bit `1.7 P`, called the **Delay** function, and checked switch states before switching back to **WAVE1**.

- **Delay**: Ran a loop for the required delay time, burning cycles to maintain the required DC ratio.

### Size of the Program:
- Size = \(0xC16E - 0xC020 = 0x014E = 334\) (decimal)

### Files:
- `task3.s43`: Source code implementing the PWM functionality.

# Lab 3: GPIO (General Purpose Input Output)

### Overview:
This lab implements a PWM signal output using GPIO pins in the IAR Embedded Workbench.

### Task Definition:
- Output a PWM signal on pin `P7.1` at **0.8 kHz** with a **25% duty cycle** for **5 seconds**, then switch to **1.6 kHz** with a **75% duty cycle** for **5 seconds**.

### Implementation Details:
The program is divided into several parts:
- **Main**: Configured `P1` as input and `P2` as output.
- **Check**: Checked the state of the switches and called the appropriate function.
- **Building the Wave**:
  - Calculated the period of the given frequency:
    \[
    T = \frac{1}{f} = \frac{1}{10.8 \times 10^3} = 1.25 \times 10^{-3} \text{ seconds}
    \]
  - Determined \( T1 \) using the DC ratio and calculated the cycles needed for \( T1 \). Each cycle is 1220.
  - Subtracted the cycles used for assignments and checks, using the remaining cycles with a **Delay** function.
  - Similar calculations were done for the remaining time for DC.

- **WAVE1**: Built a loop running 4000 times for a 5-second wave.
  - Toggled bit `1.7 P` and called the **Delay** function, checked switch states, and after 5 seconds, switched to **WAVE2**.

- **WAVE2**: Built a loop running 8000 times for another 5-second wave.
  - Toggled bit `1.7 P`, called the **Delay** function, checked switch states, and switched back to **WAVE1** after 5 seconds.

- **Delay**: Ran a loop for the required delay time, burning cycles to maintain the required DC ratio.

### Size of the Program:
- Size = \(0xC16E - 0xC020 = 0x014E = 334\) (decimal)

### Files:
- `task3.s43`: Source code implementing the PWM functionality.

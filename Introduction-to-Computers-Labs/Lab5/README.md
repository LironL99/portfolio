# Lab 5: Real-Time Experiment - Interrupt GPIO

### Overview:
This lab implements an interrupt-driven program that generates a square wave signal based on user input using GPIO.

### Task Definition:
- Connect button `PB2` to pin `P2.3`.
- In the APP layer, define the helper array `DutyCycle` of size 11, containing values corresponding to Duty Cycle from 0% to 100% in 10% increments.

- Add the following section to the menu in the original requirements:

When button `PB2` is pressed (3state = 1):
- The system generates a signal from pin `P2.2` at a frequency of \( f = 2 kHz \) with a changing Duty Cycle in a circular manner every **75 seconds** based on the given array.

- The mode is defined to end upon pressing another mode button. The signal generation must be performed using Output Compare mode, utilizing Timer_A1 for the MSP430x2xx family and Timer_B for the MSP430x4xx family.

### Implementation Details:
- **Main**: Checks the current state. When button `PB3` is pressed, raises a flag indicating state 3, transfers the starting address of the array to `R13`, and calls the function that starts both timers.

- **HAL**: In the TimerA0 core interrupt, checks if the input came from button 1 or 3. If from button 3, verifies if there are remaining values in the array. If yes, changes the Duty Cycle and advances the pointer to the next address in the DC array. If not, calls the function that stops both timers.

- **BSP**: Configured pin `P2.2` to output the wave in Compare mode.
  
  - **StartPB3**: Configured TimerA0 to be SMCLK, with rising and falling edge mode, initializing the value. Set the value `CCCC` to the TimerA0 envelope register to cause a core interrupt every **0.75 seconds**. Configured TimerA1 to be SMCLK, setting the value `552` to TimerA1 envelope register to determine the cycle time and frequency. Finally, configured TimerA1 envelope 1 to Reset/set.

- **StopPB3**: Configured TimerA0 to be SMCLK, stop mode, and initialized the value. Configured TimerA1 to be SMCLK, stop mode, and initialized the value.

### Size of the Program:
- Size = \(0xC600 - 0xC020 = 0x05E0 = 1504\) (decimal)

### Files:
- `main.s43`: Main source code.
- `hal.s43`: Source code for the Hardware Abstraction Layer.
- `bsp.s43`: Source code for the Board Support Package.
- `api.s43`: Source code for the API layer.

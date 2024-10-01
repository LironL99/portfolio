# Lab 6: Real-Time Experiment - ADC with GPIO

### Overview:
This lab implements an interrupt-driven program that dynamically prints the minimum and maximum voltage values sampled from a signal generator to an LCD.

### Task Definition:
- Connect button `PB2` to pin `P1.4`.
- Add the following section to the menu in the original requirements:

When button `PB2` is pressed (3state = 1):
- The system continuously prints the values of \( V_{min} \) and \( V_{max} \) of the sampled voltage from the generator dynamically on the LCD screen, updating these values according to changes in the generator's output without displaying a history of measurements or noise (consider changes of more than ±3Δv). The measured voltage values should have a precision of 2 decimal places, using fixed-point representation in Q format based on your engineering judgment.

### Implementation Details:
- **Main**: Checked the current state. When button `PB2` is pressed, raised a flag indicating state 3 and called the API function.

- **API**: Sampled 9000 samples. For each sample, compared it with a variable in memory holding the current minimum and maximum values. If the sample is greater than the maximum, updated the maximum variable; similarly, if the sample is less than the minimum, updated the minimum variable. After 9000 samples, stopped the ADC, converted the values to volts, and printed the minimum and maximum values on the LCD.

- **HAL**: Built a function to print the voltage value on the screen.

- **BSP**: Configured the ADC so that `P1.3` receives the sample. When pressing button `PB2` for sampling, set `ENC` to 0, then configured `ADC10CTL0` for the appropriate task. Returned `ENC` to 1, enabled the interrupt, and started the conversion. To stop sampling, set `ENC` to 0, returned `ADC10CTL0` to the configuration for other tasks, returned `ENC` to 1, disabled the interrupt, and stopped the converter.

### Size of the Program:
- Size = \(0xCFCC - 0xC020 = 0x0FAC = 4012\) (decimal)

### Files:
- `main.s43`: Main source code.
- `hal.s43`: Source code for the Hardware Abstraction Layer.
- `bsp.s43`: Source code for the Board Support Package.
- `api.s43`: Source code for the API layer.

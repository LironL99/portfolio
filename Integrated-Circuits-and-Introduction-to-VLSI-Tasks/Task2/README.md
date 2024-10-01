# Task 2: MUX and Barrel Shift Register Construction

### Task Overview
This task involves the construction and simulation of a MUX and a Barrel Shift Register using Cadence Virtuoso.

### Part A: Building the MUX
1. **Schematic Design and Testing**:
   - A 1x2 MUX was implemented using the complementary MOS (CMOS) method.
   - A schematic of the MUX was created, ensuring optimal beta calculated for the NMOS default transistor.
   - A test bench (TB) was constructed, applying different logical signals (0 and 1) to the MUX inputs.
   - Simulations were run with a square wave input at 1 MHz and an output capacitance of 100 fF. The order of inputs was changed, and the results were analyzed for correctness.

2. **Performance Measurements**:
   - The overall T_pd and T_pHL delays of the MUX were measured.
   - Documentation of the measurement process was included, detailing how the values were obtained.

3. **Layout Design and Testing**:
   - A layout for the MUX was created following the DRC requirements and ensuring the minimization of layout area.
   - LVS checks were performed, with the results included in the report.
   - PEX was executed to validate the layout, and simulations were conducted to compare parameters before and after PEX.

### Part B: Building the 8-bit Barrel Shift Register
1. **Theoretical Background and Preparation**:
   - A Barrel Shift Register was designed to perform X-shift operations on a given bit sequence.
   - The design utilized 1x2 MUX components to implement the Barrel Shift functionality, with a schematic representation provided.

2. **Schematic Design and Testing**:
   - The designed schematic was implemented and a symbol for the register was created.
   - A test bench was constructed with binary inputs corresponding to the group number, and simulations were conducted to verify the correct operation of the register.

3. **Performance Measurements**:
   - The T_pd and T_pHL delays were measured for different configurations of the register.
   - The methodology for obtaining these measurements was documented in detail.

4. **Layout Design and Testing**:
   - A layout for the Barrel Shift Register was created, ensuring compliance with DRC and LVS requirements.
   - PEX validation was performed, followed by simulations that compared the performance before and after PEX.

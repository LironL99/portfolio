# Task 1: Basic Simulations and Inverter Construction

## Course Information
**Course Title**: Introduction to VLSI and Integrated Circuits (361-1-3701)  
**Instructor**: Dr. Artur Spivak  
**Submission Date**: [Insert date here]  

### Task Overview
This task involves performing basic simulations, familiarizing with tools, and constructing an inverter.

### Requirements:
1. **Documentation**:
   - The group number is clearly stated at the top of the report.
   - Schematics and circuit diagrams, along with a testbench, are included.
   - Simulations and graphs are provided with brief explanations, ensuring that the graphs are clear and readable.
   - Calculations and formulas for any mathematical computations are included.
   - Each step taken during the task is documented for clarity and understanding.
   - The first page contains the task name, group number, partner names (including Noam Yahav) with ID numbers, and submission date.

### Part A: Understanding Devices
- Devices with minimum length and width were used, calculated using the formula: \( W = (10G \times (420)) \, \text{nm} \).
- IV curves for basic devices were generated using the PDK.
- A schematic with NMOS and PMOS transistors was created, with voltage sources connected to gates and drains.
- A DC Sweep simulation was run on \( V_{DS} \) and \( V_{GS} \), documenting \( I_{DS} \) for both types of transistors.
- The threshold voltage \( V_{T} \) for each transistor was calculated and documented.

### Part B: Inverter Construction
- A schematic of an inverter was designed, and simulations were run to achieve optimal performance.
- \( T_{pHL} \) and \( T_{pLH} \) delays were measured and reported.
- For the layout design, symbols for the inverter were created, the layout was drawn, and DRC issues were ensured to be absent before conducting LVS.

### Part C: Buffer Construction
- Two schematics for the buffer were designed: one implemented with transistors and the other using the inverters created earlier.
- Symbols for both cells were created, and simulation results were displayed.

### Collaboration
Collaboration with a partner throughout this task enhanced the understanding of VLSI design and simulation.

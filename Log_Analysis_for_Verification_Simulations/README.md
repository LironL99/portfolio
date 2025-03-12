# Log Analysis for Verification Simulations

## Why This Project Matters
This project automates the analysis of verification simulation logs, reducing manual debugging time and improving failure detection. The tool efficiently processes logs to extract critical insights, enabling engineers to optimize their verification processes.

## Overview
This Python-based tool analyzes log files from verification simulations, providing:
- Detection of INFO, WARNING, and ERROR messages per test
- Runtime analysis of each test
- Identification of common errors and warnings
- Detection of unusual test runtime outliers

## How to Use
### 1. Prerequisites
- Python 3.x installed
- A simulation log file (e.g., `simulation_log_extended.txt`) in the workspace

### 2. Running the Script
Place the `simulation_log_extended.txt` file in the same directory as the script, then run:
```bash
python Log_Analysis.py
```

### 3. Example Output
```
Most Common Errors:
Assertion failed at module 'ALU'.: 7 occurrences
Register write collision detected.: 7 occurrences
Stack overflow detected in function call.: 5 occurrences
Memory corruption detected at address 0x1ACF.: 4 occurrences
Critical bus contention error.: 4 occurrences

Most Common Warnings:
Timing violation at register interface.: 8 occurrences
Potential deadlock detected in pipeline.: 7 occurrences
Voltage fluctuation detected.: 7 occurrences
Unaligned memory access detected.: 7 occurrences
High temperature warning on core.: 4 occurrences

Test Summary:
Test 001: Infos=2, Errors=1, Warnings=0, Runtime=33.7 sec
Test 002: Infos=2, Errors=1, Warnings=1, Runtime=39.1 sec
Test 003: Infos=2, Errors=1, Warnings=1, Runtime=86.3 sec
...
Outlier Tests (Unusual Runtime): ['003', '015', '033']
```

## Key Features
- 🚀 **Automated Log Parsing:** Extracts and organizes log data efficiently.
- 📊 **Graphical Visualization:**
  - Bar charts for errors and warnings per test.
  - Runtime analysis with outlier detection.
  - Scatter plot for identifying unusual runtime trends.
- ⚠ **Intelligent Failure Detection:** Automatically flags tests with significant performance deviations.
- 🔍 **Common Error Analysis:** Identifies recurring failures in multiple tests.

## Visualization Examples
The script generates the following graphs:
1. **Errors and Warnings per Test:**
   - Bar chart displaying the number of errors and warnings per test.
2. **Test Runtime Analysis:**
   - Bar chart showing the runtime of each test.
3. **Runtime Outlier Detection:**
   - Scatter plot highlighting tests with significantly higher runtime.

## Why It Stands Out
This tool enhances verification efficiency by automating log analysis and failure detection. Engineers can use it to pinpoint recurring issues, optimize test performance, and streamline debugging processes.

## Next Steps
- Expand support for additional log formats.
- Implement trend analysis for recurring failures.
- Develop automated alert mechanisms for critical failures.

## Contact
For any questions or contributions, feel free to reach out!

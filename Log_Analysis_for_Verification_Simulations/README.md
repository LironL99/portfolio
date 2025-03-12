# Log Analysis for Verification Simulations

## Overview
This project provides an automated Python script to analyze simulation log files from verification processes. The script extracts and summarizes key information, including:
- Number of INFO, WARNING, and ERROR messages per test
- Runtime of each test
- Summary of errors and warnings
- Identification of tests with unusual runtime outliers

## How to Use
### 1. Prerequisites
- Python 3.x installed
- A simulation log file (e.g., `simulation_log_high_anomalies.txt`) in the workspace

### 2. Running the Script
Place the `simulation_log_high_anomalies.txt` file in the same directory as the script, then run:
```bash
python Log_Analysis.py
```

### 3. Example Output
```
Test Summary:
Test 001: Infos=2, Errors=1, Warnings=1, Runtime=16.9 sec
Test 002: Infos=2, Errors=0, Warnings=1, Runtime=7.4 sec
Test 003: Infos=2, Errors=1, Warnings=1, Runtime=21.7 sec
Test 004: Infos=2, Errors=1, Warnings=1, Runtime=34.5 sec
Test 005: Infos=2, Errors=1, Warnings=1, Runtime=34.7 sec
...
Outlier Tests (Unusual Runtime): ['015', '019', '029']
```

## Features
- **Detailed Log Parsing:** Extracts test IDs, message types, and runtimes
- **Graphical Visualization:**
  - Bar charts for errors and warnings per test
  - Runtime analysis with outlier detection
  - Scatter plot for identifying unusual runtime trends
- **Automated Outlier Detection:** Identifies tests with significantly higher runtime using statistical thresholds

## Visualization Examples
The script generates the following graphs:
1. **Errors and Warnings per Test:**
   - Bar chart displaying the number of errors and warnings per test.
2. **Test Runtime Analysis:**
   - Bar chart showing the runtime of each test.
3. **Runtime Outlier Detection:**
   - Scatter plot highlighting tests with significantly higher runtime.

## Next Steps
- Enhance log processing for different log formats.
- Implement trend analysis for recurring failures.
- Automate alerts for critical failures.

## Contact
For any questions or contributions, feel free to reach out!

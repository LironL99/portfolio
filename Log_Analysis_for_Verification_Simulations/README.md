# Log Analysis for Verification Simulations

## Why This Project Matters
This project demonstrates the ability to **automate verification log analysis** efficiently, reducing manual debugging time and improving failure detection in simulation processes. The script is designed to help hardware verification engineers quickly identify problematic tests and optimize runtime performance.

## Overview
This Python-based tool automates the analysis of log files from verification simulations. The script extracts and summarizes key insights, including:
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

## Key Features
- 🚀 **Automated Log Parsing:** Extracts and organizes log data efficiently.
- 📊 **Graphical Visualization:**
  - Bar charts for errors and warnings per test.
  - Runtime analysis with outlier detection.
  - Scatter plot for identifying unusual runtime trends.
- ⚠ **Intelligent Failure Detection:** Automatically flags tests with significant performance deviations.

## Visualization Examples
The script generates the following graphs:
1. **Errors and Warnings per Test:**
   - Bar chart displaying the number of errors and warnings per test.
2. **Test Runtime Analysis:**
   - Bar chart showing the runtime of each test.
3. **Runtime Outlier Detection:**
   - Scatter plot highlighting tests with significantly higher runtime.

## Why It Stands Out
This tool is not just about parsing logs—it provides **actionable insights** that help engineers optimize their verification workflow. By automating failure detection and performance tracking, it reduces debugging time and enhances efficiency in hardware verification environments.

## Next Steps
- Expand support for additional log formats.
- Implement advanced trend analysis for recurring failures.
- Develop automated alert mechanisms for critical failures.

## Contact
For any questions or contributions, feel free to reach out!

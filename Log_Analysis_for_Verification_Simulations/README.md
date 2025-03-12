# Log Analysis for Verification Simulations

## Overview
This project provides an automated Python script to analyze simulation log files from verification processes. The script extracts and summarizes key information, including:
- Number of INFO, WARNING, and ERROR messages per test
- Runtime of each test
- Summary of errors and warnings

## How to Use
### 1. Prerequisites
- Python 3.x installed
- A simulation log file (e.g., `simulation_log.txt`) in the workspace

### 2. Running the Script
Place the `simulation_log.txt` file in the same directory as the script, then run:
```bash
python Log_Analysis.py
```

### 3. Example Output
```
Test Summary:
Test 001: Infos=2, Errors=1, Warnings=1, Runtime=7.2 sec
Test 002: Infos=3, Errors=1, Warnings=1, Runtime=11.3 sec
Test 003: Infos=3, Errors=1, Warnings=0, Runtime=8.5 sec
```

## Next Steps
- Expand the log file with more test cases.
- Implement graphical visualization for log analysis.
- Optimize performance for large log files.

## Contact
For any questions or contributions, feel free to reach out!

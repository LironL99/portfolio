# Log Analysis and Automated Alerts System

## Overview
This project automates the analysis of verification simulation logs, providing insights into errors, warnings, and runtime anomalies. It also generates comprehensive reports (PDF & HTML) and sends email alerts for critical issues.

## Features
✅ **Log Parsing & Analysis** – Extracts and categorizes INFO, WARNING, and ERROR messages from logs.  
✅ **Runtime Anomaly Detection** – Identifies test cases with unusually long runtimes.  
✅ **Graphical Visualization** – Generates bar charts and scatter plots for insights.  
✅ **Automated Report Generation** – Creates professional reports in PDF and HTML formats.  
✅ **Email Notifications** – Sends alerts when test failures exceed thresholds, attaching reports.  
✅ **Alert Logging** – Saves all triggered alerts in `alerts.log`.  
✅ **Threshold-Based Alert System** – Alerts are triggered when errors exceed a set threshold or runtime anomalies are detected.  
✅ **Fully Configurable Email System** – Uses SMTP for automated email notifications.  

## How It Works
1. **Run the script:**
   ```bash
   python Log_Analysis.py
   ```
2. **The script performs:**
   - Log parsing and message categorization.
   - Statistical analysis of recurring errors/warnings.
   - Runtime outlier detection using statistical thresholds.
   - Report generation (PDF & HTML) including visual graphs.
   - Email notifications with attached reports.
   - Logs all triggered alerts into `alerts.log`.

## Example Output
```
Most Common Errors:
- Memory corruption detected at address 0x1ACF (4 occurrences)
- Assertion failed at module 'ALU' (7 occurrences)

Most Common Warnings:
- Timing violation at register interface (8 occurrences)
- Voltage fluctuation detected (7 occurrences)

Test Summary:
Test 001: Infos=2, Errors=1, Warnings=0, Runtime=33.7 sec
Test 002: Infos=2, Errors=1, Warnings=1, Runtime=39.1 sec
...
Outlier Tests: ['003', '015', '033']
```

## Reports & Alerts
- **Generated Reports:**
  - `log_analysis_report.pdf` – A structured PDF report with data and graphs.
  - `log_analysis_report.html` – A web-friendly, interactive report including graphs.
  - `alerts.log` – A record of all critical alerts triggered.
- **Email Alerts:**
  - If a test exceeds the error threshold or runtime anomaly is detected, an email notification is sent.
  - Reports are automatically attached to the email.
  - SMTP settings must be configured for email delivery.

## Prerequisites
- **Python 3.x**
- Required libraries:
**re, matplotlib, numpy, collections, fpdf, os, smtplib, ssl, email**
  
- Configure email SMTP settings (e.g., Gmail, Outlook, Yahoo) in the script:
  ```python
  smtp_server = "smtp.gmail.com"
  smtp_port = 587
  sender_email = "your_email@gmail.com"
  receiver_email = "recipient@example.com"
  app_password = "your_app_password"
  ```


## Conclusion
This tool enhances verification efficiency by automating log analysis, visualization, and failure detection. It helps engineers quickly identify issues, optimize test performance, and streamline debugging.

🚀 **Perfect for verification engineers looking to automate and optimize their workflow!**

import re
import matplotlib.pyplot as plt
import numpy as np
from collections import defaultdict, Counter
from fpdf import FPDF
import os
import smtplib
import ssl
from email.message import EmailMessage

# Log file path
log_file_path = "simulation_log_extended.txt"
alert_log_path = "alerts.log"

# Patterns for identifying message types
log_patterns = {
    "INFO": re.compile(r'INFO: (.*)'),
    "WARNING": re.compile(r'WARNING: (.*)'),
    "ERROR": re.compile(r'ERROR: (.*)')
}

# Variable to store log data
log_data = defaultdict(lambda: {"errors": 0, "warnings": 0, "infos": 0, "runtime": 0})
error_messages = []
warning_messages = []

test_id_pattern = re.compile(r'TEST_ID=(\d+)')
runtime_pattern = re.compile(r'Simulation completed in ([\d.]+) seconds')

# Reading the log file and analyzing the data
with open(log_file_path, "r") as file:
    for line in file:
        test_id_match = test_id_pattern.search(line)
        if test_id_match:
            test_id = test_id_match.group(1)
            for log_type, pattern in log_patterns.items():
                match = pattern.search(line)
                if match:
                    log_data[test_id][log_type.lower() + "s"] += 1
                    if log_type == "ERROR":
                        error_messages.append(match.group(1))
                    elif log_type == "WARNING":
                        warning_messages.append(match.group(1))
            runtime_match = runtime_pattern.search(line)
            if runtime_match:
                log_data[test_id]["runtime"] = float(runtime_match.group(1))

# Analysis of recurring messages
error_counts = Counter(error_messages)
warning_counts = Counter(warning_messages)

# Displaying the data on screen
print("\nMost Common Errors:")
for error, count in error_counts.most_common(5):
    print(f"- {error} ({count} occurrences)")

print("\nMost Common Warnings:")
for warning, count in warning_counts.most_common(5):
    print(f"- {warning} ({count} occurrences)")

print("\nTest Summary:")
for test_id, data in log_data.items():
    print(f"Test {test_id}: Infos={data['infos']}, Errors={data['errors']}, Warnings={data['warnings']}, Runtime={data['runtime']} sec")
   
# Creating graphs
test_ids = list(log_data.keys())
errors = np.array([log_data[test]['errors'] for test in test_ids])
warnings = np.array([log_data[test]['warnings'] for test in test_ids])
runtimes = np.array([log_data[test]['runtime'] for test in test_ids])

# Identifying runtime outliers
mean_runtime = np.mean(runtimes)
std_runtime = np.std(runtimes)
threshold = mean_runtime + 2 * std_runtime
outliers = [test_ids[i] for i in range(len(runtimes)) if runtimes[i] > threshold]
print("\nOutlier Tests:", outliers)

plt.figure(figsize=(10, 6))
plt.bar(test_ids, errors, label='Errors', color='red', alpha=0.7)
plt.bar(test_ids, warnings, label='Warnings', color='orange', alpha=0.7, bottom=errors)
plt.xlabel("Test ID")
plt.ylabel("Count")
plt.title("Errors and Warnings per Test")
plt.xticks(rotation=45)
plt.legend()
plt.grid(axis='y', linestyle='--', alpha=0.7)
plt.savefig("errors_warnings_plot.png")
plt.close()

plt.figure(figsize=(10, 6))
plt.bar(test_ids, runtimes, color='blue', alpha=0.7)
plt.xlabel("Test ID")
plt.ylabel("Runtime (sec)")
plt.title("Test Runtime Analysis")
plt.xticks(rotation=45)
plt.grid(axis='y', linestyle='--', alpha=0.7)
plt.savefig("runtime_plot.png")
plt.close()


plt.figure(figsize=(10, 6))
plt.scatter(test_ids, runtimes, color='blue', label='Normal Tests')
plt.scatter(outliers, [runtimes[test_ids.index(t)] for t in outliers], color='red', label='Outliers', marker='x', s=100)
plt.axhline(y=threshold, color='r', linestyle='--', label='Threshold')
plt.xlabel("Test ID")
plt.ylabel("Runtime (sec)")
plt.title("Runtime Outlier Detection")
plt.xticks(rotation=45)
plt.legend()
plt.grid(axis='y', linestyle='--', alpha=0.7)
plt.savefig("runtime_outliers_plot.png")
plt.close()

# Saving alerts to a file
alerts = []
with open(alert_log_path, "w") as alert_file:
    for test_id, data in log_data.items():
        if data['errors'] > 3:
            alert_msg = f"ALERT: Test {test_id} has {data['errors']} errors."
            alerts.append(alert_msg)
            alert_file.write(alert_msg + "\n")
        if data['runtime'] > threshold:
            alert_msg = f"ALERT: Test {test_id} runtime {data['runtime']} sec exceeds threshold {threshold:.2f} sec."
            alerts.append(alert_msg)
            alert_file.write(alert_msg + "\n")

# Creating a PDF report
pdf = FPDF()
pdf.set_auto_page_break(auto=True, margin=15)
pdf.add_page()
pdf.set_font("Arial", size=12)

pdf.cell(200, 10, "Log Analysis Report", ln=True, align='C')
pdf.ln(10)

pdf.cell(200, 10, "Test Summary:", ln=True)
for test_id, data in log_data.items():
    pdf.cell(200, 10, f"Test {test_id}: Infos={data['infos']}, Errors={data['errors']}, Warnings={data['warnings']}, Runtime={data['runtime']} sec", ln=True)
pdf.ln(5)

# Adding graphs to the PDF report
for image in ["errors_warnings_plot.png", "runtime_plot.png", "runtime_outliers_plot.png"]:
    if os.path.exists(image):
        pdf.add_page()
        pdf.image(image, x=10, y=20, w=180)

pdf.output("log_analysis_report.pdf")

# Creating an HTML report
html_content = """
<html>
<head>
    <title>Log Analysis Report</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        h1 { color: #333366; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid black; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <h1>Log Analysis Report</h1>
    <h2>Test Summary</h2>
    <table>
        <tr><th>Test ID</th><th>Infos</th><th>Errors</th><th>Warnings</th><th>Runtime (sec)</th></tr>
"""
for test_id, data in log_data.items():
    html_content += f"<tr><td>{test_id}</td><td>{data['infos']}</td><td>{data['errors']}</td><td>{data['warnings']}</td><td>{data['runtime']}</td></tr>"
html_content += "</table>"

# Adding graphs
for image in ["errors_warnings_plot.png", "runtime_plot.png", "runtime_outliers_plot.png"]:
    if os.path.exists(image):
        html_content += f'<h3>{image.replace(".png", "").replace("_", " ").title()}</h3>'
        html_content += f'<img src="{image}" width="800">'

html_content += "</body></html>"

with open("log_analysis_report.html", "w") as file:
    file.write(html_content)

# Function to send an email with alerts
def send_email_alert():
    smtp_server = "smtp.gmail.com"  # Change to Outlook or Yahoo if needed
    smtp_port = 587
    sender_email = ""
    receiver_email = ""
    app_password = ""  # Use an app password
    subject = "Simulation Log Alerts"
    body = "\n".join(alerts) if alerts else "No alerts generated."
    
    msg = EmailMessage()
    msg['From'] = sender_email
    msg['To'] = receiver_email
    msg['Subject'] = subject
    msg.set_content(body)
    
    # Adding attached reports
    for file_path in ["log_analysis_report.pdf", "log_analysis_report.html", alert_log_path]:
        if os.path.exists(file_path):
            with open(file_path, "rb") as f:
                file_data = f.read()
                file_name = os.path.basename(file_path)
                msg.add_attachment(file_data, maintype='application', subtype='octet-stream', filename=file_name)
    
    # Sending the email with encryption
    context = ssl.create_default_context()
    with smtplib.SMTP(smtp_server, smtp_port) as server:
        server.starttls(context=context)
        server.login(sender_email, app_password)
        server.send_message(msg)
    
    print("Email alert sent successfully!")

# Sending alerts if they exist
if alerts:
    send_email_alert()

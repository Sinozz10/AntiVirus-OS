# Lab 2: Shell-Based Antivirus

## Project Overview
This project is a shell-based antivirus system designed to monitor a specific directory for malicious files. It includes a background daemon for real-time monitoring, a restoration utility to manage quarantined files, and a cron job script for scheduled automated background scans.

## Prerequisites and Environment Setup
Before running any scripts or configuring the cron jobs, ensure the following requirements are met:
1. **Operating System:** Linux environment with a standard Bash shell.
2. **Cron Service:** Ensure the cron daemon is installed and actively running on your system. You can verify this by running `sudo systemctl status cron`.
3. **Execution Permissions:** All shell scripts must be marked as executable. Run the following command in your terminal before starting:
   `chmod +x antivirusd.sh restore.sh antivirus-cron.sh`
4. **Absolute Paths:** For cron scheduling, you must use the exact absolute paths to your project scripts and directories (e.g., `/home/username/Documents/Lab-2 AntiVirus/...`). Cron cannot read relative paths.

## Core Components

### 1. Antivirus Daemon (`antivirusd.sh`)
Runs continuously in the background, monitoring the target directory for changes. If a file contains malware signatures (e.g., virus, trojan, malware, ransomware), it is immediately moved to the quarantine directory.
**Usage:** `./antivirusd.sh <monitor_directory> <malicious_files_directory> <sleep_interval>`

### 2. Restore Utility (`restore.sh`)
An interactive command-line tool to review files currently in the malicious quarantine directory. It allows the user to individually select a file and either safely restore it back to the monitor directory or permanently delete it.
**Usage:** `./restore.sh <monitor_directory> <malicious_files_directory>`

## Cron Job Configuration Manual

This section outlines how to schedule the `antivirus-cron.sh` script to run automatically using the Linux `cron` utility.

### Step-by-Step Configuration Guide
1. Open your terminal.
2. Type `crontab -e` and press Enter to open the cron schedule editor. (If prompted, select `nano` as your text editor).
3. Use the arrow keys to scroll to the very bottom of the file.
4. Paste your required cron expression (provided below) on a new line. 
**Important:** Be sure to replace the dummy `/absolute/path/to/` paths with your actual system paths.
5. Save the file and exit the editor (If using `nano`: press `Ctrl + O`, `Enter`, then `Ctrl + X`).
6. The terminal will display `crontab: installing new crontab` to confirm the job is successfully scheduled in the background.

### Required Cron Expressions

**1. Run every 1 minute at second 23:**
Standard cron only triggers at the 0-second mark of every minute. To execute exactly at the 23rd second, the `sleep` command is used to purposefully delay execution.
```bash
* * * * * sleep 23 && "/absolute/path/to/antivirus-cron.sh" "/absolute/path/to/monitor_directory" "/absolute/path/to/malicious_files"
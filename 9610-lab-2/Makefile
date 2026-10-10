dir ?= monitor_directory
malacious_dir ?= malicious_files
interval_secs ?= 5

.PHONY: setup antivi restore

setup:
	@echo "Setting up the environment..."
	@mkdir -p $(dir)
	@mkdir -p $(malacious_dir)
	@echo "Setup complete."

antivi: setup
	@echo "Starting the Antivirus Daemon to monitor $(dir) every $(interval_secs) seconds.."
	./antivirusd.sh $(dir) $(malacious_dir) $(interval_secs)

restore: setup
	@echo "Restoring files from $(malacious_dir)."
	./restore.sh $(dir) $(malacious_dir)
	
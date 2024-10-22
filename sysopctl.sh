#!/bin/bash

VERSION="v0.1.0"

# Show help message with command descriptions and usage
function display_help() {
    cat << EOF
Usage: sysopctl [command] [options]

Commands:
  service list                  Show all active services
  service start <service-name>  Start a specific service
  service stop <service-name>   Stop a specific service
  system load                   Display current system load averages
  disk usage                    Display disk usage statistics by partition
  process monitor               Show system processes in real-time
  logs analyze                  Summarize recent critical log entries
  backup <path>                 Backup files from a given path

Options:
  --help                        Display this help message
  --version                     Show version details

EOF
}

# Display version details
function display_version() {
    echo "sysopctl version $VERSION"
}

# Show a list of currently active services
function active_services() {
    echo "Fetching list of active services..."
    systemctl list-units --type=service
}

# Start a specified service
function start_service() {
    echo "Attempting to start service: $1..."
    systemctl start "$1" && echo "Service $1 successfully started."
}

# Stop a specified service
function stop_service() {
    echo "Attempting to stop service: $1..."
    systemctl stop "$1" && echo "Service $1 successfully stopped."
}

# Display system load averages
function show_system_load() {
    echo "Showing current system load averages..."
    uptime
}

# Show disk usage statistics per partition
function display_disk_usage() {
    echo "Fetching disk usage details..."
    df -h
}

# Monitor real-time system processes
function real_time_processes() {
    echo "Monitoring system processes..."
    top
}

# Analyze recent critical log entries
function analyze_system_logs() {
    echo "Fetching recent critical log summaries..."
    journalctl -p 3 -xb
}

# Backup files from a given path
function perform_backup() {
    echo "Starting backup for files in $1..."
    rsync -avh "$1" /backup/ && echo "Backup completed successfully for $1."
}

# Main program logic
case "$1" in
    --help)
        display_help
        ;;
    --version)
        display_version
        ;;
    service)
        case "$2" in
            list)
                active_services
                ;;
            start)
                start_service "$3"
                ;;
            stop)
                stop_service "$3"
                ;;
            *)
                echo "Invalid service operation. Run sysopctl --help for valid options."
                ;;
        esac
        ;;
    system)
        case "$2" in
            load)
                show_system_load
                ;;
            *)
                echo "Invalid system command. Use --help for valid options."
                ;;
        esac
        ;;
    disk)
        case "$2" in
            usage)
                display_disk_usage
                ;;
            *)
                echo "Invalid disk operation. Run sysopctl --help for valid options."
                ;;
        esac
        ;;
    process)
        case "$2" in
            monitor)
                real_time_processes
                ;;
            *)
                echo "Invalid process command. Use --help for valid options."
                ;;
        esac
        ;;
    logs)
        case "$2" in
            analyze)
                analyze_system_logs
                ;;
            *)
                echo "Invalid log operation. Run sysopctl --help for valid options."
                ;;
        esac
        ;;
    backup)
        if [ -n "$2" ]; then
            perform_backup "$2"
        else
            echo "Please provide a path to backup."
        fi
        ;;
    *)
        echo "Unknown command. Use sysopctl --help to see available commands."
        ;;
esac

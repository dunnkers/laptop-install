#!/bin/bash
# Automated cleanup script for Downloads and Desktop folders
# Moves files older than configured threshold to Trash

# Configuration from environment variables
AGE_HOURS=${CLEANUP_AGE_HOURS:-24}
CLEANUP_DOWNLOADS=${CLEANUP_DOWNLOADS:-true}
CLEANUP_DESKTOP=${CLEANUP_DESKTOP:-true}

# Directories
DOWNLOADS_DIR="${HOME}/Downloads"
DESKTOP_DIR="${HOME}/Desktop"
LOG_FILE="${HOME}/.config/laptop-install/cleanup.log"

# Ensure log directory exists
mkdir -p "$(dirname "${LOG_FILE}")"

# Log function
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "${LOG_FILE}"
}

# Move to Trash function (using macOS native trash, not rm)
move_to_trash() {
    local file="$1"
    # Use osascript to move file to Trash (recoverable)
    osascript -e "tell application \"Finder\" to delete POSIX file \"${file}\"" >/dev/null 2>&1
    return $?
}

# Cleanup function for a directory
cleanup_directory() {
    local dir="$1"
    local dir_name="$2"
    local count=0

    if [ ! -d "${dir}" ]; then
        log_message "Directory not found: ${dir}"
        echo "0"
        return
    fi

    log_message "Starting cleanup of ${dir_name} (${dir})"

    # Find files (not directories) older than AGE_HOURS hours
    # -type f: files only, not directories
    # -mtime +Nh: modified more than N hours ago (macOS find uses minutes with -mmin)
    # -not -name '.*': exclude hidden files to avoid system files
    # -maxdepth 1: don't recurse into subdirectories

    local age_minutes=$((AGE_HOURS * 60))

    while IFS= read -r -d '' file; do
        if move_to_trash "${file}"; then
            log_message "Moved to trash: ${file}"
            ((count++))
        else
            log_message "Failed to move: ${file}"
        fi
    done < <(find "${dir}" -maxdepth 1 -type f -not -name '.*' -mmin +${age_minutes} -print0 2>/dev/null)

    log_message "Cleanup complete for ${dir_name}: ${count} files moved"
    echo "${count}"
}

# Main execution
log_message "=== Cleanup job started ==="
log_message "Configuration: AGE_HOURS=${AGE_HOURS}, DOWNLOADS=${CLEANUP_DOWNLOADS}, DESKTOP=${CLEANUP_DESKTOP}"

echo "Starting cleanup (files older than ${AGE_HOURS} hours)..."

downloads_count=0
desktop_count=0

# Cleanup Downloads if enabled
if [ "${CLEANUP_DOWNLOADS}" = "true" ]; then
    downloads_count=$(cleanup_directory "${DOWNLOADS_DIR}" "Downloads")
    echo "  Downloads: ${downloads_count} files moved to Trash"
else
    log_message "Downloads cleanup disabled by configuration"
    echo "  Downloads: skipped (disabled)"
fi

# Cleanup Desktop if enabled
if [ "${CLEANUP_DESKTOP}" = "true" ]; then
    desktop_count=$(cleanup_directory "${DESKTOP_DIR}" "Desktop")
    echo "  Desktop: ${desktop_count} files moved to Trash"
else
    log_message "Desktop cleanup disabled by configuration"
    echo "  Desktop: skipped (disabled)"
fi

total=$((downloads_count + desktop_count))
log_message "=== Cleanup job finished: ${downloads_count} from Downloads, ${desktop_count} from Desktop (Total: ${total}) ==="

echo ""
echo "Cleanup complete: ${total} files moved to Trash"
echo "Log: ${LOG_FILE}"

exit 0

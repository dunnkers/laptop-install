#!/bin/bash

# Preferences management for laptop-install
# Stores user preferences in ~/.config/laptop-install/preferences

PREFS_DIR="${HOME}/.config/laptop-install"
PREFS_FILE="${PREFS_DIR}/preferences"

# Initialize preferences directory
init_preferences() {
    mkdir -p "${PREFS_DIR}"
    touch "${PREFS_FILE}"
}

# Get a preference value
# Usage: get_preference "key" "default_value"
get_preference() {
    local key="$1"
    local default="$2"

    init_preferences

    if [ -f "${PREFS_FILE}" ]; then
        local value=$(grep "^${key}=" "${PREFS_FILE}" | cut -d'=' -f2-)
        if [ -n "${value}" ]; then
            echo "${value}"
            return 0
        fi
    fi

    echo "${default}"
    return 1
}

# Set a preference value
# Usage: set_preference "key" "value"
set_preference() {
    local key="$1"
    local value="$2"

    init_preferences

    # Remove existing key if present
    if [ -f "${PREFS_FILE}" ]; then
        grep -v "^${key}=" "${PREFS_FILE}" > "${PREFS_FILE}.tmp" 2>/dev/null || true
        mv "${PREFS_FILE}.tmp" "${PREFS_FILE}"
    fi

    # Add new key-value pair
    echo "${key}=${value}" >> "${PREFS_FILE}"
}

# Check if a preference exists
# Usage: has_preference "key"
has_preference() {
    local key="$1"

    init_preferences

    if [ -f "${PREFS_FILE}" ]; then
        grep -q "^${key}=" "${PREFS_FILE}"
        return $?
    fi

    return 1
}

# Ask user for preference if not already set
# Usage: ask_preference "key" "prompt" "default"
ask_preference() {
    local key="$1"
    local prompt="$2"
    local default="$3"

    if has_preference "${key}"; then
        get_preference "${key}"
        return 0
    fi

    read -r -p "${prompt} " response

    if [ -z "${response}" ]; then
        response="${default}"
    fi

    set_preference "${key}" "${response}"
    echo "${response}"
}

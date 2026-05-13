#!/bin/bash
set -e

# Runtime PHP Configuration Generator for PHPX
# This script converts environment variables to PHP .ini files at runtime

PHP_INI_DIR="/usr/local/etc/php"
CUSTOM_INI_DIR="${PHP_INI_DIR}/conf.d"
PHPX_INI_FILE="${CUSTOM_INI_DIR}/99-phpx-runtime.ini"

echo "🔧 Generating runtime PHP configuration..."

# Ensure custom ini directory exists
mkdir -p "${CUSTOM_INI_DIR}"

# Clear previous runtime config if exists
if [ -f "${PHPX_INI_FILE}" ]; then
    rm "${PHPX_INI_FILE}"
fi

# Create new runtime ini file
touch "${PHPX_INI_FILE}"

# Function to add ini directive
add_ini_directive() {
    local key="$1"
    local value="$2"
    echo "${key} = ${value}" >> "${PHPX_INI_FILE}"
    echo "  ✓ ${key} = ${value}"
}

# Map environment variables to PHP ini directives
declare -A ENV_TO_INI=(
    ["PHP_MEMORY_LIMIT"]="memory_limit"
    ["PHP_POST_MAX_SIZE"]="post_max_size"
    ["PHP_UPLOAD_MAX_FILESIZE"]="upload_max_filesize"
    ["PHP_MAX_EXECUTION_TIME"]="max_execution_time"
    ["PHP_MAX_INPUT_TIME"]="max_input_time"
    ["PHP_MAX_INPUT_VARS"]="max_input_vars"
    ["PHP_DATE_TIMEZONE"]="date.timezone"
    ["PHP_DISPLAY_ERRORS"]="display_errors"
    ["PHP_DISPLAY_STARTUP_ERRORS"]="display_startup_errors"
    ["PHP_ERROR_REPORTING"]="error_reporting"
    ["PHP_LOG_ERRORS"]="log_errors"
    ["PHP_ERROR_LOG"]="error_log"
    ["PHP_MAX_FILE_UPLOADS"]="max_file_uploads"
    ["PHP_OUTPUT_BUFFERING"]="output_buffering"
    ["PHP_DEFAULT_CHARSET"]="default_charset"
    ["PHP_REALPATH_CACHE_SIZE"]="realpath_cache_size"
    ["PHP_REALPATH_CACHE_TTL"]="realpath_cache_ttl"
    ["PHP_OPCACHE_ENABLE"]="opcache.enable"
    ["PHP_OPCACHE_MEMORY_CONSUMPTION"]="opcache.memory_consumption"
    ["PHP_OPCACHE_MAX_ACCELERATED_FILES"]="opcache.max_accelerated_files"
    ["PHP_OPCACHE_REVALIDATE_FREQ"]="opcache.revalidate_freq"
    ["PHP_SESSION_SAVE_HANDLER"]="session.save_handler"
    ["PHP_SESSION_SAVE_PATH"]="session.save_path"
    ["PHP_SESSION_GC_MAXLIFETIME"]="session.gc_maxlifetime"
)

# Process mapped environment variables
echo "Processing PHP environment variables..."
for env_var in "${!ENV_TO_INI[@]}"; do
    ini_key="${ENV_TO_INI[$env_var]}"
    env_value="${!env_var:-}"
    
    if [ -n "$env_value" ]; then
        add_ini_directive "$ini_key" "$env_value"
    fi
done

# Process PHP_INI_EXTRA for raw configuration
if [ -n "$PHP_INI_EXTRA" ]; then
    echo "Processing PHP_INI_EXTRA..."
    echo "# PHP_INI_EXTRA configuration" >> "${PHPX_INI_FILE}"
    echo "$PHP_INI_EXTRA" >> "${PHPX_INI_FILE}"
    echo "  ✓ PHP_INI_EXTRA appended"
fi

# Load custom .ini files from mounted directory
if [ -d "/etc/phpx/custom-ini" ]; then
    echo "Loading custom .ini files from /etc/phpx/custom-ini..."
    if [ "$(ls -A /etc/phpx/custom-ini/*.ini 2>/dev/null)" ]; then
        for ini_file in /etc/phpx/custom-ini/*.ini; do
            if [ -f "$ini_file" ]; then
                echo "# Custom ini: $(basename $ini_file)" >> "${PHPX_INI_FILE}"
                cat "$ini_file" >> "${PHPX_INI_FILE}"
                echo "  ✓ Loaded $(basename $ini_file)"
            fi
        done
    else
        echo "  ℹ No .ini files found in /etc/phpx/custom-ini"
    fi
fi

# Verify the generated ini file
if [ -f "${PHPX_INI_FILE}" ] && [ -s "${PHPX_INI_FILE}" ]; then
    echo ""
    echo "✅ Runtime PHP configuration generated at ${PHPX_INI_FILE}"
    echo ""
    echo "Generated configuration:"
    cat "${PHPX_INI_FILE}"
else
    echo ""
    echo "ℹ No runtime PHP configuration applied (using defaults)"
    rm -f "${PHPX_INI_FILE}"
fi

echo ""
echo "🚀 Starting application..."

# Execute the main command
exec "$@"

#!/usr/bin/env bash
# sample.sh - Bash test fixture for tree-sitter parsing
# Exercises function definitions (both forms), calls, source imports, tests

# Source imports (both forms)
source lib/utils.sh
. config/defaults.sh
source "lib/helpers.sh"

# Global variables
GLOBAL_NAME="world"
readonly MAX_RETRIES=3

# Parenthesized form: foo() { ... }
greet() {
    local name=$1
    echo "Hello, $name"
    log_info "greeted $name"
}

# Parenthesized form with one argument expansion
helper() {
    local x=$1
    local y=$2
    echo $((x + y))
}

# `function` keyword form: function foo { ... }
function build_message {
    local prefix=$1
    local body=$2
    echo "${prefix}: ${body}"
}

# `function` keyword form with parentheses
function log_error() {
    echo "ERROR: $1" >&2
    exit 1
}

# Test function — matches _TEST_PATTERNS `^test_`
test_greet() {
    local result
    result=$(greet "World")
    [[ "$result" == *"Hello"* ]] || log_error "greet failed"
}

test_helper_addition() {
    local result
    result=$(helper 2 3)
    [[ "$result" == "5" ]] || log_error "helper failed"
}

# Main entry point — calls local functions + external commands
main() {
    greet "$GLOBAL_NAME"
    helper 1 2
    build_message "INFO" "starting"

    # External binaries — recorded as CALLS with the external name
    curl -sSL https://example.com > /dev/null
    grep -q foo bar.txt
    awk '{print $1}' data.txt
}

main "$@"

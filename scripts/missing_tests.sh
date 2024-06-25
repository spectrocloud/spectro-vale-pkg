#!/bin/bash

# Base directory (change as needed)
BASE_DIR=$1

# Required test files
REQUIRED_FILES=(".vale.ini" "pass.md" "fail.md")

# Counter for failed tests
failed_tests=0

# Function to get the rule name from the rule file path
get_rule_name() {
    local rule_file="$1"
    local rule_name=$(basename "$rule_file" .yml)
    rule_name=${rule_name%.yaml}
    echo "$rule_name"
}

# Function to check if test files exist
check_test_files() {
    local test_dir="$1"
    local package_name="$2"
    local rule_name="$3"
    local all_files_exist=true
    local missing_files=()
    
    for file in "${REQUIRED_FILES[@]}"; do
        if [[ ! -f "$test_dir/$file" ]]; then
            all_files_exist=false
            missing_files+=("$file")
        fi
    done

    if [[ "$all_files_exist" == false ]]; then
       ((failed_tests++))
        echo "$package_name/$rule_name missing required files: ❌" 
        for file in "${missing_files[@]}"; do
            echo "  - $file"
        done   
    fi

}

# Function to traverse the directory structure
traverse_directories() {
    for package_dir in "$BASE_DIR"/*; do
        echo ""
        if [[ -d "$package_dir/styles" ]]; then
            local package_name=$(basename "$package_dir")
            for rule_file in "$package_dir/styles"/*/*.yml "$package_dir/styles"/*/*.yaml; do
                if [[ -f "$rule_file" ]]; then
                    local rule_name=$(get_rule_name "$rule_file")
                    local test_dir="$package_dir/tests/$rule_name"
                    local result=""
                    if [[ -d "$test_dir" ]]; then
                        check_test_files "$test_dir" "$package_name" "$rule_name"
                    else
                        echo "$package_name/$rule_name missing test directory - ❌"
                        ((failed_tests++))
                    fi
                fi
            done
        fi
    done
}

# Execute the traversal function
traverse_directories "$BASE_DIR"
echo ""

# Exit with the appropriate status code
if [[ "$failed_tests" -ne 0 ]]; then
    echo "❌ Total rules missing tests: $failed_tests "
    exit 1
fi

echo "All Vale rules have a set of test files 🎉"
exit 0

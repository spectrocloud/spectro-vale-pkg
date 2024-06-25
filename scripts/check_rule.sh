#!/bin/sh
# Copyright (c) Spectro Cloud
# SPDX-License-Identifier: Apache-2.0

set -e


failed_tests=0

# Function to get the last directory name from a given path. This is used to get the rule name.
get_last_directory_name() {
  dir_path=$1
  base_name=$(basename "$dir_path")
  capitalized_name="$(tr '[:lower:]' '[:upper:]' <<< ${base_name:0:1})${base_name:1}"
  echo "$capitalized_name"
}

# This function extracts the first folder name (package name) from a given path.
get_package_name() {
  dir_path=$1
  package_name=$(basename "$(dirname "$(dirname "$dir_path")")")
  echo "$package_name"
}


# This function checks the pass conditions for the Vale rule. A file with the name pass.md is expected to be present.
# The function takes one argument which is the base directory
# The expected folder structure is base_directory/.vale.ini and base_directory/pass.md
# If any error is found, the function will exit with status code 1
check_pass_conditions() {
  base_directory=$1
  config_file="$base_directory/.vale.ini"
  pass_md_file="$base_directory/pass.md"
  rule_name=$(get_last_directory_name "$base_directory")
  package_name=$(get_package_name "$base_directory")
  
  # Check if the directory contains a file named pass.md
  if [ ! -f "$pass_md_file" ]; then
    echo "Error: $base_directory does not contain a file named pass.md"
    exit 1
  fi

  # Check if the .vale.ini configuration file exists
  if [ ! -f "$config_file" ]; then
    echo "Error: $base_directory does not contain a file named .vale.ini"
    exit 1
  fi

  RESULT=$(vale --config="$config_file" --no-exit --output=line  "$pass_md_file" |  wc -l)

  if [ "$RESULT" -ne 0 ]; then
     echo "$package_name/$rule_name fail condition test - ❌"
    failed_tests=$((failed_tests + 1))
     return 1
  fi

  echo "$package_name/$rule_name passs condition test - ✅"
}

# This function checks the fail conditions for the Vale rule. A file with the name fail.md is expected to be present.
# The function takes one argument which is the base directory
# The expected folder structure is base_directory/.vale.ini and base_directory/fail.md
# If any error is found, the function will exit with status code 1
check_fail_conditions() {
  base_directory=$1
  config_file="$base_directory/.vale.ini"
  fail_md_file="$base_directory/fail.md"
  rule_name=$(get_last_directory_name "$base_directory")
  package_name=$(get_package_name "$base_directory")
  
  # Check if the directory contains a file named fail.md
  if [ ! -f "$fail_md_file" ]; then
    echo "Error: $base_directory does not contain a file named pass.md"
    exit 1
  fi

  # Check if the .vale.ini configuration file exists
  if [ ! -f "$config_file" ]; then
    echo "Error: $base_directory does not contain a file named .vale.ini"
    exit 1
  fi


  RESULT=$(vale --config="$config_file" --no-exit --output=line  "$fail_md_file" |  wc -l)

  if [ "$RESULT" -eq 0 ]; then
     echo "$package_name/$rule_name fail condition test - ❌"
     failed_tests=$((failed_tests + 1))
     return 1
  fi
  echo "$package_name/$rule_name fail condition test - ✅"
}


# This function traverses the base directory and checks the pass and fail conditions for the Vale rules.
traverse_and_check() {
  base_directory=$1

  # Traverse the packages directory and look one level down
  for package_dir in "$base_directory"/*; do
    if [ -d "$package_dir/tests" ]; then
      
      # Walk the tests directory for sub-directories
      echo ""
      for test_subdir in "$package_dir/tests"/*; do
        if [ -d "$test_subdir" ]; then
          check_pass_conditions "$test_subdir" || true
          check_fail_conditions "$test_subdir" || true
        fi
      done
    fi
  done
}

# Define the base directory to check (example usage)
BASE_DIRECTORY=$1
echo "Starting the Vale rule test suit ..."
echo ""
traverse_and_check "$BASE_DIRECTORY"


# Output the final number of failed tests
if [ "$failed_tests" -ne 0 ]; then
  echo ""
  echo "❌ Total failed tests: $failed_tests "
else
  echo ""
  echo "All Vale rules checked successfully without any errors 🎉"
fi
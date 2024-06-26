#!/bin/bash
# Copyright (c) Spectro Cloud
# SPDX-License-Identifier: Apache-2.0


set -e

package_name="${1:-spectrocloud}"
echo "Package name: $package_name"

if [ "$package_name" != "spectrocloud" ] && [ "$package_name" != "spectrocloud-docs-internal" ]; then
  echo "Invalid package name. Allowed values are 'spectrocloud' and 'spectrocloud-docs-internal'"
  exit 1
fi

# Function to copy content to workbench folder
# The function takes one argument. Allowed values are "spectrocloud" and "spectrocloud-docs-internal"
copy_content() {
  if [ "$1" = "spectrocloud" ]; then
    echo "Copying content for spectrocloud pkg"
    cp -R packages/spectrocloud/ workbench/spectrocloud
    remove_tests "workbench/spectrocloud"
  elif [ "$1" = "spectrocloud-docs-internal" ]; then
    echo "Copying content for spectrocloud-docs-internal pkg"
    cp -R packages/spectrocloud-docs-internal workbench/spectrocloud-docs-internal
     remove_tests "workbench/spectrocloud-docs-internal"
  fi
}

create_folder() {
  if [ -d "workbench" ]; then
    rm -rf workbench
  fi
  echo "Creating workbench folder"
  mkdir workbench
}

# Function to zip files in workbench folder
# The function takes one argument. Allowed values are "spectrocloud" and "spectrocloud-docs-internal"
# The expected folder structure is workbench/spectrocloud or workbench/spectrocloud-docs-internal
zip_files() {
  cd workbench/
  echo "Zipping files"
  if [ "$1" = "spectrocloud" ]; then
    zip -r ../spectrocloud.zip spectrocloud/
  elif [ "$1" = "spectrocloud-docs-internal" ]; then
    zip -r ../spectrocloud-docs-internal.zip spectrocloud-docs-internal/
  fi
  cd ..
}

# Function to remove all tests folders from the target directory
# The function takes one argument which is the target directory
remove_tests() {
  target_dir=$1
  echo "Removing the tests folder from $target_dir"
  find "$target_dir" -type d -name tests -exec rm -rf {} +
}

# Function to check and remove existing zip files
# The function takes one argument. Allowed values are "spectrocloud" and "spectrocloud-docs-internal"
# The function removes the existing zip files if present
check_and_remove_zip() {
  if [ "$1" = "spectrocloud" ]; then
    zip1="spectrocloud.zip"
  elif [ "$1" = "spectrocloud-docs-internal" ]; then
    zip1="spectrocloud-docs-internal.zip"
  else 
    echo "Invalid package name"
    exit 1
  fi

  if [ -f "$zip1" ]; then
    echo "Removing $zip1"
    rm "$zip1"
  fi
}

check_and_remove_zip "$package_name"
create_folder
copy_content "$package_name"
zip_files "$package_name"
echo "$package_name package created successfully"

exit 0

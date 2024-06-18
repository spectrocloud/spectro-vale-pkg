#!/bin/sh
# Copyright (c) Spectro Cloud
# SPDX-License-Identifier: Apache-2.0


set -e

package_name="${1:-spectrocloud}"
echo "Package name: $package_name"

if [ $package_name != "spectrocloud" ] && [ $package_name != "spectrocloud-docs-internal" ]; then
  echo "Invalid package name. Allowed values are 'spectrocloud' and 'spectrocloud-docs-internal'"
  exit 1
fi


# Function to copy content to workbench folder
# The function takes one argument. Allowed values are "spectrocloud" and "spectrocloud-docs-internal"
copy_content() {

  if [ $1  == "spectrocloud" ]; then
    echo "Copying content for spectrocloud pkg"
    cp -R packages/spectrocloud/ workbench/spectrocloud

  elif [ $1  == "spectrocloud-docs-internal" ]; then
    echo "Copying content for spectrocloud-docs-internal pkg"
    cp -R packages/spectrocloud-docs-internal workbench/spectrocloud-docs-internal
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
zip_files() {
  cd  workbench/
  echo "Zipping files"
  if [ $1  == "spectrocloud" ]; then
    zip -r ../spectrocloud.zip spectrocloud/
  elif [ $1  == "spectrocloud-docs-internal" ]; then
   zip -r ../spectrocloud-docs-internal.zip spectrocloud-docs-internal/
  fi
  
}

check_and_remove_zips() {
    local zip1="spectrocloud-docs-internal.zip"
    local zip2="spectrocloud.zip"

    if [ -f "$zip1" ]; then
        echo "Removing $zip1"
        rm "$zip1"
    fi

    if [ -f "$zip2" ]; then
        echo "Removing $zip2"
        rm "$zip2"
    fi
}

check_and_remove_zips
create_folder
copy_content $package_name
zip_files $package_name
echo $package_name "package created successfully"
 
exit 0
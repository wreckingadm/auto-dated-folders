#!/bin/sh
# Move photos into dated subdirectories by creation date in metadata

#TODO: Take in a folder
file=$1

if [ -f "$file" ]; then
  capture_datetime=$(mdls -n kMDItemContentCreationDate $file)
  capture_date=$(echo "$capture_datetime" | grep -oE "[0-9]{4}-[0-9]{2}-[0-9]{2}")
  capture_year=$(echo "$capture_date" | grep -oE "[0-9]{4}")

  #TODO: Handle error if no `capture_date` can be determined (i.e. not a valid photo)
  #      Non-photos seem to have this specified too, since it's the creation date, but we can filter using `file -I <path>`

  #TODO: Provide protection flag that only processes photos with a `capture_date` with a year matching the enclosing folder

  #DEBUG
  echo "$file created on $capture_date, in $capture_year."

  #TODO: Create dated directory if it does not already exist
  #TODO: Move to dated directory

else
  echo "No files found"
fi
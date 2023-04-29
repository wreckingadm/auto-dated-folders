#!/bin/sh
# Move photos into dated subdirectories by creation date in metadata

# Ensure we have a valid directory
dir=$1
iter=0
if [ -d "$dir" ]; then
  for file in $dir/*; do
    #echo "Trying $file..." #DEBUG

    if [ -f "$file" ]; then
      capture_datetime=$(mdls -n kMDItemContentCreationDate "$file")
      capture_date=$(echo "$capture_datetime" | grep -oE "[0-9]{4}-[0-9]{2}-[0-9]{2}")
      capture_year=$(echo "$capture_date" | grep -oE "[0-9]{4}")

      # Confirm we're working with an image
      file_type=$(file -I "$file")
      if [[ "$file_type" = *": image/"* ]]; then
        # Get the parent directory name
        parent_dir=$(dirname "$file" | xargs basename)

        # Hacky workaround for running in the directory with the directory of the photos
        if [ "$parent_dir" = "." ]; then
          parent_dir=${PWD##*/}
        fi

        # Only action photos of the same year as the parent directory
        if [ "$parent_dir" = "$capture_year" ]; then
          #echo "$file created on $capture_date, in $capture_year, in directory $parent_dir." #DEBUG

          # Create dated directory if it does not already exist
          if [ ! -d "$dir/$capture_date" ]; then
            #TODO: Make sure this puts it in the right path
            echo "Creating directory $dir/$capture_date..."
            mkdir "$dir/$capture_date"
          fi

          # Move to dated directory
          echo "Moving $file into $dir/$capture_date..." #DEBUG
          #mv "$file" "$dir/$capture_date"
          ((iter++))

        # else
        #   echo "No photos found that match the year of their parent directory"
        fi

      # else
      #   echo "No photos found"
      fi

    # else
    #   echo "No photos found"
    fi

  done

  if [ $iter -gt 0 ]; then
    echo "Found and moved $iter photos"
  else
    echo "No valid photos found matching the year of their parent directory"
  fi

else
  echo "Not a valid directory"
fi
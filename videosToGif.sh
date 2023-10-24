#!/bin/bash

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    echo "ffmpeg is not installed. Please install it before running this script."
    exit 1
fi

# Input and output directories
input_dir="input_directory"
output_dir="output_directory"

# Create the output directory if it doesn't exist
mkdir -p "$output_dir"

# Convert MP4 files to GIF
for file in "$input_dir"/*.mp4; do
    if [ -e "$file" ]; then
        filename=$(basename -- "$file")
        filename_noext="${filename%.*}"
        output_file="$output_dir/$filename_noext.gif"
        
        ffmpeg -i "$file" -vf "fps=10,scale=320:-1:flags=lanczos" "$output_file"
        
        echo "Converted $filename to $output_file"
    fi
done

echo "Conversion complete."

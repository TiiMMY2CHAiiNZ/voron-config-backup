#!/bin/bash

# Help function
function show_help {
    echo "Usage: $0 [directory_path]"
    echo "Make every .sh and .py file executable in the specified directory and its subdirectories."
    exit 1
}

# Check if the correct number of arguments is passed
if [[ $# -ne 1 ]]; then
    show_help
fi

# Check if the specified directory exists
if [[ ! -d $1 ]]; then
    echo "Error: Directory not found"
    show_help
fi

# Count the number of .sh and .py files in the specified directory and its subdirectories
sh_count=$(find "$1" -type f -name "*.sh" | wc -l) # Count the number of .sh files
py_count=$(find "$1" -type f -name "*.py" | wc -l) # Count the number of .py files
total_count=$((sh_count + py_count)) # Add the counts together to get the total count

# Make every .sh and .py file executable
find "$1" -type f \( -name "*.sh" -o -name "*.py" \) -print0 | while read -d $'\0' file # Find all .sh and .py files and loop through them
do
    if [[ ! -x $file ]]; then # Check if the file is not executable
        chmod -v +x "$file" # Make the file executable and print a message
    fi
done

# Output summary statistics
echo "Modified permissions for $total_count files ($sh_count .sh files and $py_count .py files) in directory $1 and its subdirectories."
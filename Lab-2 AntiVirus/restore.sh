#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Error: Missing arguments."
    echo "Usage: ./restore.sh <dir> <malicious_dir>"
    exit 1
fi

dir = $1
malacious_dir = $2

whitelist = "whitelist.txt"

while true; do
    files_list=("$malacious_dir"/*)

    if [ "${files_list[@]}" -eq 0] || [ ! -e "${files_list[0]}" ]; then
        echo "No malicious files found to review."
        breaks
    fi

    echo "Malicious files found: - To be Quarantined - waiting for user review"
    i=1 #3ashan lma azawed/an2as as index (works as counter)

    for f in "${files_list[@]}"; do
        filename=$(basename "$f")
        echo "----------------------------------------"
        echo "$i. $filename"
        ((i++))
    done

    echo "----------------------------------------"
    read -p "pick file by number to review (or type 0 to quit): " num
    if [ "$num" -eq 0 ]; then
        echo "Exiting review process."
        break
    fi

    index=$((num-1))
    selected_file="${files_list[$index]}"
    filename=$(basename "$selected_file")

    echo "Input 1: Restore this file back into $dir"
    echo "Input 2: Permanently delete this file from $malacious_dir"
    echo "Input 3: Leave this file as-is and go back to the list"
    read -p "Select an option: " opt 
        
    case $opt in
        1)
            mv "$selected_file" "$dir/"
            echo "$filename" >> "$whitelist"
            echo "Restored $filename to $dir."
            ;;
        2)
            rm "${selected_file}"
            echo "File permanently deleted from $malacious_dir."
            ;;
        3)
            echo "Returning to the list of malicious files."
            continue
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
done
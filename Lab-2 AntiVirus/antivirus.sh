#!/bin/bash

dir=$1
malacious_dir=$2
interval_secs=$3
whitelist="whitelist.txt"

scan_directory() {
    for file in "$dir"/*; do
        if [ ! -f "$file" ]; then
            continue
        fi

        filename=$(basename "$file")

        if grep -Fxq "$filename" "$whitelist"; then
            echo "Skipping whitelisted file: $filename"
            continue
        fi

        is_malicious=0

        if [[ "$filename" == *".exe" || "$filename" == *".bat" || "$filename" == *".vbs" || "$filename" == *".scr" || "$filename" == *".ps1" ]]; then

            is_malicious=1
        fi

        if grep -q -i -E"virus|trojan|malware|worm|ransomware" "$file"; then
            is_malicious=1
        fi

        if [ $is_malicious -eq 1 ]; then
            echo "Malicious file detected: $filename"
            mv "$file" "$malacious_dir/"
        fi
    done
}

scan_directory
ls -l "$dir" > directory-info.last

while true; do
    sleep "$interval_secs"
    ls -l "$dir" > directory-info.new

    if [ ! cmp -s directory-info.last directory-info.new ]; then
        echo "Directory contents changed. Scanning for malicious files..."
        scan_directory
        mv directory-info.new directory-info.last
    fi
done
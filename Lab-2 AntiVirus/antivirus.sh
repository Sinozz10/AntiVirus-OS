#!/bin/bash

dir=$1
malacious_dir=$2
interval_secs=$3
whitelist="whitelist.txt"

scan_directory() {
    
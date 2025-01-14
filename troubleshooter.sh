#!/bin/bash

# Path to your file
file="/var/lib/switchboard/content/apod.dunkin-pricing.csv"

# Get the last line number by extracting the first column from the last line
last_number=$(tail -n 1 "$file" | cut -d ',' -f 1)

# Increment to get the next number
next_number=$((last_number + 1))

# Add 10 lines with the adjusted numbers

  echo "$((next_number + i)),1322374,\"First item $((i + 1))\",,0,504316,6005" >> "$file"
  echo "$((next_number + i + 1)),1322374,\"Second item $((i + 1))\",,0,504318,6005" >> "$file"
  echo "$((next_number + i + 2)),1322374,\"Third item $((i + 1))\",,0,504319,6005" >> "$file"
  echo "$((next_number + i + 3)),1322374,\"Fourth item $((i + 1))\",,0,504319,6005" >> "$file"
  echo "$((next_number + i + 4)),1322374,\"Fifth item $((i + 1))\",,0,504319,6005" >> "$file"
  echo "$((next_number + i + 5)),1322374,\"Sixth item $((i + 1))\",,0,504319,6005" >> "$file"
  echo "$((next_number + i + 6)),1322374,\"Seventh item $((i + 1))\",,0,504319,6005" >> "$file"
  echo "$((next_number + i + 7)),1322374,\"Eighth item $((i + 1))\",,0,504319,6005" >> "$file"
  echo "$((next_number + i + 8)),1322374,\"Ninth item $((i + 1))\",,0,504319,6005" >> "$file"
  echo "$((next_number + i + 9)),1322374,\"Tenth item $((i + 1))\",,0,504319,6005" >> "$file"


echo "10 lines have been added to $file."

#!/bin/bash

# N awk N sed N grep
FILES=$@

#
##      arg:	PREFIX, the file
##      desc:	find the name in the file
#
function find_name {
  # keeping only the first line to having the name
  NAME=$(cat "$1" | head -n 1)  
}

#
##      arg:	PREFIX, the file
##      desc:	find the percent in the file
#
function find_percent {
  # find the two lines after statified cross valid/ -A is for displaying line after, --text is for don't minding the binary that appear
  THREE_LINE=$(cat "$1" | grep --text -A 2 "=== Stratified cross-validation ===")
  # Erase the two first line that we don't want. sed erase the text, grep the blank line. the following line with tail can do the same but sed/grep was in pdf
  # GOOD_LINE=$(echo "$THREE_LINE" | tail -n 1)
  GOOD_LINE=$(echo "$THREE_LINE" | sed 's/=== Stratified cross-validation ===//' | grep "\S" | tail -n 1)
  # finaly isole arg nbr 5 of the string with awk
  POURCENT=$(echo "$GOOD_LINE" | awk '{print $5}')
}

#### MAIN, loop over the files
for  file in $FILES; do
  if cat "$file" | grep -q "=== Stratified cross-validation ==="; #run grep in quiet mode (-q) just for finding file with the line we want
  then
    find_name $file
    find_percent $file
    # print like in the example: job_name percent
    echo "$NAME $POURCENT"
  fi
done
#!/bin/bash

if [ $# -ne 0 ]
then
  (>&2 echo "Usage: no arg expected")
  (>&2 echo "       run main task (1) script (execute_on_all_db.sh), output nbr 187, and folder uci-data")
  exit 1
else
  bash execute_on_all_db.sh uci-data
fi
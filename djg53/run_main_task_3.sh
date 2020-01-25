#!/bin/bash

if [ $# -ne 0 ]
then
  (>&2 echo "Usage: no arg expected")
  (>&2 echo "       run main task (3) script like: average-performance.sh results_final-task-2/slurm-1-cloud01.out")
  exit 1
else
  bash average-performance.sh slurm-2-cloud01.out
fi
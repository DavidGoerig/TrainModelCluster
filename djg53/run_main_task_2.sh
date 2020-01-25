#!/bin/bash

if [ $# -ne 0 ]
then
  (>&2 echo "Usage: no arg expected")
  (>&2 echo "       run main task (2) script like: bash resultsweka.sh results/slurm*.out")
  exit 1
else
  sbatch -o slurm-2-cloud01.out -e slurm-2-cloud01.err resultsweka.sh results/slurm*.out
fi
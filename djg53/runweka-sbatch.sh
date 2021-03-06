#!/bin/bash

#SBATCH --nodes=1 # number of cluster nodes, abbreviated by -N
#SBATCH -o slurm-%j-%N.out # name of the stdout, using the job number (%j) and the first node (%N)
#SBATCH -e slurm-%j-%N.err # name of the stderr, using job and first node values
#SBATCH --ntasks=1 # number of SLURM tasks, abbreviated by -n

if [ $# -ne 1 ]
then
  (>&2 echo "Usage: `basename $0` {1 arg expected}")
  (>&2 echo "       a path to your data file is required as a command line parameter")
  (>&2 echo "       error message generated by runweka-sbatch.sh")
  exit 1
fi

export DATASETNAME=`basename $1 .arff`

# the first line in the output is the name of the data file
echo "$DATASETNAME"

# task 1
# java -Xmx1000M -cp weka-3-6-13/weka.jar weka.classifiers.trees.RandomForest -t $1 -i -I 10000 -K 100
#task 4
java -Xmx1000M -cp weka-3-6-13/weka.jar weka.classifiers.trees.J48 -t $1 -i
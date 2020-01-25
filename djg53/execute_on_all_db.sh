#!/bin/bash


#
##      desc: display the help and quit
#
function display_help_and_quit {
	(>&2 echo "Usage: ‘foldername $0‘ {1 arg  expected}")
        (>&2 echo "	one  command  line  parameter  is  required:")
        (>&2 echo "		- the name of the folder")
        (>&2 echo "		- auto for 'uci-data' folder.")
        exit 1
}

#
##      arg: stdin arg number $#
##      desc: check if arg number equal to 1
#
function check_arg_nbr {
	if [ $1 -ne 1 ]
	then
		display_help_and_quit
	fi
}

#
##      arg: first arg stdin
##      desc: check if the first argument try
#
function is_command_help {
if [ "$1" = "-h" ]
then
       	display_help_and_quit
fi
}

#
##      arg: first arg stdin
##      desc: if auto in argument set prefix path to uci-data
#
function check_prefix_auto {
        if [ "$1" = "auto" ]
        then
                PREFIX="uci-data"
        fi
}

#
##      desc: create result folder if it don't exist, clean it if exist
#
function check_result_folder {
        RESULTFOLDER=results
        if [ -d "$RESULTFOLDER" ]; then
        	rm -rf results
		mkdir results
        else
                mkdir results
        fi
}

#
##      arg:	PREFIX, the folder name where to execute all jobs
##      desc:	loop in the given file and execute all the jobs with several parameters (time limit, ram, partition, etc.)
#
function loop_and_execute {
        COUNTER=1
        for  file in "$PREFIX/"*; do
                # execute each jobs with:
                #       - time limit (--time) = 45 minutes
                #       - 1GB of RAM (--rem = 1024MB)
                #       - on the partition named cpu (--partition=cpu)
                sbatch --time=00:45:00 --partition=cpu --mem=1024 -o results/slurm-$COUNTER-cloud01.out -e results/slurm-$COUNTER-cloud01.err runweka-sbatch.sh $file
                #increment the counter variable for the filenames (so they are in order)
                COUNTER=$[COUNTER + 1]
        done
}

#
##      MAIN
#
check_arg_nbr $#
is_command_help $1
PREFIX=$1
check_prefix_auto $1
check_result_folder
loop_and_execute $PREFIX

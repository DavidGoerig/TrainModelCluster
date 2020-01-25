#!/bin/bash

#
##      desc: display the help and quit
#
function display_help_and_quit {
	(>&2 echo "Usage: ‘filename $0‘ {1 arg  expected}")
        (>&2 echo "	one  command  line  parameter  is  required:")
        (>&2 echo "		- the name of the file")
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
## arg: file to loop on
##	desc: loop on file to compute percent
function loop_and_compute {
	total=0.0
	COUNTER=0
	while read p; do
		# get the percet in the file with aw
		POURCENT=$(echo "$p" | awk '{print $2}')
		# add the percent to the total (to get the sum of all the percent)
		total=$(echo "$total + $POURCENT" | bc)
		# increment the counter (to know how many percent was added to calc the mean)
		COUNTER=$[COUNTER + 1]
	done <$1
	# calc the mean total_percent/nbr_percent
	average=$(echo "$total / $COUNTER" | bc)
	# put it in the file result_main_task_3.txt (override the file with > and redirect in the file)
	echo "$average" > result_main_task_3.txt
}

#
##      MAIN
#
check_arg_nbr $#
is_command_help $1
loop_and_compute $1
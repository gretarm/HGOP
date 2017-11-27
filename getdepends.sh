#!/bin/bash

#Solution to assignment https://github.com/hgop/syllabus-2017/blob/master/Assignment/Day1/Assignment.md
    
# Prints currents users and hostname
echo Welcome $USER,
echo Host:  $HOSTNAME
#Gets and prints current enviroment. Not tested on other than Ubuntu...
echo System:    $(grep -e "DISTRIB_DESCRIPTION" /etc/*-release | grep -oP '"\K[^"\047]+(?=["\047])')
echo 
echo "This script uses  Ubuntu built in package manager apt-get to download and install required dependencies for this project."

read -p "Do you want to run the script? (y/n)  " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    STARTTIME=$(date +%s%N)
    echo "Script started on $(date)"
    sleep 1
    echo "Script ended $(date)"
    RUNTIME=$((($(date +%s%N) - $STARTTIME)/1000000))
    
    echo "The script took $RUNTIME ms to run."
    
fi
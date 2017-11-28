#!/bin/bash

#Solution to assignment https://github.com/hgop/syllabus-2017/blob/master/Assignment/Day1/Assignment.md
    
# Prints currents users and hostname
echo Welcome $USER@$HOSTNAME
#Gets and prints current enviroment.
echo System: $(grep -e "DISTRIB_DESCRIPTION" /etc/*-release | grep -oP '"\K[^"\047]+(?=["\047])')
#Description of the script and then promts user for permission to run
echo "This script installs VScode editor, GIT and other programs/dependencies needed for this project."
read -p "Do you want to run this script? (y/n)  " -n 1 -r

#Runs if y/Y is answered
if [[ $REPLY =~ ^[Yy]$ ]]; then
    #Used to calculate total time elapsed later an script
    STARTTIME=$(date +%s%N)
    #prints time script starts to run
    echo "Script started on $(date)"

    #Checks if VScode is part of sources. 
    if [ ! -f /etc/apt/sources.list.d/vscode.list ]; then
        #VScode is not available through apt-get so this function adds needed source for VScode from MS
        sudo apt-get install curl
        curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
        sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
        sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    fi
    #Then update the package cache and installs listed packages 
    sudu apt-get update
    sudo apt-get install git code

    #shows the time when script has finished running 
    echo "Script ended   $(date)"
    
    #calculates elapsed time in Milliseconds and prints
    RUNTIME=$((($(date +%s%N) - $STARTTIME)/1000000))
    echo "The script took $RUNTIME ms to run."
    
fi
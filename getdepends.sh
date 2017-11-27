#!/bin/bash

# Prints currents users
echo Hello $USER 
#Gets and prints current enviroment. Not tested on other than Ubuntu...
echo Current distro: $(grep -e "DISTRIB_DESCRIPTION" /etc/*-release | grep -oP '"\K[^"\047]+(?=["\047])')
read -p "Do you want to use this script to get the required dependecies? y/n " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    date
fi
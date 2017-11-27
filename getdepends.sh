#!/bin/bash

# this is a comment
echo Hello $USER 
echo System information:
lsb_release -a
read -p "Do you want to use this script to get the required dependecies? y/n " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    date
fi
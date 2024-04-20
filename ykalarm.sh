#!/bin/env bash

#####################################################
# Name : yktool-ykalarm                             #
# Description : tool to save command and how usage  #
# Author : Yazan Kh                                 #
# Date : Thu 20/4/2023                              #
# Version : 0.0.1-alpha                             #
#####################################################

########################################
####{ CONFIGURATION FILE VARIABLES }####


########################################
##########{ GLOBE VARIABLES }###########

red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
white="\033[1;37m"
purple="\033[1;35m"

########################################
#############{ FUNCTIONS }##############

if [[ $# > 0 ]]
then
 echo $*
fi

########################################
################{ MAIN }################

main()
{
echo main
}

########################################
###########{ START SCRIPT  }############

printf $purple"==<< Start yktool-ykalarm >>==\n"

main

printf $purple"==<< End yktool-alarm >>=="

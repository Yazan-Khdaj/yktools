#!/bin/env bash

#####################################################
# Name : yktool-ykhist                              #
# Description : tool to save command and how usage  #
# Author : Yazan Kh                                 #
# Date : Tue 18/4/2023                              #
# Version : 0.0.6-alpha                             #
#####################################################

########################################
####{ CONFIGURATION FILE VARIABLES }####

source ./config.d/ykcomm.conf

if [[ -z $BACKUP_PATH  ]]
then
    BACKUP_PATH=$HOME
fi

if [[ -z $NAME_DIR  ]]
then
    NAME_DIR=".backup"
fi

if [[ -z $HISTORY_NAME ]]
then
    HISTORY_NAME=".zsh_history"
fi

if [[ -z $DROP_CMD ]]
then
    DROP_CMD="cd|ls|man|echo|nano|vim|vi|rm|rmdir|cat|less|mv|cp|who|which|whatis|whoami|info|more|open|mkdir|touch|xmore|zcat|zless"
fi

########################################
##########{ GLOBE VARIABLES }###########

backupDir=$BACKUP_PATH/$NAME_DIR
saveFile=$backupDir/"history.bak"
historyFile=$HOME/$HISTORY_NAME
tmpFile="/tmp/history.tmp"

#####{ Colors }#####

red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
white="\033[1;37m"
purple="\033[1;35m"

########################################
#############{ FUNCTIONS }##############

getBackup()
{
    cd $backupDir
    printf $yellow"***copy history to %s***\n"$white $backupDir
    cp -v $historyFile $saveFile ||exit 1
    printf $green"(copy done)\n"
}

checkBackupDir()
{
    cd $BACKUP_PATH

    if [[ -e $backupDir ]]
    then
        printf $white"(backup directory exits)\n"
        getBackup
    else
        printf $red"(backup directory don't exits)\n"$white
        printf $yellow"***create backup directory in %s ***\n" $BACKUP_PATH
        mkdir $NAME_DIR
        getBackup
    fi
}

filterHistory()
{
    mostCmd="^[[:alpha:]]+[[:print:]]*[[:space:]]+[-]{0,2}."
    notHelp=".* -{1,2}(h|help|usage)"

    printf $yellow"***filtering history file***\n"
    res=$(cat -v $saveFile | sort | uniq | grep -E "$mostCmd" | grep -E -v "^($DROP_CMD)"| grep -E -v "$notHelp" || exit 2)
    echo "$res" > $tmpFile
    printf $green"(filter done)\n"
}

updateHistory()
{
    printf $yellow"***update history file***\n"$white
    cat $tmpFile > $historyFile || exit 3
    printf $green"(update done)\n"$white
    rm -v $tmpFile || exit 4
}

usage()
{
    printf $white"\
        yktool-ykhist   tool to save command and how usage
            Write by:  Yazan Kh <yazankh.dev@gmail.com>
            usage:
            $(basename $0) -[options]
            options:
            -v      show version
            -u      show this usage help
            \n"
        }

        version()
        {
            printf $green"$(basename $0) version 0.0.6-alpha\n"
        }

########################################
################{ MAIN }################

main()
{
    checkBackupDir

    filterHistory

    updateHistory
}

########################################
###########{ START SCRIPT  }############

printf $purple"==<< Start yktool-ykhist >>==\n"

if [[ $1 == "-u"  ]]
then
    usage
elif [[ $1 == "-v" ]]
then
    version
else
    main
fi

printf $purple"==<< End yktool-ykhist >>=="
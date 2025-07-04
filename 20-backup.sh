#!/bin/bash

USERID=$(id -u)
SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} # IF DAYS ARE PROVIDED THAT WILL BE CONSIDERED, OTHER WISE DEFAULT 14 DAYS

# creating a variable here
LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

check_root
mkdir -p $LOGS_FOLDER

USAGE(){
    echo -e "$R USAGE:: $N sh 20-backup.sh <source-dir> <destination-dir> <days(optional)>"
}

if [ $# -lt 2 ]
then
    USAGE
fi











# validate function takes input as exit status, what command they tried to install
VALIDATE(){
    if [ $1 -eq 0 ]
    then 
        echo -e "$2 is ... $G SUCCESS $N" | tee -a $LOG_FILE  # tee command --> adds single input to the multiple outputs to the screen and also to the file.
    else 
        echo -e "$2 is ... $R FAILURE $N" | tee -a $LOG_FILE 
        exit 1
    fi
}

check_root(){
    if [ $USERID -ne 0 ]
    then
        echo -e "$R ERROR:: please run this script with root access $N" | tee -a $LOG_FILE
        exit 1 #if you want to manually exit then give other than 0, upto 127
    else
        echo "You are running with the root access" | tee -a $LOG_FILE
    fi
}
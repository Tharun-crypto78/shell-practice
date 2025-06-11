#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
# creating a variable here
LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
PACKAGES=("mysql", "python3", "nginx", "httpd")

mkdir -p $LOGS_FOLDER
echo "Script started executing at: $(date)" | tee -a $LOG_FILE 

if [ $USERID -ne 0 ]
then
    echo -e "$R ERROR: please run this script with root access $N" | tee -1 $LOG_FILE
    exit 1 #if you want to manually exit then give other than 0, upto 127
else
    echo "You are running with the root access" &>>$LOG_FILE
fi

VALIDATE(){
    if [ $? -eq 0 ]
    then 
        echo -e "Installing $2 is $G SUCCESS $N" | tee -a $LOG_FILE 
    else 
        echo -e "Installing $2 is $R FAILURE $N" | tee -a $LOG_FILE 
        exit 1
    fi
}

for package in ${PACKAGES[@]}
do 
    dnf list installed $package &>>LOG_FILE
    if [ $? -ne 0 ]
    then
        echo "$package is not installed..... is about to install it" | tee -a $LOG_FILE 
        dnf install $package -y &>>$LOG_FILE  
        # we can check the exit status
        VALIDATE $? "$package"
    else  
        echo -e "Nothing to do $package... $Y is already installed $N." | tee -a $LOG_FILE 
    fi
done
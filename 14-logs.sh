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

mkdir -p $LOGS_FOLDER
echo "Script started executing at: $(date)" &>>$LOG_FILE

if [ $USERID -ne 0 ]
then
    echo -e "$R ERROR: please run this script with root access $N" &>>$LOG_FILE
    exit 1 #if you want to manually exit then give other than 0, upto 127
else
    echo "You are running with the root access" &>>$LOG_FILE
fi

VALIDATE(){
    if [ $? -eq 0 ]
    then 
        echo -e "Installing $2 is $G SUCCESS $N" &>>$LOG_FILE
    else 
        echo -e "Installing $2 is $R FAILURE $N" &>>$LOG_FILE
        exit 1
    fi
}

dnf list installed mysql &>>$LOG_FILE

if [ $? -ne 0 ]
then
    echo "MySQL is not installed..... is about to install it" &>>$LOG_FILE
    dnf install mysql -y &>>$LOG_FILE
    # we can check the exit status
    VALIDATE $? "MySQL"
else  
    echo -e "Nothing to do MySQL... $Y is already installed $N." &>>$LOG_FILE
fi

dnf list installed python3 &>>$LOG_FILE

if [ $? -ne 0 ]
then
    echo "python3 is not installed..... is about to install it" &>>$LOG_FILE
    dnf install python3 -y &>>$LOG_FILE
    # we can check the exit status
    VALIDATE $? "python3"
else  
    echo -e "Nothing to do python3.... $Y is already installed $N." &>>$LOG_FILE
fi

dnf list installed nginx &>>$LOG_FILE

if [ $? -ne 0 ]
then
    echo "nginx is not installed..... is about to install it" &>>$LOG_FILE
    dnf install nginx -y &>>$LOG_FILE
    # we can check the exit status
    VALIDATE $? "nginx"
else  
    echo -e "Nothing to do nginx.... $Y is already installed $N " &>>$LOG_FILE
fi
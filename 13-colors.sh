#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0 ]
then
    echo -e "$R ERROR: please run this script with root access $N"
    exit 1 #if you want to manually exit then give other than 0, upto 127
else
    echo "You are running with the root access"
fi

VALIDATE(){
    if [ $? -eq 0 ]
    then 
        echo -e "Installing $2 is $G SUCCESS $N"
    else 
        echo -e "Installing $2 is $R FAILURE $N"
        exit 1
    fi
}

dnf list installed mysql

if [ $? -ne 0 ]
then
    echo "MySQL is not installed..... is about to install it"
    dnf install mysql -y
    # we can check the exit status
    VALIDATE $? "MySQL"
else  
    echo -e "Nothing to do MySQL... $Y is already installed $N."
fi

dnf list installed python3

if [ $? -ne 0 ]
then
    echo "python3 is not installed..... is about to install it"
    dnf install python3 -y
    # we can check the exit status
    VALIDATE $? "python3"
else  
    echo -e "Nothing to do python3.... $Y is already installed $N."
fi

dnf list installed nginx

if [ $? -ne 0 ]
then
    echo "nginx is not installed..... is about to install it"
    dnf install nginx -y
    # we can check the exit status
    VALIDATE $? "nginx"
else  
    echo -e "Nothing to do nginx.... $Y is already installed $N "
fi
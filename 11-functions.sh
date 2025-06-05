#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "ERROR: please run this script with root access"
    exit 1 #if you want to manually exit then give other than 0, upto 127
else
    echo "You are running with the root access"
fi

VALIDATE(){
    if [ $? -eq 0 ]
    then 
        echo "Installing $2 is SUCCESS"
    else 
        echo "Installing $2 is FAILURE"
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
    echo "MySQL is already installed... nothing to do."
fi

dnf list installed python3

if [ $? -ne 0 ]
then
    echo "python3 is not installed..... is about to install it"
    dnf install python3 -y
    # we can check the exit status
    VALIDATE $? "python3"
else  
    echo "python3 is already installed... nothing to do."
fi

dnf list installed nginx

if [ $? -ne 0 ]
then
    echo "nginx is not installed..... is about to install it"
    dnf install nginx -y
    # we can check the exit status
    VALIDATE $? "nginx"
else  
    echo "nginx is already installed... nothing to do."
fi
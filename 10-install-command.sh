#!/bin/bash

USERID=$(id -u)
# Here shell executes the command (id -u) and store the value in the USERID variable

if [ $USERID -ne 0 ]
then
    echo "ERROR: please run this script with root access"
    exit 1 #if you want to manually exit then give other than 0, upto 127
else
    echo "You are running with the root access"
fi

dnf list installed mysql

if [ $? -ne 0 ]
then
    echo "MySQL is not installed..... is about to install it"
    dnf install mysql -y
    # we can check the exit status
    if [ $? -eq 0 ]
    then 
        echo "Installing MySQL is SUCCESS"
    else 
        echo "Installing MySQL is FAILURE"
        exit 1
    fi
else  
    echo "MySQL is already installed... nothing to do."
fi


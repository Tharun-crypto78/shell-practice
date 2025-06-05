#!/bin/bash

USERID=$(id -u)
# Here shell executes the command (id -u) and store the value in the USERID variable

if [ $USERID -ne 0 ]
then
    echo "ERROR: please run this script with root access"
else
    echo "You are running with the root access"
fi

dnf install mysql -y
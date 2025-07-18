#!/bin/bash

DISK_USAGE=$(df -hT | grep -v Filesystem)
DISK_THRESHOLD=1 # In projects it will be 75. Here we're using 1 as threshold value
MSG=""
IP=$(curl  http://169.254.169.254/latest/meta-data/local-ipv4)

while IFS= read line
do
    USAGE=$(echo $line | awk '{print $6F}' | cut -d "%" -f1)
    PARTITION=$(echo $line | awk '{print $7F}')
    if [ $USAGE -ge $DISK_THRESHOLD ]
    then
        MSG+="High Disk Usage on $PARTITION: $USAGE % <br>" # <br> represents new line in HTML
    fi
done <<< $DISK_USAGE

#echo -e $MSG

sh mail.sh "DevOps Team" "High Disk Usage" "$IP" "$MSG" "tharun.pythoon@gmail.com" "ALERT-High Disk Usage"
#!/bin/bash

# a=0

# while [ $a -lt 10 ]
# do
#    echo $a
#    a=`expr $a + 1`
# done

while IFS= read -r line #read line by line
do
    echo $line # prints each line ones it is read
done < 17-set.sh
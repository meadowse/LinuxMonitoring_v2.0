#!/bin/bash
if [ $# != 0 ]
then
    echo "Error"
    exit 1
else
    while true
    do
        if [[ -f data.html ]]
        then
            rm data.html
        fi
        echo "cpu $(cat /proc/loadavg | awk '{print $1}')" > data.html
        echo "memory_free $(free -m | awk 'NR==2 {print $7}')" >> data.html
        echo "memory_used $(free -m | awk 'NR==2 {print $3}')" >> data.html
        echo "space_used $(df / | awk 'NR==2 {print $3}')" >> data.html
        echo "space_available $(df / | awk 'NR==2 {print $4}')" >> data.html
        sleep 3
    done
fi
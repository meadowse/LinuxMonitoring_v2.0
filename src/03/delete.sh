#!/bin/bash
function clean1 {
    for var in $(cat ../02/log.txt)
    do
        reg='^\/'
        if [[ $var =~ $reg ]]
        then
            rm -rf $var
        fi
    done
}
function clean2 {
    echo "Enter the date and time (example: YYYY-MM-DD HH:MM)"
    read -p "Write start date and time: " start
    reg='^[0-9]{3}[1-9]-[0][1-9]-[0-2][1-9] [0-9]{2}:[0-9]{2}$|^[0-9]{3}[1-9]-1[0-2]-3[01] [0-9]{2}:[0-9]{2}$'
    if ! [[ $start =~ $reg ]]
    then
        echo "invalid date entered"
        exit 1
    fi
    echo "Enter the date and time (example: YYYY-MM-DD HH:MM)"
    read -p "Write end date and time: " end
    if ! [[ $end =~ $reg ]]
    then
        echo "invalid date entered"
        exit 1
    fi
    find / -newermt "$start" ! -newermt "$end" -type d 2>/dev/null | grep $(date +"%d%m%y") | xargs rm -rf
}
function clean3 {
    mask='^.*[a-zA-Z]+_[0-9]{6}$'
    find / -regextype posix-extended -regex $mask 2>/dev/null | xargs rm -rf
}

#!/bin/bash
function search1 {
    for item in $(find ~/DO4_LinuxMonitoring_v2.0-0/src/04/*.log)
    do
        sort -k 9 $item -o search1_1.log
        IFS=$'/'
        for var in $item
        do
            reg='^[0-9]{4}-[0-9]{2}-[0-9]{2}\.log$'
            if [[ $var =~ $reg ]]
            then
                i=$var
            fi
        done
        mv search1_1.log search1_$i
        IFS=$'\n'
    done
}
function search2 {
    for item in $(find ~/DO4_LinuxMonitoring_v2.0-0/src/04/*.log)
    do
        awk '{print $1}' $item | uniq > search2_2.log
        IFS=$'/'
        for var in $item
        do
            reg='^[0-9]{4}-[0-9]{2}-[0-9]{2}\.log$'
            if [[ $var =~ $reg ]]
            then
                i=$var
            fi
        done
        mv search2_2.log search2_$i
        IFS=$'\n'
    done
}
function search3 {
    for item in $(find ~/DO4_LinuxMonitoring_v2.0-0/src/04/*.log)
    do
        awk '$9 ~ /[45]/' $item > search3_3.log
        IFS=$'/'
        for var in $item
        do
            reg='^[0-9]{4}-[0-9]{2}-[0-9]{2}\.log$'
            if [[ $var =~ $reg ]]
            then
                i=$var
            fi
        done
        mv search3_3.log search3_$i
        IFS=$'\n'
    done
}
function search4 {
    for item in $(find ~/DO4_LinuxMonitoring_v2.0-0/src/04/*.log)
    do
        awk '$9 ~ /[45]/' $item | awk '{print $1}' | uniq > search4_4.log
        IFS=$'/'
        for var in $item
        do
            reg='^[0-9]{4}-[0-9]{2}-[0-9]{2}\.log$'
            if [[ $var =~ $reg ]]
            then
                i=$var
            fi
        done
        mv search4_4.log search4_$i
        IFS=$'\n'
    done
}
#!/bin/bash
function create {
    start=$(date +'%s%N')
    startTime=$(date +'%Y-%m-%d %H:%M:%S')
    echo "Script started at $startTime" > log.txt
    echo "Script started at $startTime"
    countDirs=$(echo $(( 1 + $RANDOM % 100 )))
    countDir=$countDirs
    k=0
    createListOfDirs
    createArrFiles
    for (( i=0; $countDir-i > 0; i++ ))
    do
        createDir
    done
    stop_script
}
function createListOfDirs {
    I=0
    for var in $(find / -type d 2>/dev/null)
    do
        IFS=$'\n'
        flag=1
        reg='sys'
        if ! [[ $var =~ $reg ]]
        then
            for item in $(mkdir $var/a 2>&1)
            do
                reg='mkdir'
                if [[ $item =~ $reg ]]
                then
                    flag=0
                fi
            done
        fi
        reg='\/[s]?bin|sys'
        if [[ $flag -eq 1 ]] && ! [[ $var =~ $reg ]]
        then
            rm -rf $var/a
            listDirs[$I]=$var
            I=$(( $I + 1 ))
        fi
    done
}
function createDir {
    dirName="" # dirName
    if [[ $i -eq 0 ]]
    then
        dirName+=$lettersDirs # lettersDirs
        indexDir=$i # index
    else
        dirName+="$(echo ${arrDirs[$indexDir]})" # arr[*]
    fi
    while [[ ${#dirName} -lt 5 ]]
    do
        if [[ ${#lettersDirs} -eq 3 ]]
        then
            dirName="$(echo ${lettersDirs:0:2}${lettersDirs:1:2})"
        elif [[ ${#lettersDirs} -eq 2 ]]
        then
            dirName+="$(echo ${lettersDirs:1:1})"
        fi
        dirName="$(echo ${lettersDirs:0:1}$dirName)"
    done
    if [[ ${#dirName} -ge 5 ]]
    then
        if [[ $i -eq 0 ]]
        then
            dirNameStart=$dirName
        else
            for (( j=0; j < ${#lettersDirs}; j++ )) # j
            do
                str="" # str
                for (( n=0; n < ${#dirName} ; n++ )) # n
                do
                    if [[ ${dirName:n:1} = ${lettersDirs:j:1} ]]
                    then
                        str+="$(echo ${dirName:n:1})"
                    fi
                done # fi n
                arrayLetter[$j]=$str # array[*]
            done # fi j
            arrayLetter[$(( $i % ${#lettersDirs} - 1 ))]+="$(echo ${lettersDirs:$(( $i % ${#lettersDirs} - 1 )):1})"
            dirName=""
            for (( j=0; j < ${#arrayLetter[*]}; j++ )) # j
            do
                dirName+="$(echo ${arrayLetter[$j]})"
            done # fi j
            dirNameStart=$dirName
        fi
        flag=1 # flag
        for (( j=0; j < ${#arrDirs[*]}; j++ )) # j
        do
            if [[ ${arrDirs[$j]} = $dirName && ${#arrDirs[$j]} -eq ${#dirName} ]]
            then
                countDir=$(( $countDir + 1 ))
                flag=0
            fi
        done # fi j
        if [[ $flag -eq 1 && $k -lt $countDirs ]]
        then
            arrDirs[$k]=$dirNameStart
            k=$(( $k + 1 ))
            dirName+="_"
            dirName+=$(date +"%d%m%y")
            random=$(( $RANDOM % ${#listDirs[*]} ))
            mkdir ${listDirs[$random]}/$dirName
            echo ${listDirs[$random]}"/"$dirName --- $(date +'%Y-%m-%d %H:%M:%S') ---  >> log.txt
            createFiles $dirName $random
        elif [[ $k -ge $countDirs ]]
        then
            break
        fi
    fi
    if [[ $(( $i % ${#lettersDirs} )) -eq 0 && $i -ne 0 ]]
    then
        indexDir=$(( $indexDir + 1 ))
    fi
}
function createArrFiles {
    m=0
    countFiles=1000
    count=$countFiles
    lettersFilesLeft="$(echo $lettersFiles | awk -F "." '{print $1}')"
    lettersFilesRight="$(echo $lettersFiles | awk -F "." '{print $2}')"
    LettersFiles="$(echo $lettersFilesLeft$lettersFilesRight)"
    for (( l=0; $count-l > 0; l++ ))
    do
        fileName=""
        if [[ $l -eq 0 ]]
        then
            fileName+=$lettersFiles
            index=$l
        else
            fileName+="$(echo ${arrNames[$index]})"
        fi
        fileNameLeft="$(echo $fileName | awk -F "." '{print $1}')"
        while [[ ${#fileNameLeft} -lt 5 ]]
        do
            if [[ ${#fileNameLeft} -eq 3 ]]
            then
                fileNameLeft="$(echo ${fileNameLeft:0:2}${fileNameLeft:1:2})"
            elif [[ ${#fileNameLeft} -eq 2 ]]
            then
                fileNameLeft+="$(echo ${fileNameLeft:1:1})"
            fi
            fileNameLeft="$(echo ${fileNameLeft:0:1}$fileNameLeft)"
        done
        fileNameRight="$(echo $fileName | awk -F "." '{print $2}')"
        if [[ ${#fileNameLeft} -ge 5 ]]
        then
            if [[ $l -eq 0 ]]
            then
                arr[$l]="$(echo $fileNameLeft.$fileNameRight)"
                fileName="$(echo $fileNameLeft.$fileNameRight)"
            else
                J=0
                for (( j=0; j < ${#lettersFilesLeft}; j++ ))
                do
                    str=""
                    for (( n=0; n < ${#fileNameLeft} ; n++ ))
                    do
                        if [[ ${fileNameLeft:n:1} = ${lettersFilesLeft:j:1} ]]
                        then
                            str+="$(echo ${fileNameLeft:n:1})"
                        fi
                    done
                    array[$J]=$str
                    J=$(( $J + 1 ))
                done
                for (( j=0; j < ${#lettersFilesRight}; j++ ))
                do
                    str=""
                    for (( n=0; n < ${#fileNameRight} ; n++ ))
                    do
                        if [[ ${fileNameRight:n:1} = ${lettersFilesRight:j:1} ]]
                        then
                            str+="$(echo ${fileNameRight:n:1})"
                        fi
                    done
                    array[$J]=$str
                    J=$(( $J + 1 ))
                done
                array[$(( $l % ${#LettersFiles} - 1 ))]+="$(echo ${LettersFiles:$(( $l % ${#LettersFiles} - 1 )):1})"
                arr[$l]=""
                for (( j=0; j < ${#array[*]}; j++ ))
                do
                    if [[ $j -eq ${#lettersFilesLeft} ]]
                    then
                        arr[$l]+="$(echo ".")"
                    fi
                    arr[$l]+="$(echo ${array[$j]})"
                done
                fileName="$(echo ${arr[$l]})"
            fi
            flag=1
            for (( j=0; j < ${#arr[*]} - 1; j++ ))
            do
                if [[ ${arr[$j]} = $fileName && ${#arr[$j]} -eq ${#fileName} ]]
                then
                    count=$(( $count + 1 ))
                    flag=0
                fi
            done
            if [[ $flag -eq 1 && $m -lt $countFiles ]]
            then
                arrNames[$m]=$fileName
                m=$(( $m + 1 ))
            elif [[ $m -ge $countFiles ]]
            then
                break
            fi
        fi
        if [[ $(( $l % ${#LettersFiles} )) -eq 0 && $l -ne 0 ]]
        then
            index=$(( $index + 1 ))
        fi
    done
}
function createFiles () {
    ran=$(( $RANDOM % 1000 ))
    for (( r=0; r < $ran; r++ ))
    do
        if [[ $(df / -BM | grep "/" | awk -F"M" '{ print $3 }') -le 1024 ]]
        then
            stop_script
            exit 1
        fi
        fileName=${arrNames[$r]}
        fileName+="_"
        fileName+=$(date +"%d%m%y")
        fallocate -l $size"MB" ${listDirs[$random]}/$dirName/$fileName
        echo ${listDirs[$random]}"/"$dirName"/"$fileName --- $(date +'%Y-%m-%d %H:%M:%S') --- $size "Mb" >> log.txt
    done
}
function stop_script {
    end=$(date +'%s%N')
    endTime=$(date +'%Y-%m-%d %H:%M:%S')
    echo "Script finished at $endTime" >> log.txt
    echo "Script finished at $endTime"
    diff=$((( $end - $start ) / 100000000 ))
    echo "Script execution time (in seconds) = $(( $diff / 10 )).$(( $diff % 10 ))" >> log.txt
    echo "Script execution time (in seconds) = $(( $diff / 10 )).$(( $diff % 10 ))"
    echo -e "" >> log.txt
}
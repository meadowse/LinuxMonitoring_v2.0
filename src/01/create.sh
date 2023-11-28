#!/bin/bash
function createNamesForDirs {
    countDir=$countDirs # countDir, countDirs
    k=0 # k
    for (( i=0; $countDir-i > 0; i++ )) # i
    do
        dirName="" # dirName
        if [[ $i -eq 0 ]]
        then
            dirName+=$lettersDirs # lettersDirs
            indexDir=$i # index
        else
            dirName+="$(echo ${arrDirs[$indexDir]})" # arr[*]
        fi
        while [[ ${#dirName} -lt 4 ]]
        do
            if [[ ${#lettersDirs} -eq 2 ]]
            then
                dirName+="$(echo ${lettersDirs:1:1})"
            fi
            dirName="$(echo ${lettersDirs:0:1}$dirName)"
        done
        if [[ ${#dirName} -ge 4 ]]
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
            dirName+="_"
            dirName+=$(date +"%d%m%y")
            for item in $(mkdir $pwd/$dirName 2>&1)
            do
                IFS=$'\n'
                reg='mkdir'
                if [[ $item =~ $reg ]]
                then
                    flag=0
                fi
            done
            if [[ $flag -eq 1 && $(( $countDirs - $k )) -gt 0 ]]
            then
                arrDirs[$k]=$dirNameStart
                k=$(( $k + 1 ))
                echo $pwd"/"$dirName --- $(date +'%e.%m.%Y') ---  >> log.txt
                createNamesForFiles $dirName
            elif [[ $(( $countDirs - $k )) -le 0 ]]
            then
                break
            else
                countDir=$(( $countDir + 1 ))
            fi
        fi
        if [[ $(( $i % ${#lettersDirs} )) -eq 0 && $i -ne 0 ]]
        then
            indexDir=$(( $indexDir + 1 ))
        fi
    done
}
function createNamesForFiles () {
    m=0
    if [[ ${#arrNames[*]} -eq $countFiles ]]
    then
        for item in ${arrNames[*]}
        do
            if [[ $(df / -BM | grep "/" | awk -F"M" '{ print $3 }') -le 1024 ]]
                then
                    exit 1
                fi
            fileName="$(echo $item)"
            fileName+="_"
            fileName+=$(date +"%d%m%y")
            fallocate -l $size"KB" $pwd/$dirName/$fileName
            echo $pwd"/"$dirName"/"$fileName --- $(date +'%e.%m.%Y') --- $size "Kb" >> log.txt
        done
    else
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
            while [[ ${#fileNameLeft} -lt 4 ]]
            do
                if [[ ${#fileNameLeft} -eq 2 ]]
                then
                    fileNameLeft+="$(echo ${fileNameLeft:1:1})"
                fi
                fileNameLeft="$(echo ${fileNameLeft:0:1}$fileNameLeft)"
            done
            fileNameRight="$(echo $fileName | awk -F "." '{print $2}')"
            if [[ ${#fileNameLeft} -ge 4 ]]
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
                    if [[ $(df / -BM | grep "/" | awk -F"M" '{ print $3 }') -le 1024 ]]
                    then
                        exit 1
                    fi
                    arrNames[$m]=$fileName
                    m=$(( $m + 1 ))
                    fileName+="_"
                    fileName+=$(date +"%d%m%y")
                    fallocate -l $size"KB" $pwd/$dirName/$fileName
                    echo $pwd"/"$dirName"/"$fileName --- $(date +'%e.%m.%Y') --- $size "Kb" >> log.txt
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
    fi
}
#!/bin/bash
date="$(date +%Y)-$(date +%m)-$(date +%d) 00:00:00 $(date +%z)"
if [ $# != 0 ]
then
    echo "Invalid number of arguments (should be 0)"
    exit 1
else
    for (( i=0; i<5; i++ ))
    do
        date="$(date -d "$date - 1 days" +'%Y-%m-%d')"
        random=$(shuf -n1 -i 100-1000)
        maxSeconds=$(( (86400 - 86400 % $random) / $random )) # 86400 секунд в дне
        for (( j=0; j<random; j++ ))
        do
            seconds=$(( $j * $maxSeconds + $(shuf -i 0-$maxSeconds -n1) ))
            echo -n "$(shuf -n1 -i 0-255).$(shuf -n1 -i 0-255).$(shuf -n1 -i 0-255).$(shuf -n1 -i 0-255)" >> $date.log
            echo -n " - - " >> $date.log
            echo -n "[$(date -d "$date + $seconds seconds"  +'%d/%b/%Y:%H:%M:%S %z')] " >> $date.log
            echo -n "\"$(shuf -n1 methods) " >> $date.log
            echo -n "$(shuf -n1 urls) " >> $date.log
            echo -n "$(shuf -n1 protocols)\" " >> $date.log
            echo -n "$(shuf -n1 codes)" >> $date.log
            echo -n " $(shuf -n1 -i 0-100)" >> $date.log
            echo -n " \"-\" " >> $date.log
            echo "\"$(shuf -n1 agents)\"" >> $date.log
        done
    done
fi
# 200 - OK
# 201 - CREATED
# 400 - BAD_REQUEST
# 401 - UNAUTHORIZED
# 403 - FORBIDDEN
# 404 - NOT_FOUND
# 500 - INTERNAL_SERVER_ERROR
# 501 - NOT_IMPLEMENTED
# 502 - BAD_GATEWAY
# 503 - SERVICE_UNAVAILABLE
#!/bin/bash
function validator {
    if [[ $countArg -ne 3 ]]
    then
        echo "invalid number of arguments"
        exit 1
    fi
    lat='^[a-zA-Z]{1,7}$'
    latList='^A?a?B?b?C?c?D?d?E?e?F?f?G?g?H?h?I?i?J?j?K?k?L?l?M?m?N?n?O?o?P?p?Q?q?R?r?S?s?T?t?U?u?V?v?W?w?X?x?Y?y?Z?z?$'
    if ! [[ $lettersDirs =~ $lat && $lettersDirs =~ $latList ]]
    then
        echo "incorrect name for folders"
        exit 1
    fi
    reg='^[a-zA-Z]{1,7}[.][a-zA-Z]{1,3}$'
    file='^A?a?B?b?C?c?D?d?E?e?F?f?G?g?H?h?I?i?J?j?K?k?L?l?M?m?N?n?O?o?P?p?Q?q?R?r?S?s?T?t?U?u?V?v?W?w?X?x?Y?y?Z?z?\.A?a?B?b?C?c?D?d?E?e?F?f?G?g?H?h?I?i?J?j?K?k?L?l?M?m?N?n?O?o?P?p?Q?q?R?r?S?s?T?t?U?u?V?v?W?w?X?x?Y?y?Z?z?$'
    if ! [[ $lettersFiles =~ $reg && $lettersFiles =~ $file ]]
    then
        echo "incorrect name for files"
        exit 1
    fi
    reg='^[1-9][0-9]?Mb|100Mb$'
    if ! [[ $size =~ $reg ]]
    then
        echo "incorrect size"
        exit 1
    else
        size=$(echo $size | awk -F"Mb" '{print $1}')
    fi
}
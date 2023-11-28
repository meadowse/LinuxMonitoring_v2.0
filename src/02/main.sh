#!/bin/bash
. ./validator.sh
. ./create.sh
export countArg=${#}
export lettersDirs=${1}
export lettersFiles=${2}
export size=${3}
validator
create
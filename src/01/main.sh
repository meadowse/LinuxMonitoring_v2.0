#!/bin/bash
. ./validator.sh
. ./create.sh
export countArg=${#}
export pwd=${1}
export countDirs=${2}
export lettersDirs=${3}
export countFiles=${4}
export lettersFiles=${5}
export size=${6}
validator
createNamesForDirs
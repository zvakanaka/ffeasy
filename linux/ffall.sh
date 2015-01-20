#!/bin/bash
#SHELL SCRIPT FOR EASIER FFMPEG - ALL IN FOLDER
#This script is compatible with ffeasy and is
# a FOLDER LOOP
#/home/adam/.bin/ffall

#USAGE: ffall MODE FOLDER                (omit slash after folder)
#Eg.    ffall android /home/user/Desktop (Converts all on desktop using android function in ffeasy)

#so that additional params can be added to suffix
pArray=(${@})

#TODO: customize each different mode(I have already begun with play)
mode="Dir"
echo mode set to $mode

echo -ne "\033]0;BUSY $promptInput mode:$mode\007"

for f in $1/*.*
do
    if [ "$2" = "play" ]; then
	ffeasy $2 "$f" $(for (( i = 2; i <= ${#}; i++ )); do echo ${pArray[${i}]}; done)
    elif [ "$2" = "other"  ]; then
	ffeasy $2 "$f" "${f%.*}$mode.${f#*.}"
    else
	ffeasy $2 "$f" "${f%.*}$mode.${f#*.}"
    fi
done
#diagnostic
for f in $1/*.*
do
    echo $2 "$f" "${f%.*}$mode.${f#*.}" $(for (( i = 2; i <= ${#}; i++ )); do echo ${pArray[${i}]}; done)
done


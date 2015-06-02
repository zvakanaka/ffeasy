#!/bin/bash
#SHELL SCRIPT FOR EASIER FFMPEG
#MASTER COPY TO BE ON ASUS 

#GLOBAL VARIABLES

#so that parameters passed to program can be kept
pArray=("${@}")
echo "${pArray[1]}"
echo done with array
#default settings, specific modes may change or ignore them
declare -i QUAL=5 #-q value (quality)
declare -i WIDTH=720
declare -i HEIGHT=480
declare -i FPS=23 #frames per second
#AUDIO BITRATE
ABR="128000" #audio bit rate

# FUNCTIONS

#take input and case check
check_input () {

    case $1 in
        "--android")
            android
            ;;
        "-a")
            android
            ;;
        a*)
            android
            ;;
        *cutf*)
            cutFront
            ;;
        *cutba*)
            cutBack
            ;;
        *cutbo*)
            cutBoth
            ;;
        "vars")
            display_vars
            ;;
        "ipod")
            Message="Function has yet to be built"
            ;;
        --p*)
            play
            ;;
        -p)
            play
            ;;
        "play")
            play
            ;;
        "simple")
            simple
            ;;
        rem*)
            remSeg
            ;;
        --rem*)
            remSeg
            ;;
        -r*)
            remSeg
            ;;
        *rot*)
            rotate
            ;;
        "-R")
            rotate
            ;;
        "tunaviDS")
            tunaviDS
            ;;
        *tuna*)
            tunaviDS
            ;;
        "-t")
            tunaviDS
            ;;
        *water*)
            watermark
            ;;
        "-w")
            watermark
            ;;
        --wat*)
            watermark
            ;;
        "wii")
            wii
            ;;
        "--wii")
            wii
            ;;
        "-W")
            wii
            ;;
        *tag*)
            tagDirectory
            ;;
        "")
            echo See man pages for ffeasy
            ;;
        *)
            Message="Is this guy speaking English?"
            printHelp
            ;;
    esac

    echo $Message

if [ ${#} -lt 1 ]
    then
        prompt_input
        check_input
    fi
}

#prompt user what to do
prompt_input () {
    local promptInput=""
    #user input to string
    read -p "type something to do something:" promptInput
    {pArray[0]}="$promptInput"
}

#convert for android
android () {
    local WIDTH=800
    local HEIGHT=480
    local VBR="500k"
    local mode="ANDROID"
    echo mode set to $mode

    if [ ${#} -lt 3 ]
    then
        {pArray[2]}="${{pArray[1]}%.*}$mode.${{pArray[1]}#*.}"
    fi
    #setting title
    echo -ne "\033]0;BUSY $promptInput mode:$mode ${{pArray[2]}}\007"

    ffmpeg -i ${pArray[1]} ${pArray[3]} -vcodec libx264 -profile:v high -preset fast -b:v $VBR -maxrate $VBR -bufsize 1000k -vf scale=$WIDTH:-1 -threads 0 -acodec aac -strict experimental -b:a $ABR -ac 2 -ab 44100 ${pArray[2]}
}

#CUT INFORMATION
#HOURS:MM:SS.MICROSECONDS, as in 01:23:45.678
#OR using 150.5 as in seconds
#ss start second cut CUTS THE BEGINNING OFF, keeps quality
#${pArray[1]}: inputFile ${pArray[3]}: outputFile ${pArray[2]}: startSecond 
cutFront() {
    local mode="CutFront"
    echo mode set to $mode

    if [ -z "${pArray[3]}" ]
    then
        {pArray[3]}=${pArray[2]}
        {pArray[2]}="${{pArray[1]}%.*}$mode.${{pArray[1]}#*.}"
    fi
    #setting title
    echo -ne "\033]0;BUSY $promptInput mode:$mode ${pArray[2]}\007"
    ffmpeg -i ${pArray[1]} -ss ${pArray[3]} -c copy  -avoid_negative_ts 1 ${pArray[2]}
}

#t seconds terminate CUTS THE END OFF, keeps quality
#${pArray[1]} inputFile ${pArray[2]} outputFile ${pArray[3]} terminateSecond 
cutBack() {
    local mode="CutBack"
    echo mode set to $mode
    if [ -z "${pArray[3]}" ]
    then
        {pArray[3]}="${pArray[2]}"
        {pArray[2]}="${{pArray[1]}%.*}$mode.${"{pArray[1]}"#*.}"
    fi
    #setting title
    echo -ne "\033]0;BUSY $promptInput mode:$mode ${pArray[2]}\007"
    ffmpeg -i "${pArray[1]}" -t "${pArray[3]}" -c copy -map 0 -avoid_negative_ts 1 "${pArray[2]}"
}

#${pArray[1]} inputFile ${pArray[2]} outputFile ${pArray[3]} startSecond ${pArray[4]} terminateSecond 
cutBoth() {
    local mode="CutBoth"
    local tempV="temp$mode.${{pArray[1]}#*.}"
    echo mode set to $mode
    if [ -z "${pArray[4]}" ]
    then
        {pArray[4]}="${pArray[3]}"
        {pArray[3]}="${pArray[2]}"
        {pArray[2]}=""${{pArray[1]}%.*}"$mode."${{pArray[1]}#*.}""
    fi
    #setting title
    echo -ne "\033]0;BUSY $promptInput mode:$mode ${pArray[2]}\007"
    ffmpeg -i "${pArray[1]}" -t "${pArray[4]}" -c copy -map 0 -avoid_negative_ts 1 $tempV 
    ffmpeg -i $tempV -ss ${pArray[3]} -c copy -map 0 -avoid_negative_ts 1 "${pArray[2]}"
    rm $tempV
}

#convert for wii, first wiimc, then photochannel if possible 
wii () {
    local WIDTH=800
    local HEIGHT=480
    local QUAL=3
    #new string
    local promptInput=""
    local mode="Wii"
    echo mode set to $mode

    if [ -z "${pArray[2]}" ]
    then
        {pArray[2]}="${{pArray[1]}%.*}$mode.avi"
    fi
    #setting title
    echo -ne "\033]0;BUSY $promptInput mode:$mode ${pArray[2]}\007"
    ffmpeg -i ${pArray[1]} ${pArray[3]} -vcodec mpeg4 -q $QUAL -preset medium -b:v 500k -vf scale=$WIDTH:-1 -threads 0 -acodec mp3 -strict experimental -b:a $ABR -ac 1 -ab 44100 ${pArray[2]}
}

#Removes segment from video and merges into out
#${pArray[1]}=INFILE ${pArray[2]}=OUTFILE ${pArray[3]}=START ${pArray[4]}=FINISH
remSeg() {
    local mode="remSeg"
    echo mode set to $mode
    #setting title
    echo -ne "\033]0;BUSY $promptInput mode:$mode ${pArray[2]}\007"
    #save the around into temps
    ffmpeg -i ${pArray[1]} -y -t ${pArray[3]} -avoid_negative_ts 1 -c copy -map 0 TEMP1.mp4
    ffmpeg -i ${pArray[1]} -y -ss ${pArray[4]} -avoid_negative_ts 1 -c copy -map 0 TEMP2.mp4
    echo "#2 files being merged to ${pArray[2]}"
    echo "file 'TEMP1.mp4'" > TEMP.txt
    echo "file 'TEMP2.mp4'" >> TEMP.txt
    #merge them back
    ffmpeg -y -f concat -i TEMP.txt -c copy ${pArray[2]} 
    rm TEMP.txt TEMP1.mp4 TEMP2.mp4
}

#ROTATE clockwise for the moment
rotate() {
    local promptInput=""
    local mode="ROTATE"
    echo mode set to $mode
    #setting title
    echo -ne "\033]0;BUSY $promptInput mode:$mode ${pArray[2]}\007"
    ANGLE="1"
    ffmpeg -i ${pArray[1]} -vcodec libx264 -preset slow -crf 0 -vf transpose=$ANGLE -acodec copy ${pArray[2]}
}

#tuna-viDS for nintendo ds homebrew avi video player
tunaviDS() {
    local WIDTH=256
    local HEIGHT=192
    local promptInput=""
    local mode="TUNAviDS"
    echo mode set to $mode
    if [ -z "${pArray[2]}" ]
    then
        echo NO PARRAy[2]
        {pArray[2]}="${{pArray[1]}%.*}$mode.avi"
    fi
    #setting title
    echo -ne "\033]0;BUSY $promptInput mode:$mode ${pArray[2]}\007"
    ffmpeg -i ${pArray[1]} ${pArray[3]} -f avi -r 10 -s 256x192 -b:v 192k -bt 64k -vcodec mpeg4 -deinterlace -acodec libmp3lame -ar 32000 -ab 96k -ac 2 ${pArray[2]}
}

#${pArray[1]} watermarkimage ${pArray[2]} inputvid ${pArray[3]} output vid
#bottom left corner
watermark() {
    local mode="Watermark"
    echo mode set to $mode
    #setting title
    echo -ne "\033]0;BUSY $promptInput mode:$mode ${pArray[3]}\007"
    ffmpeg -i ${pArray[2]} -vf "movie=${pArray[1]} [watermark]; [in][watermark] overlay=10:main_h-overlay_h-10 [out]" -acodec copy ${pArray[3]}
    
    #ffmpeg -i ${pArray[2]} -i ${pArray[1]}  -filter_complex \
    #"[1:v]scale=25:20[wat];[0:v][wat]overlay=10:main_h-overlay_h-10[outv]" \
    #-map "[outv]" -map 0:a -strict experimental ${pArray[3]}

    #ffmpeg -y -i ${pArray[2]} -i ${pArray[1]} -filter_complex 'overlay=0:0' -s 1280x720  -acodec copy -strict experimental ${pArray[3]}

    echo -ne "\033]0;DONE ${pArray[1]} last mode:$mode\007"
}

###AUDIO TOOLS

#adds cover art to {pArray[2]} directory with art file {pArray[1]}
tagDirectory() {
##HAS ONLY BEEN TESTED IN CURRENT DIRECTORY
    local mode="Tag Directory"
    echo mode set to $mode
    #setting title
    echo -ne "\033]0;BUSY $promptInput mode:$mode ${pArray[2]}\007" 
    for f in ${pArray[2]}/*.mp3
    do
        ffmpeg -i "$f" -i "${pArray[1]}" -map_metadata 0 -map 0 -map 1 out-"${f#./}" \
        && mv out-"${f#./}" "$f"
    done
}

###PLAYERS

play () {
    if [ -z "${pArray[1]}" ]
    then
        local promptInput=""
        read -p "type something to play:" promptInput
        {pArray[1]}="$promptInput"
    fi

    ffplay -framedrop -autoexit -fast -fs -window_title "ffeasy play ${pArray[1]}" "${pArray[1]}" $(for (( i = 2; i <= ${#}; i++ )); do echo ${pArray[${i}]}; done)
}

display_vars () {
    echo "0 $0, 1 $1, 2 $2, 3 $3, 4 $4, 5 $5"
    echo "pArray[0] ${pArray[0]}, pArray[1] ${pArray[1]}, pArray[2] ${pArray[2]}, pArray[3] ${pArray[3]}, pArray[4] ${pArray[4]}" 
    echo QUAL.... $QUAL
    echo WIDTH... $WIDTH
    echo HEIGHT.. $HEIGHT
    echo FPS..... $FPS
    echo ABR..... $ABR
}

#set title funtion
set_title () {
echo -ne "\033]0;$1\007"
}

printHelp() {
    echo "No parameters passed in
          Usage: ffeasy [-p] PLAY
             or: ffeasy [-a] ANDROIDCONVERT
                see man pages for more help" 
}

##############MAIN or DRIVER#################
clear
set_title ffeasy

#check if there is no parameter passed in

if [ ${#} -lt 1 ]
then
    printHelp
    prompt_input
fi

check_input ${pArray[0]}
#mode, input, output, additional options 
#android $2 $3 $4

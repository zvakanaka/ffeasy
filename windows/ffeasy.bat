@echo off
cls
setlocal
color B
REM set /A QUAL=2
REM set /A WIDTH=1280
REM set /A HEIGHT=720
REM set /A FPS=23
set /A QUAL=5
set /A WIDTH=960
set /A HEIGHT=640
set /A FPS=29
set /A ABITRATE=128000

TITLE FFeasy
echo .........................................
echo          FFeasy Media Tools
echo .........................................
echo Convert to almost ANY device: iPod
echo                               android
echo Tools: Convert Rotate MP3 DVD Resize etc.
echo .........................................
echo      '?' for full list of options
REM Created by Adam Quinton Feb 2014

REM passes 2 params
:pass1
if /I "%1"== "" goto :PROMPT
if /I "%2"== "" goto :pass2

if /I "%1"=="play" goto playPass

REM passes 1 param
:pass2
if /I "%1"=="android" goto android
if /I "%1"=="androidall" goto androidall
if /I "%1"=="charm" goto androidCharm
if /I "%1"=="charmall" goto androidCharmall
if /I "%1"=="create" goto autoCreator
if /I "%1"=="combine" goto combine
if /I "%1"=="combo" goto combo
if /I "%1"=="custom" goto custom 
if /I "%1"=="cut" goto cut
if /I "%1"=="display" goto Display
if /I "%1"=="dvd" goto DVD
if /I "%1"=="dvdall" goto DVDALL
if /I "%1"=="exit" goto final
if /I "%1"=="fast" goto Fast
if /I "%1"=="folder" goto Folder
if /I "%1"=="ipod" goto ipod
if /I "%1"=="ipodall" goto ipodALL
if /I "%1"=="auto" goto Folder
if /I "%1"=="mp3" goto mp3
if /I "%1"=="mp3all" goto mp3Folder
if /I "%1"=="play" goto PLAY
if /I "%1"=="playall" goto PLAYall
if /I "%1"=="quick" goto quick
if /I "%1"=="shift" goto shiftAudio  
if /I "%1"=="resize" goto resize
if /I "%1"=="resizeall" goto resizeFolder
if /I "%1"=="rotate" goto rotate
if /I "%1"=="update" goto update
if /I "%1"=="youtube" goto youtube
if /I "%1"=="help" goto helpDisplay 
if /I "%1"=="?" goto helpDisplay
goto lowlevelUser

:PROMPT
echo .......................................
SET /P INPUTEE=DRAGANDDROP Video and press ENTER:
echo .......................................
echo %INPUTEE% >> bin\log.txt

:promptSwitch
if /I "%INPUTEE%"=="android" goto android
if /I "%INPUTEE%"=="charm" goto androidCharm
if /I "%INPUTEE%"=="charmall" goto androidCharmAll
if /I "%INPUTEE%"=="androidall" goto androidall
if /I "%INPUTEE%"=="create" goto autoCreator
if /I "%INPUTEE%"=="combine" goto combine
if /I "%INPUTEE%"=="combo" goto combo
if /I "%INPUTEE%"=="custom" goto custom 
if /I "%INPUTEE%"=="cut" goto cut
if /I "%INPUTEE%"=="display" goto display
if /I "%INPUTEE%"=="dvd" goto DVD
if /I "%INPUTEE%"=="dvdall" goto DVDALL
if /I "%INPUTEE%"=="exit" goto final
if /I "%INPUTEE%"=="fast" goto Fast
if /I "%INPUTEE%"=="folder" goto Folder
if /I "%INPUTEE%"=="ipod" goto ipod
if /I "%INPUTEE%"=="ipodall" goto ipodall
if /I "%INPUTEE%"=="auto" goto Folder
if /I "%INPUTEE%"=="install" goto Install
if /I "%INPUTEE%"=="mp3" goto mp3
if /I "%INPUTEE%"=="mp3all" goto mp3Folder
if /I "%INPUTEE%"=="play" goto PLAY
if /I "%INPUTEE%"=="playall" goto PLAYALL
if /I "%INPUTEE%"=="quick" goto quick
if /I "%INPUTEE%"=="set" goto SetSize 
if /I "%INPUTEE%"=="shift" goto shiftAudio  
if /I "%INPUTEE%"=="resize" goto resize
if /I "%INPUTEE%"=="resizeall" goto resizefolder
if /I "%INPUTEE%"=="rotate" goto rotate
if /I "%INPUTEE%"=="update" goto UPDATE
if /I "%INPUTEE%"=="wii" goto wii
if /I "%INPUTEE%"=="youtube" goto youtube
if /I "%INPUTEE%"=="help" goto helpDisplay 
if /I "%INPUTEE%"=="?" goto helpDisplay
if /I "%INPUTEE%"=="varDisplay" goto varDisplay
goto lowlevelprompt

:helpDisplay
Echo OPTIONS: 
echo ............android   - converts to h.264
echo ............androidall- converts autoconvert folder to h.264
echo ............charm     -converts for motorola charm(android 2.1)
echo ............charmall  -autoconvert for motorola charm(android 2.1)
echo ............combine - Combines 2 files
echo ............combo   - Combines 3 files
echo ............create  - Creates auto script
echo ............custom  - Enter Custom command for ffmpeg
echo ............cut     - cuts the front or back of a media
echo ............dvd     - converts to DVD format
echo ............dvdall  - converts autoconvert to DVD format
echo ............ipod    - 640 video for iPod
echo ............ipodall - autoconvert folder for iPod
echo ............auto    - converts autoconvert folder to mp4
echo ............mp3     - converts to mp3
echo ............mp3all  - converts autoconvert folder to mp3
echo ............fast    - Quickly converts mpeg2
echo ............play    - Plays Media
echo ............playall - Plays everything in a folder
echo ............resize  - Resizes Pictures
echo ............resizeall  - Resizes Pictures in Autoconvert
echo ............rotate  - Rotate Video
echo ............set     - Customize Video Size and Quality
echo ............display - Displays Variables
echo ............shift   - Shifts Audio
echo ............wii     - just guess
echo ............youtube - download youtube video
echo ............
goto PROMPT

:varDisplay
echo VARIABLES:

:error
color C
echo ERROR
goto end

:lowlevelPrompt
SET /P OUTPUTEE=OUTPUT NAME of New Video(.avi will be added):
goto lowleveluser

:lowleveluser
title BUSY
bin\ffmpeg.exe -i %INPUTEE% -r %FPS% -q %QUAL% -s %WIDTH%x%HEIGHT% -acodec mp3 -b:a %ABITRATE% -vcodec libxvid %OUTPUTEE%.avi
title DONE
goto prompt

:lowlevelPass
title BUSY
bin\ffmpeg.exe -i %1% -r %FPS% -q 5 -s %WIDTH%x%HEIGHT% -acodec mp3 -vcodec libxvid %1Small.avi
title DONE
goto prompt


:androidCharm
if /I "%2"== "" goto :androidCharmPrompt
SET INPUT=%2
SET OUTPUT=%3
goto androidCharmCon

:androidCharmCon
TITLE BUSY
bin\ffmpeg -i %input% -vcodec libx264 -preset medium -vprofile baseline -s 320x240 -b:v 384k -acodec aac -ac 2 -ab 128k -ar 44100 -strict experimental %output%
TITLE DONE
goto prompt

:androidCharmALL
echo ANDROID AUTOFOLDER CHARM mode
SET /P OUTPUT=Output Folder:
mkdir %OUTPUT%
cd AUTOCONVERT
set /A NFILE=0
set /A CFILE=1
for %%a in ("*.*") do set /A NFILE+=1
for %%a in ("*.*") do (
   TITLE BUSY %CFILE%/%NFILE%
   ..\bin\ffmpeg -i "%%a" -vcodec libx264 -preset medium -vprofile baseline -s 320x240 -b:v 384k -acodec aac -ac 2 -ab 128k -ar 44100 -strict experimental "..\%OUTPUT%\%%~na.mp4"
   echo "%%a" >> ..\bin\log.txt
   set /A CFILE+=1
)
set /A CFILE-=1
TITLE DONE %CFILE%/%NFILE%
goto prompt

:androidCharmPrompt
SET /P Input=input file:
SET /P OUTPUT=Output:
goto androidCharmCon

:android
echo ANDROID h.264 mode
set /A QUAL=5
set /A WIDTH=800
set /A HEIGHT=480
set /A FPS=23
set /A ABITRATE=128000
SET /P INPUT=Input File:
SET /P OUTPUT=Output File:
title BUSY
bin\ffmpeg.exe -i %INPUT% -codec:v libx264 -profile:v high -preset slow -b:v 500k -maxrate 500k -bufsize 1000k -vf scale=-1:480 -threads 0 -c:a aac -strict experimental -b:a 128k %output%.mp4
REM bin\ffmpeg.exe -i %INPUT% -r %FPS% -q %QUAL% -s %WIDTH%x%HEIGHT% -acodec aac -b:a %ABITRATE% -vcodec libx264 %OUTPUT%.mp4
title DONE
goto prompt

:androidALL
echo ANDROID AUTOFOLDER h.264 mode
SET /P OUTPUT=Output Folder:
mkdir %OUTPUT%
cd AUTOCONVERT
set /A NFILE=0
set /A CFILE=1
for %%a in ("*.*") do set /A NFILE+=1
for %%a in ("*.*") do (
   TITLE BUSY %CFILE%/%NFILE%
   ..\bin\ffmpeg -i "%%a" -codec:v libx264 -profile:v high -preset slow -b:v 500k -maxrate 500k -bufsize 1000k -vf scale=-1:480 -threads 0 -c:a aac -strict experimental -b:a 128k "..\%OUTPUT%\%%~na.mp4"
   echo "%%a" >> ..\bin\log.txt
   set /A CFILE+=1
)
set /A CFILE-=1
TITLE DONE %CFILE%/%NFILE%
goto prompt

:autoCreator
echo .......................................
echo Create an auto script to convert 
echo multiple videos
echo .......................................
goto autoCreatorPrompt

:autoCreatorPrompt
SET /P INFILE=INPUT FILE:
goto autoSet

:autoSet
if /I "%INFILE%"=="?" goto autoElse
if /I "%INFILE%"=="done" goto autoElse
if /I "%INFILE%"=="exit" goto autoElse
if /I "%INFILE%"=="help" goto autoElse
if /I "%INFILE%"=="list" goto autoElse
if /I "%INFILE%"=="run" goto autoElse
if /I "%INFILE%"=="delete" goto autoElse
echo CALL ffeasy.bat %INFILE% >> AutoConvert.bat

:autoElse
if /I "%INFILE%"=="?" goto autoHelpDisplay
if /I "%INFILE%"=="done" goto prompt
if /I "%INFILE%"=="exit" goto prompt
if /I "%INFILE%"=="help" goto autoHelpDisplay
if /I "%INFILE%"=="list" Type AutoConvert.bat
if /I "%INFILE%"=="run" call AutoConvert.bat
if /I "%INFILE%"=="delete" erase AutoConvert.bat
goto autoCreatorPrompt

:autoHelpDisplay
Echo OPTIONS: 
echo ...............list - View AutoConvert.bat
echo ............delete  - Delete AutoConvert.bat
echo .........exit/done  - back to prompt
echo ...............run  - Call AutoConvert.bat
goto autoCreatorPrompt 

:combine
echo COMBINE 2 FILES
if /I "%2"== "" goto :combinePrompt
SET AFILE=%2
SET BFILE=%3
SET OUTPUT=%4
echo 2=%2 
echo 3=%3
echo 4=%4
echo a=%afile% b=%bfile% output=%output%
goto combineMath

:combineMath
TITLE BUSY
copy %AFILE% /b + %BFILE% /b %OUTPUT% /b
TITLE DONE
if /I "%2"NEQ "" goto :final
goto PROMPT

:combinePrompt
SET /P AFILE=FILE A:
SET /P BFILE=FILE B:
SET /P OUTPUT=Output:
goto combineMath

:combo
ECHO COMBINE 3 FILES
if /I "%2"== "" goto :comboPrompt
SET AFILE=%2
SET BFILE=%3
SET CFILE=%4
SET OUTPUT=%5
echo 2=%2 
echo 3=%3
echo 4=%4
echo 5=%5
echo a=%afile% b=%bfile% c=%cfile% output=%output%
goto comboMath

:comboMath
title BUSY
copy %AFILE% /b + %BFILE% /b + %CFILE% /b %OUTPUT% /b
title DONE
if /I "%2"NEQ "" goto :final
goto PROMPT

:comboPrompt
SET /P AFILE=FILE A:
SET /P BFILE=FILE B:
SET /P CFILE=FILE C:
SET /P OUTPUT=Output:
goto comboMath

:custom
echo you are in CUSTOM mode
SET /P CUST=ffmpeg.exe
bin\ffmpeg.exe %CUST%
goto prompt

:cut
SET /P INPUTEE=Cut off Front(A) or Back(B)?:
if /I "%INPUTEE%"=="a" goto cutfront
if /I "%INPUTEE%"=="b" goto cutback
if /I "%INPUTEE%"=="c" goto cutboth
goto error

:cutBack
SET /P SECONDS=Cut off at:(seconds)
SET /P INPUT=Input File:
SET /P OUTPUT=Output File:
title BUSY
bin\ffmpeg.exe -i %INPUT% -t %SECONDS% -acodec copy -vcodec copy %OUTPUT%
echo DONE
title DONE
goto prompt

:cutFront
SET /P SECONDS=New start time:(seconds)
SET /P INPUT=Input File:
SET /P OUTPUT=Output File:
title BUSY
bin\ffmpeg.exe -i %INPUT% -ss %SECONDS% -acodec copy -vcodec copy %OUTPUT%
echo DONE
title DONE
goto prompt

:cutBoth
SET /P startSECONDS=Cut front until:(seconds)
SET /P endSECONDS=Cut front until:(seconds)
SET /P INPUT=Input File:
SET /P OUTPUT=Output File:
title BUSY
bin\ffmpeg.exe -i %INPUT% -ss %StartSECONDS% -t %endSeconds% -acodec copy -vcodec copy %OUTPUT%
echo DONE
title DONE
goto prompt

:Display
Echo Parameters:
echo QUAL(Compression) %QUAL%
echo WIDTH %WIDTH%
echo HEIGHT %HEIGHT%
echo ABITRATE(Audio Bitrate) %ABITRATE%
echo FPS %FPS%
goto prompt

:Dvd
echo DVD mode
SET /P INPUT=Input File:
SET /P OUTPUT=Output File:
title BUSY
bin\ffmpeg.exe -i %INPUT% -f dvd -q %QUAL% -r %FPS% -s %WIDTH%x%HEIGHT% %OUTPUT%.mpg
echo DONE
title DONE
goto prompt

:DvdAll
echo DVD mode
SET /P OUTPUT=Output Folder:
mkdir %OUTPUT%
cd AUTOCONVERT
set /A NFILE=0
set /A CFILE=1
for %%a in ("*.*") do set /A NFILE+=1
for %%a in ("*.*") do (
   TITLE BUSY %CFILE%/%NFILE%
   ..\bin\ffmpeg -i "%%a" -f dvd -q %QUAL% -r %FPS% "..\%OUTPUT%\%%~na.mpg"
   echo "%%a" >> ..\bin\log.txt
   set /A CFILE+=1
)
set /A CFILE-=1
TITLE DONE %CFILE%/%NFILE%
echo DONE
title DONE
goto prompt

:iPod
if /I "%2"== "" goto :iPodHiPrompt
SET INPUT=%2
SET OUTPUT=%3
goto ipodHiCon

:ipodHiCon
TITLE BUSY
bin\ffmpeg -i %INPUT% -acodec aac -ac 2 -strict experimental -ab 160k -s %WIDTH%x%HEIGHT% -vcodec libx264 -preset slow -profile:v baseline -level 30 -maxrate 10000000 -bufsize 10000000 -b 1200k -f mp4 -threads 0 %OUTPUT%.mp4
TITLE DONE
goto prompt

:iPodlocon
TITLE BUSY 
bin\ffmpeg -i %INPUT% -s 640x480 -r 30000/1001 -b:v 700k -bt 240k -vcodec libx264 -coder 0 -bf 0 -refs 1 -flags2 -wpred-dct8x8 -level 30 -maxrate 10M -bufsize 10M -acodec aac -ac 2 -ar 48000 -ab 192k -strict experimental %OUTPUT%
TITLE DONE
goto prompt

:iPodHiPrompt
SET /P Input=input file:
SET /P OUTPUT=Output:
goto iPodHiCon


:ipodALL
echo iPod 640 autoconvert folder mode
SET /P OUTPUT=Output Folder:
mkdir %OUTPUT%
cd AUTOCONVERT
set /A NFILE=0
set /A CFILE=1
for %%a in ("*.*") do set /A NFILE+=1
for %%a in ("*.*") do (
   TITLE BUSY %CFILE%/%NFILE%
   ..\bin\ffmpeg -i "%%a" -acodec aac -ac 2 -strict experimental -ab 160k -s %WIDTH%x%HEIGHT% -vcodec libx264 -preset slow -profile:v baseline -level 30 -maxrate 10000000 -bufsize 10000000 -b 1200k -f mp4 -threads 0 "..\%OUTPUT%\%%~na.mp4"
   echo "%%a" >> ..\bin\log.txt
   set /A CFILE+=1
)
set /A CFILE-=1
TITLE DONE %CFILE%/%NFILE%
goto prompt

:Folder
REM SET /P INPUT=Input Folder:
SET /P OUTPUT=Output Folder:
mkdir %OUTPUT%
cd AUTOCONVERT
set /A NFILE=0
set /A CFILE=1
for %%a in ("*.*") do set /A NFILE+=1
for %%a in ("*.*") do (
   TITLE BUSY %CFILE%/%NFILE%
   ..\bin\ffmpeg -i "%%a" -r %FPS% -q %QUAL% -s %WIDTH%x%HEIGHT% -acodec mp3 -vcodec libxvid "..\%OUTPUT%\%%~na.avi"
   echo "%%a" >> ..\bin\log.txt
   set /A CFILE+=1
)
set /A CFILE-=1
TITLE DONE %CFILE%/%NFILE%
pause
goto final

:Mp3
SET /P INPUT=Input File:
SET /P OUTPUT=Output File:
title BUSY
bin\ffmpeg -i %INPUT% -acodec mp3 -b:a %ABITRATE% %OUTPUT%.mp3
TITLE DONE 
pause
goto final

:Mp3Folder
REM SET /P INPUT=Input Folder:
SET /P OUTPUT=Output Folder:
mkdir %OUTPUT%
cd AUTOCONVERT
set /A NFILE=0
set /A CFILE=1
for %%a in ("*.*") do set /A NFILE+=1
for %%a in ("*.*") do (
   TITLE BUSY %CFILE%/%NFILE%
   ..\bin\ffmpeg -i "%%a" -acodec mp3 -b:a %ABITRATE% "..\%OUTPUT%\%%~na.mp3"
   set /A CFILE+=1
)
set /A CFILE-=1
TITLE DONE %CFILE%/%NFILE%
pause
goto final


:play
SET /P INPUT=Input File:
bin\ffplay.exe -framedrop -autoexit %INPUT%
goto play

:playPass
bin\ffplay.exe -framedrop -autoexit %2%
goto end

:playall
cd autoconvert
for %%a in ("*.*") do ..\bin\ffplay -i "%%a"
cd ..
goto prompt

:resize
echo Resize a photo to VGA(640x480)
SET /P INPUT=Input File:
@echo on
if /I "%INPUT%"=="exit" goto prompt
bin\convert.exe -resize 640x480 %INPUT% %INPUT%SMALL.JPG
@echo off
goto resize

:resizeFolder
REM SET /P INPUT=Input Folder:
SET /P OUTPUT=Output Folder:
mkdir %OUTPUT%
cd AUTOCONVERT
set /A NFILE=0
set /A CFILE=1
for %%a in ("*.*") do set /A NFILE+=1
for %%a in ("*.*") do (
   TITLE BUSY %CFILE%/%NFILE%
   ..\bin\convert -resize 640x480 "%%a" "..\%OUTPUT%\%%~na.JPG"
   set /A CFILE+=1
)
set /A CFILE-=1
TITLE DONE %CFILE%/%NFILE%
pause
goto final

:rotate
echo Rotates Video

echo 0 = 90CounterCLockwise and Vertical Flip (default)
echo 1 = 90Clockwise
echo 2 = 90CounterClockwise
echo 3 = 90Clockwise and Vertical Flip
SET /P ANGLE=ROTATION OPTION:

SET /P INPUT=Input File:
SET /P OUTPUT=OUTPUT File:

bin\ffmpeg -i %INPUT% -vf "transpose=%ANGLE%" %OUTPUT%
goto prompt

:setSize
Echo Parameters:
set /P QUAL=Compression(HQ 1-30 badQ):
set /P WIDTH=Width:
set /P HEIGHT=Height:
set /P FPS=Frames Per Second:
set /P ABITRATE=Audio Bitrate(128000):
goto prompt

:shiftAudio
Echo If audio is before video type B
Echo If audio is after  video type A
SET /P INPUTEE=:
if /I "%INPUTEE%"=="a" goto AudioIsAfter
if /I "%INPUTEE%"=="b" goto AudioIsBefore
goto error

:AudioIsAfter
SET /P AMOUNT=How much after(00:00:03.0):
SET /P INPUTEE=DRAGANDDROP and PRESS ENTER:
SET /P OUTPUTEE=OUTPUT NAME of New Video:
title BUSY
bin\ffmpeg.exe -i %INPUTEE% -itsoffset %AMOUNT% -i %INPUTEE% -vcodec copy -acodec copy -map 1:0 -map 0:1 %OUTPUTEE%.avi
title DONE
goto end

:AudioIsBefore
SET /P AMOUNT=How much before(00:00:03.0):
SET /P INPUTEE=DRAGANDDROP and PRESS ENTER:
SET /P OUTPUTEE=OUTPUT NAME of New Video:
title BUSY
bin\ffmpeg.exe -i %INPUTEE% -itsoffset %AMOUNT% -i %INPUTEE% -vcodec copy -acodec copy -map 0:1 -map 1:0 %OUTPUTEE%.avi
title DONE
goto end

:quick
echo you are in %INPUTEE% mode
title BUSY
bin\ffmpeg.exe -i %INPUTEE% -s %WIDTH%x%HEIGHT% -acodec mp3 -vcodec libxvid %OUTPUTEE%.avi
title DONE
goto end

:INSTALL
SET /P dletter=DRIVE LETTER:
TITLE INSTALLING TO %DLETTER%:...
ECHO MAKING DIRECTORIES
MKDIR %DLETTER%:\PROGRAMS
MKDIR %DLETTER%:\PROGRAMS\FFeasy
MKDIR %DLETTER%:\PROGRAMS\FFeasy\AUTOCONVERT
MKDIR %DLETTER%:\PROGRAMS\FFeasy\BIN
ECHO COPYING PROGRAMS
copy ffeasy.bat %DLETTER%:\PROGRAMS\FFeasy\
copy bin\ffmpeg.exe %DLETTER%:\PROGRAMS\FFeasy\bin\
copy bin\ffplay.exe %DLETTER%:\PROGRAMS\FFeasy\bin\
copy bin\convert.exe %DLETTER%:\PROGRAMS\FFeasy\bin\
copy bin\vcomp100.dll %DLETTER%:\PROGRAMS\FFeasy\bin\
copy ..\..\FFeasy-shortcut.bat %DLETTER%:\
ECHO DONE
TITLE INSTALLED
GOTO prompt

:UPDATE
SET /P dletter=DRIVE LETTER:
ECHO CHECKING IF DIRECTORIES EXIST
MKDIR %DLETTER%:\PROGRAMS
MKDIR %DLETTER%:\PROGRAMS\FFeasy
MKDIR %DLETTER%:\PROGRAMS\FFeasy\AUTOCONVERT
ECHO COPYING PROGRAMS
@echo on
copy ffeasy.bat %DLETTER%:\PROGRAMS\FFeasy\
copy %DLETTER%:\PROGRAMS\FFeasy\bin\log.txt bin\log2.txt
@echo off
ECHO DONE
TITLE UPDATED %DLETTER%:
GOTO PROMPT

:wii
echo Wii mode
SET /P INPUT=Input File:
SET /P OUTPUT=Output File(.avi will be added):
title BUSY
bin\ffmpeg.exe -i %INPUT% -vcodec mjpeg -r %FPS% -qscale %QUAL% -s %WIDTH%x%HEIGHT% -acodec pcm_s16le -ac 2 -ar 44100 %OUTPUT%.avi
echo DONE
title DONE
goto prompt

:youtube
echo USING YOUTUBE-DL to download youtube
if /I "%2"== "" goto :youtubePrompt
SET AFILE=%2
echo 2=%2 
echo a=%afile%
goto combineMath

:youtubePrompt
SET /P AFILE=FILE A:
goto youtubedl

:youtubedl
TITLE BUSY
bin\youtube-dl %afile%
TITLE DONE
if /I "%2"NEQ "" goto :final
goto PROMPT

:END
echo PRESS ANY KEY TO QUIT
pause
color 0
endlocal

:final

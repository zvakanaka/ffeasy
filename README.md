AME
       ffeasy - easier ffmpeg media converting, playing, and editing

SYNOPSIS
       ffeasy [ OPTIONS ]

DESCRIPTION
       Ffeasy  is a shell script with easier options and commands than ffmpeg.
       It has a list of presets to choose from.  It is normally run by a user,
       but  can  run  from a script in order to perform a series of edits in a
       long movie, in order to remove unwanted scenes or words.

OPTIONS
       -p, --play
              Play media using ffplay.

       -a OR --android, -i OR --ipod, -s OR --simple, -t OR  --tuna(vids),  -W
       OR --wii
              Converters.

       --cutf(ront)
              Cut front of video using start second.

       --cutba(ck)
              Cut back of video using termnate second.

       --cutbo(th)
              Cut  both  front and back of video using start second and termnate second.

       -r, --rem(ove)
              Remove a segment out of the video.

       -R, --rotate
              Rotate media 90 degrees.

       -w, --water(mark)
              Overlay an image on the video.

       --tag  Tag a directory of songs with an image file(EXPERIMENTAL).

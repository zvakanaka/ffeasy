#!/bin/bash
#This is all you need to run to set up ffeasy

if [ ! -f ffall.sh ]
then
   echo "ffeasy files not found! Downloading from github.."
   wget https://raw.githubusercontent.com/zvakanaka/ffeasy/master/linux/ffall.sh
   wget https://raw.githubusercontent.com/zvakanaka/ffeasy/master/linux/ffeasy.1.gz
   wget https://raw.githubusercontent.com/zvakanaka/ffeasy/master/linux/ffeasy.desktop
   wget https://raw.githubusercontent.com/zvakanaka/ffeasy/master/linux/ffeasy.sh
   wget https://raw.githubusercontent.com/zvakanaka/ffeasy/master/linux/ffmpeg.xpm
fi
#marking runnable files executable
chmod +x ff*.*s*
#If ffmpeg not installed, install
dpkg -s ffmpeg >> ffeasy.log
if [ $? -eq 1 ]
then
   echo "Ffmpeg not found, Attempting to install ffmpeg"
   lsb_release -a | grep utopic >> /dev/null
   if [ $? = '1' ]
   then
      echo Older Ubuntu, asuming 14.04 
      sudo apt-add-repository ppa:jon-severinsson/ffmpeg
      sudo apt-get install ffmpeg
      sudo apt-get update
   else
      echo Ubuntu 14.10 Detected
      sudo apt-add-repository ppa:samrog131/ppa
      sudo apt-get update
      sudo apt-get install ffmpeg-real ffmpeg-set-alternatives
      sudo ln -sf /opt/ffmpeg/bin/ffmpeg /usr/bin/ffmpeg
   fi
fi

echo "additional script for converting, playing, or editing entire folders at once"
sudo cp -v ffall.sh /usr/bin/ffall
echo "main script"
sudo cp -v ffeasy.sh /usr/bin/ffeasy
echo "icon from https://plus.google.com/+ffmpeg/posts"
sudo cp -v ffmpeg.xpm /usr/share/pixmaps/
echo "Setting up mime-type"
echo "ffeasy will now show in the right click, open with menu"
sudo cp -v ffeasy.desktop /usr/share/applications/
echo "Seting up man page"
sudo cp -v ffeasy.1.gz /usr/share/man/man1/

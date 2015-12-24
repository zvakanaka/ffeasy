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
    #grep 'ubuntu' -i /proc/version
#   if [ $? -eq ]
   echo "Ffmpeg not found, Attempting to install ffmpeg"
   lsb_release -a | grep utopic >> /dev/null
   if [ $? = '1' ]
   then
       lsb_release -a | grep vivid >> /dev/null
       if [ $? = '1' ]
       then
	   echo Older Ubuntu, asuming 14.04 
	   sudo apt-add-repository ppa:jon-severinsson/ffmpeg	   
       else
	   echo Ubuntu 15.04, ffmpeg is back in the repos
       fi
       sudo apt-get update	 
       sudo apt-get install ffmpeg
   else
      echo Ubuntu 14.10 Detected
      sudo apt-add-repository ppa:kirillshkrogalev/ffmpeg-next
      sudo apt-get update
      sudo apt-get install ffmpeg
   fi
fi

echo "additional script for converting, playing, or editing entire folders at once"
sudo mv -v ffall.sh /usr/local/bin/ffall
echo "main script"
sudo mv -v ffeasy.sh /usr/local/bin/ffeasy
echo "icon from https://plus.google.com/+ffmpeg/posts"
sudo mv -v ffmpeg.xpm /usr/local/share/pixmaps/
echo "Setting up mime-type so ffeasy will show in the right click, open with menu"
sudo mv -v ffeasy.desktop /usr/local/share/applications/
echo "Seting up man page"
sudo mv -v ffeasy.1.gz /usr/local/share/man/man1/

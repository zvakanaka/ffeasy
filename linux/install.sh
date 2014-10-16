#This is all you need to run to set up ffeasy
#If ffmpeg not installed, install
dpkg -s ffmpeg >> ffeasy.log
if [ $? -eq 1 ]
     then
       sudo apt-add-repository ppa:jon-severinsson/ffmpeg
       sudo apt-get update
       sudo apt-get install ffmpeg
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

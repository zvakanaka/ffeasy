#This is all you need to run to set up ffeasy

echo "additional script for converting, playing, or editing entire folders at once"
sudo cp -v ffall.sh /usr/bin/ffall
echo "main script"
sudo cp -v ../ffeasy.sh /usr/bin/ffeasy
echo "icon from https://plus.google.com/+ffmpeg/posts"
sudo cp -v ffmpeg.xpm /usr/share/pixmaps/
echo "ffeasy will show in the right click, open with menu"
sudo cp -v ffeasy.desktop /usr/share/applications/
echo "Seting up man page"
sudo cp -v ffeasy.1.gz /usr/share/man/man1/
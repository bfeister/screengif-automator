if [ "$1" = "" ] ;
then
	echo "Please pass a QuickTime movie file."
else
	export fspec="$1"
	fname=`basename $fspec`
	fname="${fname%.*}"
	filedir=$(dirname "$1")
	/usr/local/bin/ffmpeg -i "$1" -pix_fmt rgb24 -r 10 -f gif - | /usr/local/bin/gifsicle --optimize=3 --delay=1 --resize-touch=800x800 > $filedir/$fname.gif
fi

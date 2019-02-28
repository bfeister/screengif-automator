### Create a `screengif` alias and automatically run it when *.mov files get added to $dir

1. Install ffmepg and gifsicle `brew install ffmpeg gifsicle`
1. Create the bash script that we'll execute: `vi /usr/local/bin/screengif.sh`
1. `i` (insert mode) > Paste contents of [screengif.sh](https://github.com/bfeister/screengif-automator/blob/master/screengif.sh) > `:wq!` (write, quit)
1. Give the script execute permissions: `chmod +x /usr/local/bin/screengif.sh`
1. Open `Automator` app in Mac OS
1. `File` > `New` > `Folder Action`
1. Top right > `Choose folder` > Select your watched directory
1. Top left search bar > `Run Shell Script` > Drag to right panel
1. Paste the following:
```
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
```

Based on: https://github.com/samjhill/screengif

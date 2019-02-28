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
for f in "$@"
do
    if [[ $f == *.mov ]]
	then
		/usr/local/bin/screengif.sh "$f"
	fi
done
```

Based on: https://github.com/samjhill/screengif

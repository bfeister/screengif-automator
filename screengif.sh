#!/bin/bash

PATH="$PATH:/usr/local/bin/:/opt/homebrew/bin/"

commandCheck() {
    cmd="$1"
    command -v "${cmd}" >/dev/null 2>&1 || { echo >&2 "I require ${cmd} but it's not installed. Aborting. brew install ${cmd}"; exit 1; }
}

commandCheck gifsicle
commandCheck ffmpeg

find "$@" -type f -name '*.mov' -print0 | while IFS= read -r -d '' f
do
    # base
    export fspec="$f"
    basefile="${fspec// /_}"
    basefile=$(basename "${basefile}")
    basefile="${basefile%.*}"

    # dirs
    filedir=$(dirname "${f}")
    tmpdir="/tmp"

    # output files
    palette="$tmpdir/$basefile-palette.png"
    tmpgif="$tmpdir/$basefile.gif"
    output="$filedir/$basefile.gif"

    if [[ -f "${output}" ]]; then
        echo "Skipping $f"
    else
        echo "Converting $f -> ${output}"

        # gif config
        maxsize=700
        filters="fps=8,scale=${maxsize}:-1:flags=lanczos"

        # create
        ffmpeg -v warning -i "$f" -vf "$filters,palettegen" -y "$palette"
        ffmpeg -v warning -i "$f" -i $palette -lavfi "$filters [x]; [x][1:v] paletteuse" -y "$tmpgif"
        gifsicle --optimize=3 --delay=1 --loopcount=forever --resize-touch="${maxsize}x${maxsize}" "$tmpgif" > "$output"

        # cleanup
        rm $palette
        rm $tmpgif
    fi
done

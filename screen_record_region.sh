#!/bin/sh

set -eu

align_4()
{
    read D
    expr $D - $D % 4
}

if [ $# -ne 1 ]; then
    echo "Usage: $0 <OUTPUT_VIDEO>"
    exit 1
fi

OUTPUT_VIDEO=$1

s=$(slop -f '%x %y %w %h')
X=$(echo $s | awk '{print $1}')
Y=$(echo $s | awk '{print $2}')
WIDTH=$(echo $s | awk '{print $3}' | align_4)
HEIGHT=$(echo $s | awk '{print $4}' | align_4)

ffmpeg -y -f x11grab -r 24 -s ${WIDTH}x${HEIGHT} -i :0.0+${X},${Y} -pix_fmt yuv420p -vcodec h264 -q 1 $OUTPUT_VIDEO

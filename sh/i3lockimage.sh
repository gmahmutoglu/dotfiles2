#!/bin/sh

imagedir="/home/amahmutoglu/Documents/images/lockimages/"
tempdir="/tmp"
#infilename=$(shuf -e -n 1 ${imagedir}/*)
infilename=$(find $imagedir -type f -exec shuf -e -n 1 {} +)
infilebasename=$(basename "$infilename")
infileextension=${filename##*.}
#outfilename="/tmp/${infilebasename%.*}.png"
outfilename="/tmp/__lockimage__"
screensizevec=($(xrandr | sed -n -e 's/^.\+connected.\+\([0-9]\{4\}x[0-9]\{4\}\).\+/\1/p'))

for iter in "${!screensizevec[@]}"; do
    convert -scale ${screensizevec[iter]}\> "$infilename" "${outfilename}${iter}.png"
    mogrify -gravity center -background black -extent ${screensizevec[iter]} "${outfilename}${iter}.png"
done
#nscreen=$(($iter+1))
nscreen=${#screensizevec[@]}
montage -mode concatenate -tile ${nscreen}x1 "${outfilename}?.png" "${outfilename}.png"
#gpicview ${outfilename}.png
i3lock -t -i "${outfilename}.png" && sleep 1
rm ${outfilename}*.png

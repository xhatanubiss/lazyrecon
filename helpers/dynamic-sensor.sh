#!/bin/bash

ITERATOR=0
echo "starting up..."
BAR='##############################'
FILL='------------------------------'
totalLines=$(wc -l ./live-targets-tmp.txt | awk '{print $1}')  # num. lines in file
barLen=30

# --- iterate over lines in csv file ---
count=0
while read line; do
    # update progress bar
    count=$(($count + 1))
    percent=$((($count * 100 / $totalLines * 100) / 100))
    i=$(($percent * $barLen / 100))
    echo -ne "\r[${BAR:0:$i}${FILL:$i:barLen}] $count/$totalLines ($percent%)"
    sleep 0.1
done < ./live-targets-tmp.txt

#!/bin/bash


extract_all.sh   | sed 's/^Jan/01/' | sed 's/^Feb/02/' | sed 's/^Mar/03/' | sed 's/^Apr/04/' | sed 's/^May/05/' | sed 's/^Jun/06/' | sed 's/^Jul/07/' | sed 's/^Aug/08/' | sed 's/^Sep/09/' | sed 's/^Oct/10/' | sed 's/^Nov/11/' | sed 's/^Dec/12/' > tmp/data.csv

Rscript analyse_data.R

cat tmp/usernames.txt | sed -n 's/^"\(\w\+\)",\([0-9]\+\)/\1\ (\2),\ /p' > out/usenames.txt

#!/bin/bash

# Get information about where we are located
DIR=$(echo "$0" | sed 's/^\(.*\/\)[^\/]\+$/\1/')

# Making sure the reps are there
if [ ! -e $DIR/tmp ]
then 
  mkdir $DIR/tmp
fi

if [ ! -e $DIR/out ]
then
  mkdir $DIR/out
fi

# extracting the data
echo "	  Extracting data from log"
$DIR/extract_all.sh   | sed 's/^Jan/01/' | sed 's/^Feb/02/' | sed 's/^Mar/03/' | sed 's/^Apr/04/' | sed 's/^May/05/' | sed 's/^Jun/06/' | sed 's/^Jul/07/' | sed 's/^Aug/08/' | sed 's/^Sep/09/' | sed 's/^Oct/10/' | sed 's/^Nov/11/' | sed 's/^Dec/12/' | sed 's/\ \+/,/g' > $DIR/tmp/data.csv

# Running the R script
echo "	  Analysing those data"
Rscript $DIR/analyse_data.R --args $DIR

# Adapting the CSV file
echo "	  Transfering the documents"
cat $DIR/tmp/usernames.txt | sed -n 's/^"\(\w\+\)",\([0-9]\+\)/\1\ (\2),\ /p' > $DIR/out/usernames.txt

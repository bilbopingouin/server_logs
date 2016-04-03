#!/bin/bash

# Get information about where we are located
DIR=$(echo "$0" | sed 's/^\(.*\/\)[^\/]\+$/\1/')

# Get the dirs set
if [ ! -e $DIR/tmp ]
then
  mkdir $DIR/tmp
fi
if [ ! -e $DIR/out ]
then
  mkdir $DIR/out
fi

# Extract info
cat /var/log/apache2/access.log | $DIR/unpack.pl > $DIR/tmp/data.csv

# Analyse them
Rscript $DIR/analyse_data.R --args $DIR

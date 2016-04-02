#!/bin/bash

# Get information about where we are located
DIR=$(echo "$0" | sed 's/^\(.*\/\)[^\/]\+$/\1/')

## Analyse /var/log/auth.log
echo "	A /var/log/auth.log"
$DIR/auth/analyse_auth.sh

## Import data
echo "	MV data to tex dir"
find $DIR/tex/imported/* -type f -delete
rsync -avr $DIR/auth/out/* $DIR/tex/imported/

## Compile the report
echo "	C LaTeX report"
cd $DIR/tex
pdflatex report.tex
pdflatex report.tex
cd -



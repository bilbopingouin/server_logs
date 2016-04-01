#!/bin/bash

## Analyse /var/log/auth.log
cd auth
./analyse_auth.sh
cd ..

## Import data
find tex/imported/* -type f -delete
rsync -avr auth/out/* tex/imported/

## Compile the report
cd tex
pdflatex report.tex
pdflatex report.tex
cd ..



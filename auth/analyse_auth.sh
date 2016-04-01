#!/bin/bash


extract_all.sh   | sed 's/^Jan/01/' | sed 's/^Feb/02/' | sed 's/^Mar/03/' | sed 's/^Apr/04/' | sed 's/^May/05/' | sed 's/^Jun/06/' | sed 's/^Jul/07/' | sed 's/^Aug/08/' | sed 's/^Sep/09/' | sed 's/^Oct/10/' | sed 's/^Nov/11/' | sed 's/^Dec/12/' > tmp/data.csv


#
#echo "#========================================" 
#echo "# $(date)" 
#
#echo "" 
#echo "# Total connection(s) attempts?" 
#cat $IN | grep -v '#' | awk '{print $7}' | sort | uniq -c | sort -nr 
#
#echo ""
#echo "# Type of connections" 
#cat $IN | grep -v '#' | awk '{print $6}' | sort | uniq -c | sort -nr 
#
#echo ""
#echo "# Successful"
#cat $IN | grep -v '#' | awk '{print $6, $7, $1, $2, $3, $4, $5}' | grep '^\ *7'


Rscript analyse_data.R

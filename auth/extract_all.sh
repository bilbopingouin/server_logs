#!/bin/bash

#echo "# $(date)"
#echo "-----------------------"  >> $OUTFILE
#date >> $OUTFILE
#echo "# var/log/auth.log covers from $(head -1 /var/log/auth.log | awk '{ print $1,$2,$3}') to $(tail -1 /var/log/auth.log | awk '{ print $1,$2,$3}')"
echo "mon,day,h,m,s,type,ip,var"


cat /var/log/auth.log | while read line
do
  #echo ">> $line"
  #echo "mon,day,h,m,s,type,ip,var"
  
  # 1. Invalid user
  echo "$line" | sed -n 's/^\(\w\+\ *[0-9]\{1,2\}\ *[0-9]\{2\}\):\([0-9]\+\):\([0-9]\+\).\+Invalid\ user\ \(.\+\)\ .\+\ \([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\).*/\1,\2,\3,1,\5,\4/p'

  # 2. Failed password
  echo "$line" | sed -n 's/^\(\w\+\ *[0-9]\{1,2\}\ *[0-9]\{2\}\):\([0-9]\+\):\([0-9]\+\).\+Failed\ password\ for\ \(.\+\)\ from\ \([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\).*/\1,\2,\3,2,\5,\4/p'

  # 3. Identification string
  echo "$line" | sed -n 's/^\(\w\+\ *[0-9]\{1,2\}\ *[0-9]\{2\}\):\([0-9]\+\):\([0-9]\+\).\+Did\ not\ receive\ identification\ string\ from\ \([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\).*/\1,\2,\3,3,\4,0/p'

  # 4. ROOT LOGIN
  echo "$line" | sed -n 's/^\(\w\+\ *[0-9]\{1,2\}\ *[0-9]\{2\}\):\([0-9]\+\):\([0-9]\+\).\+ROOT\ LOGIN\ REFUSED\ FROM\ \([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\).*/\1,\2,\3,4,\4,0/p'

  # 5. BREAK-IN
  echo "$line" | sed -n 's/^\(\w\+\ *[0-9]\{1,2\}\ *[0-9]\{2\}\):\([0-9]\+\):\([0-9]\+\).\+\[\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)\]\ \([a-z]\+\)\ .*BREAK-IN.*/\1,\2,\3,5,\4,0/p'

  # 6. Received disconnect
  echo "$line" | sed -n 's/^\(\w\+\ *[0-9]\{1,2\}\ *[0-9]\{2\}\):\([0-9]\+\):\([0-9]\+\).\+Received\ disconnect\ from\ *\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\).*/\1,\2,\3,6,\4,0/p'

  # 7. Accepted
  echo "$line" | sed -n 's/^\(\w\+\ *[0-9]\{1,2\}\ *[0-9]\{2\}\):\([0-9]\+\):\([0-9]\+\).\+Accepted\ .*\ \([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\).*/\1,\2,\3,7,\4,0/p'

  
done

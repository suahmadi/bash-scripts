#!/bin/bash

#DO NOT REMOVE THE FOLLOWING TWO LINES
git add $0 >> .local.git.out
git commit -a -m "Lab 2 commit" >> .local.git.out
git push >> .local.git.out || echo


#Your code here
FILENAME=$1
PASSWORD=$(head -n 1 $FILENAME)
SCORE=0

PWLEN=${#PASSWORD}

if [ $PWLEN -gt 32 ]
then
  echo "Error: Password length invalid."
  exit 1
elif [ $PWLEN -lt 6 ]
then
  echo "Error: Password length invalid."
  exit 1
fi

if egrep -q [0-9] <<< "$PASSWORD"
then
  let SCORE=SCORE+5
fi


if egrep -q [#$+%@] <<< "$PASSWORD"
then
  let SCORE=SCORE+5
fi

if egrep -q [A-Za-z] <<< "$PASSWORD"
then
  let SCORE=SCORE+5
fi

if egrep -q -E '(.)\1+' <<< "$PASSWORD"
then
  let SCORE=SCORE-10
fi

if egrep -q [a-z]{3} <<< "$PASSWORD"
then
  let SCORE=SCORE-3
fi

if egrep -q [A-Z]{3} <<< "$PASSWORD"
then
  let SCORE=SCORE-3
fi


if egrep -q [0-9]{3} <<< "$PASSWORD"
then
  let SCORE=SCORE-3
fi


let SCORE=SCORE+PWLEN
echo "Password Score: $SCORE"







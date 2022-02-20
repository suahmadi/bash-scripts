#!/bin/bash

#assumes passwords.txt and expected.txt are in the current dir
#format of passwords.txt: list of passwords seperated by '\n'
#format of expected.txt: expected score for each password in passwords.txt
#                        ';'
#                        test-case-points

#set colors
RED="\033[1;31m"
GREEN="\033[1;32m"
NOCOLOR="\033[0m"

#define password_file path
password_file=passwords.txt
#define expected_file path
expected_file=expected.txt

#get_gold_score i_th_password
function get_gold_score {
    i=$1
    file=$expected_file
    echo $(sed "${i}q;d" $file | awk -F';' '{print $1}')
}

#get_test_case_points i_th_password
function get_test_case_points {
    i=$1
    file=$expected_file
    echo $(sed "${i}q;d" $file | awk -F';' '{print $2}')
}

#keep track of student's total score
total_points=0

#counter for tracking line of gold_scores and test-case-part
i=1
j=0
for password in $(cat $password_file); do
    if [ $(( i % 2 )) -eq 0 ]; then
        part=1
    else
        part=0
        (( j += 1 ))
    fi

    echo $password > out_file.txt

    my_score=$(./pwcheck.sh out_file.txt)
    gold_score=$(get_gold_score $i)

    test_points=$(get_test_case_points $i)

    if [ "$my_score" ==  "$gold_score" ]; then
        echo -e "${GREEN}${j}.${part}\tpassed\tpoints:\t${test_points}${NOCOLOR}"
        (( total_points += $test_points ))
    else
        echo -e "${RED}${j}.${part}\tfailed\tpoints:\t0${NOCOLOR}"
    fi
    (( i += 1 ))    
done
echo -e "Total points:\t\t${total_points}"

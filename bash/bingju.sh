#!/bin/bash

FILES=$(ls ../txt/nofb/*.txt)
CSV="../data/bingju.csv"

echo "answer;question" > $CSV

for FILE in $FILES
do
	for ((i=51;i<=60;i++))
	do
		#START=$(cat "$FILE" | sed 's/\f//g' | egrep -n "$i．A " | cut -d':' -f1)
		#j=$((i + 1))
		#echo " j = $j"
		#END=$(cat "$FILE" | sed 's/\f//g' | tail -n $(($START+1)) | egrep -n "([0-9][0-9]．)|(.*H6.*)" | head -1 | cut -d':' -f1)
		#echo "start-end: $START-$END"
		##Q=$(cat "$FILE" | sed 's/\f//g' | grep -A 8 "$i．A ")
		#if [[ "$END" == "" ]]
		#then
	#		END=8
#		fi
		#Q=$(cat "$FILE" | sed 's/\f//g' | tail -n +$START | head -n $END)
		#echo "    Q:$Q"
		#Q1=$(echo "$Q" | tr -d '\n' | sed 's/.*A \(.*\)B .*/\1/')
		#Q2=$(echo "$Q" | tr -d '\n' | sed 's/.*B \(.*\)C .*/\1/')
		#Q3=$(echo "$Q" | tr -d '\n' | sed 's/.*C \(.*\)D .*/\1/')
		#Q4=$(echo "$Q" | tr '\n' '@' | grep '.*D ' | sed 's/.*D \(.*[。？！]\)[0123456789H@].*/\1/' | tr -d 'D @')

		START=$(cat "$FILE" | sed 's/\f//g' | egrep -n "$i．A " | cut -d':' -f1)
		j=$((i + 1))
		echo " j = $j"
		END=$(cat "$FILE" | sed 's/\f//g' | tail -n +$(($START+1)) | egrep -n -m1 "([0-9][0-9]．)|(H)|(^$)" | head -1 | cut -d':' -f1)
		#Q=$(cat "$FILE" | sed 's/\f//g' | grep -A 8 "$i．A ")
		if [[ "$END" == "" ]]
		then
			END=9
		fi
		Q=$(cat "$FILE" | sed 's/\f//g' | tail -n +$START | head -n $END)
		Q1=$(echo "$Q" | tr -d '\n' | sed 's/.*A \(.*\)B .*/\1/')
		Q2=$(echo "$Q" | tr -d '\n' | sed 's/.*B \(.*\)C .*/\1/')
		Q3=$(echo "$Q" | tr -d '\n' | sed 's/.*C \(.*\)D .*/\1/')
		#Q4=$(echo "$Q" | grep -A 2 '.*D ' | tr '\n' '@' | sed 's/.*D \(.*[。？！]\)[0123456789H@].*/\1/' | tr -d 'D @')
		Q4=$(echo "$Q" | tr -d '\n' | egrep -o 'D [^。]*。([^。H第]*。)?' | tr -d 'D ')
		R=$(cat "$FILE" | grep "$i．[ABCD]$")
		ANSWER=$(echo "$R" | tr '．' ':' | cut -d':' -f4)
		A1="o";	A2="o"; A3="o";	A4="o"
		if [[ $ANSWER == "A" ]]
		then
			A1="x"
		elif [[ $ANSWER == "B" ]]
		then
			A2="x"
		elif [[ $ANSWER == "C" ]]
		then
			A3="x"
		elif [[ $ANSWER == "D" ]]
		then
			A4="x"
		fi
		echo "$A1;$Q1" >> $CSV
		echo "$A2;$Q2" >> $CSV
		echo "$A3;$Q3" >> $CSV
		echo "$A4;$Q4" >> $CSV
	done
done

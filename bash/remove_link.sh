#!/bin/bash

for FILE in $(ls ../txt/*.txt)
do
	sed '/Facebook/d' $FILE > ../txt/nofb/$FILE
done

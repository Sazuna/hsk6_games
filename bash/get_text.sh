#!/bin/bash


# Remove spaces from file names

# mv "$FILE" "${FILE// /_}"
# done

FILE_N=0
for FILE in ../pdf/*.pdf;
do
	pdftotext $FILE "../txt/600$FILE_N.txt"
	FILE_N=$(expr $FILE_N + 1)
done

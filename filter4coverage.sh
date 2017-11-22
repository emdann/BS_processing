#!/bin/bash

if [ $# -ne 2 ]
then
    echo "Please, give:"
    echo "1) lower coverage limit"
    echo "2) higher coverage limit"
    exit
fi

lower=$1
higher=$2

for i in $( ls cov2c*.cov.gz )
	do
	zcat $i | awk -v bottom=$lower -v top=$higher -v input=$i '
		BEGIN {
			COUNT=0;
			} 
		{
			if ($4+$5>bottom && $4+$5 < top) 
				{print;} 
			else 
				{COUNT+=1;
				 print $1"\t"$2"\t"$3"\t"0"\t"0"\t"$6"\t"$7}
		}
		END {
	print input"\t# filtered sites = "COUNT}
	'| gzip > filtered_$i
	zcat filtered_$i | tail -1 >> filtered4coverage.log
	zcat filtered_$i | head -n -1 | gzip > temp_$i
	mv temp_$i filtered_$i
done



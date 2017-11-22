#!/bin/bash

if [[ $# != 1 ]]; then
  echo "Usage:submit-fastqc.sh <input dir>"
  exit
fi

input_dir=$1

for i in $(ls $input_dir  );
	do 
	echo "/hpc/hub_oudenaarden/edann/bin/FastQC/fastqc -2 $i" | qsub -cwd -N fastqc_$i
 done


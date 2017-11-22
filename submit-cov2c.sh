#!/bin/bash

email=emmamarydann@gmail.com
Dt=15:00:00
Dmem=50G
threads=1

if [ $# -ne 1 ]
then
    echo "Please, give these following inputs:"
    echo "genome (mouse/zebrafish/path)"
    exit
fi



for i in $(ls *bismark.cov.gz );
        do
	input=$i
#	echo $input
	echo "/hpc/hub_oudenaarden/edann/bin/BS_processing/cov2C.sh $input $1" | qsub -cwd -N ${input} -o c2c-${input}.out -e c2c-${input}.err -m eas -M ${email} -pe threaded ${threads} -l h_rt=${Dt} -l h_vmem=${Dmem}
done

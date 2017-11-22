#!/bin/bash

email=emmamarydann@gmail.com
Dt=24:00:00
Dmem=10G
threads=8

if [ $# -ne 2 ]
then
    echo "Please, give:"
    echo "1) reference genome (path, mouse, human, zebrafishGFP)"
    echo "2) directory for fastq files"
    exit
fi

cd $2

for i in $( ls *trim1* )
	do
	echo $i

	echo "/hpc/hub_oudenaarden/edann/bin/BS_processing/map-se.sh $1 $i" | qsub -cwd -N ${i} -o mapse-${i}.out -e mapse-${i}.err -m eas -pe threaded ${threads} -l h_rt=${Dt} -l h_vmem=${Dmem}
done



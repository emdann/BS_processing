#!/bin/bash

email=emmamarydann@gmail.com
Dt=24:00:00
Dmem=100G
threads=4

if [ $# -ne 2 ]
then
    echo "Please, give:"
    echo "1) reference genome (path, mouse, human, zebrafishGFP)"
    echo "2) root of fastq files"
    exit
fi

input=$2

echo "/hpc/hub_oudenaarden/edann/bin/BS_processing/map-pe.sh $1 $2" | qsub -cwd -N ${input} -o mappe-${input}.out -e mappe-${input}.err -m eas -M ${email} -pe threaded ${threads} -l h_rt=${Dt} -l h_vmem=${Dmem}

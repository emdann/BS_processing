#!/bin/bash

email=emmamarydann@gmail.com
Dt=15:00:00
Dmem=50G
threads=1

if [ $# -ne 2 ]
then
    echo "Please, give these following inputs:"
    echo "1) PE/SE method"
    echo "2) bam file"
    exit
fi

input=${2%.bam}

echo "/hpc/hub_oudenaarden/edann/bin/BS_processing/deduplicate.sh $1 $2" | qsub -cwd -N ${input} -o dedup-${input}.out -e dedup-${input}.err -m eas -M ${email} -pe threaded ${threads} -l h_rt=${Dt} -l h_vmem=${Dmem}

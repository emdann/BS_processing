#!/bin/bash

email=emmamarydann@gmail.com
Dt=15:00:00
Dmem=50G
threads=1

if [ $# -ne 1 ]
then
    echo "Please, give these following inputs:"
    echo "2) bam file"
    exit
fi

input=${1%.bam}

echo "/hpc/hub_oudenaarden/aalemany/bin/bisulfite/extractMet-pe.sh $1" | qsub -cwd -N ${input} -o extr-${input}.out -e extr-${input}.err -m eas -M ${email} -pe threaded ${threads} -l h_rt=${Dt} -l h_vmem=${Dmem}

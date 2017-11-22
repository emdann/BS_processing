#!/bin/bash

if [ $# -ne 2 ]
then
    echo "Please, give 3 input:"
    echo "1) input cov.gz file"
    echo "2) genome: mouse, zebrafish or path"
    exit
fi

path2bismark=/hpc/hub_oudenaarden/bin/software/bismark_v0.16.3

inputfile=$1
genome=$2
if [ $genome = "mouse" ]
then
    genome=/hpc/hub_oudenaarden/avo/BS/mm10
elif [ $genome = "zebrafish" ]
then
    genome=/hpc/hub_oudenaarden/avo/BS/danRer10
elif [ $genome = 'human' ]
then
	genome=/hpc/hub_oudenaarden/avo/BS/hg19
fi

${path2bismark}/coverage2cytosine --gzip --genome_folder ${genome} -o cov2c_${inputfile} ${inputfile}

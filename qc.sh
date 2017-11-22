#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Please, give root to _R1.fastq, _R2.fastq files"
    exit
fi

input=$1
path2fastqc=/hpc/hub_oudenaarden/edann/bin/FastQC

${path2fastqc}/fastqc ${input}_R1.fastq.gz
${path2fastqc}/fastqc ${input}_R2.fastq.gz

rm ${input}_R1_fastqc.zip
rm ${input}_R2_fastqc.zip
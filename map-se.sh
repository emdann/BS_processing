#! /bin/bash

if [ $# -ne 2 ]
then
    echo "Please, give:"
    echo "1) reference genome (path or mouse/zebrafish/zebrafishGFP/human)"
    echo "2) full name for fastq file"
    exit
fi

refGen=$1
input=$2

if [ $refGen = 'mouse' ]
then
    refGen=/hpc/hub_oudenaarden/avo/BS/mm10/
elif [ $refGen = 'zebrafish' ]
then
    refGen=/hpc/hub_oudenaarden/avo/BS/danRer10/
elif [ $refGen = 'human' ]
then
    refGen=/hpc/hub_oudenaarden/cgeisenberger/genomes/hg38/
elif [ $refGen = 'zebrafishGFP' ]
then
    refGen=/hpc/hub_oudenaarden/aalemany/refSeq/BS-zf-lintrace_GFP
fi

path2bismark=/hpc/hub_oudenaarden/bin/software/bismark_v0.16.3
path2samtools=/hpc/hub_oudenaarden/bdebarbanson/bin/samtools-1.3.1
path2bowtie=/hpc/hub_oudenaarden/bin/software/bowtie2-2.2.9

${path2bismark}/bismark --samtools_path ${path2samtools} --path_to_bowtie ${path2bowtie} ${refGen} ${input}



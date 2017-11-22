#! /bin/bash

if [ $# -ne 2 ]
then
    echo "Please, give:"
    echo "1) PE/SE (pair end or single end mode)"
    echo "2) bam file"
    exit
fi

mode=$1
input=$2

path2bismark=/hpc/hub_oudenaarden/bin/software/bismark_v0.16.3
path2samtools=/hpc/hub_oudenaarden/bdebarbanson/bin/samtools-1.3.1

if [ $mode = 'PE' ]
then
    ${path2bismark}/deduplicate_bismark --samtools_path ${path2samtools} -p --bam ${input}
elif [ $mode = 'SE' ]
then
    ${path2bismark}/deduplicate_bismark --samtools_path ${path2samtools} -s --bam ${input}
fi

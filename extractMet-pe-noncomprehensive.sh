#! /bin/bash

if [ $# -ne 1 ]
then
    echo "Please, give:"
    echo "2) bam file"
    exit
fi

input=$1

path2bismark=/hpc/hub_oudenaarden/bin/software/bismark_v0.16.3
path2samtools=/hpc/hub_oudenaarden/bdebarbanson/bin/samtools-1.3.1

#${path2bismark}/bismark_methylation_extractor --bedGraph --gzip --samtools_path ${path2samtools} --comprehensive --report ${input}

/hpc/hub_oudenaarden/bin/software/bismark_v0.16.3/bismark_methylation_extractor --bedGraph -gzip --samtools_path /hpc/hub_oudenaarden/bdebarbanson/bin/samtools-1.3.1 -s --no_overlap --report ${input}


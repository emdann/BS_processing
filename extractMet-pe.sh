#! /bin/bash

if [ $# -ne 2 ]
then
    echo "Please, give:"
    echo "1) bam file"
    echo "2) genome"
    exit
fi

input=$1
path2bismark=/hpc/hub_oudenaarden/bin/software/bismark_v0.16.3
path2samtools=/hpc/hub_oudenaarden/bdebarbanson/bin/samtools-1.3.1
genome=$2
if [ $genome = "mouse" ]
then
    genome=/hpc/hub_oudenaarden/avo/BS/mm10
fi

#${path2bismark}/bismark_methylation_extractor --bedGraph --gzip --samtools_path ${path2samtools} --comprehensive --report ${input}

/hpc/hub_oudenaarden/bin/software/bismark_v0.16.3/bismark_methylation_extractor -gzip --samtools_path /hpc/hub_oudenaarden/bdebarbanson/bin/samtools-1.3.1 -s --report --comprehensive --merge_non_CpG --bedGraph --cytosine_report --genome_folder ${genome} ${input}

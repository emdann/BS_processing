#! /bin/bash

if [ $# -ne 1 ]
then
    echo "Please, give:"
    echo "2) sample id"
    exit
fi

input=$1

path2bismark=/hpc/hub_oudenaarden/bin/software/bismark_v0.16.3
path2samtools=/hpc/hub_oudenaarden/bdebarbanson/bin/samtools-1.3.1

#${path2bismark}/bismark_methylation_extractor --bedGraph --gzip --samtools_path ${path2samtools} --comprehensive --report ${input}

/hpc/hub_oudenaarden/bin/software/bismark_v0.16.3/bismark_methylation_extractor --bedGraph -gzip --samtools_path /hpc/hub_oudenaarden/bdebarbanson/bin/samtools-1.3.1 --comprehensive -p --no_overlap --report ${input}_trim1_R1_bismark_bt2_pe.deduplicated.bam
#/hpc/hub_oudenaarden/bin/software/bismark_v0.16.3/bismark_methylation_extractor --bedGraph -gzip --samtools_path /hpc/hub_oudenaarden/bdebarbanson/bin/samtools-1.3.1 --comprehensive -s --report ${input}_trim1_R1.fastq.gz_unmapped_reads_1_bismark_bt2.deduplicated.bam
#/hpc/hub_oudenaarden/bin/software/bismark_v0.16.3/bismark_methylation_extractor --bedGraph -gzip --samtools_path /hpc/hub_oudenaarden/bdebarbanson/bin/samtools-1.3.1 --comprehensive -s --report ${input}_trim1_R2.fastq.gz_unmapped_reads_2_bismark_bt2.deduplicated.bam

zcat A1_lmerged_trim1_R2.fastq.gz_unmapped_reads_2_bismark_bt2.deduplicated.bismark.cov.gz A1_lmerged_trim1_R1.fastq.gz_unmapped_reads_1_bismark_bt2.deduplicated.bismark.cov.gz A1_lmerged_trim1_R1_bismark_bt2_pe.deduplicated.bismark.cov.gz | sort -k1,1 -k2,2n| bedtools groupby -i stdin -g 1,2,3 -c 5,6 -o sum > A1_lmerged_merged.cov 



#! /usr/bin/env bash


# check and parse command line arguments
if [[ $# != 1 ]]; then
  echo "Usage: merge_lanes.sh <input dir>"
  exit
fi

# cd to input directory
d=$1
cd $1

# retrieve sample names (SampleName_SEQIDXXX_Lxxx_Rx_001.fastq.gz)
s=$(ls | grep "fastq.gz$" | grep -oE "^[^_]+" | sort | uniq)

# loop over sample names

for i in $s
do
    f1=$(ls | grep "fastq.gz$" | grep "$i" | grep "_R1_" | tr "\n" " ")
    echo "zcat $f1 | gzip > ${i}_lmerged_R1.fastq.gz; rm $f1" | qsub -cwd -N $i
    f2=$(ls | grep "fastq.gz$" | grep "$i" | grep "_R2_" | tr "\n" " ")
    echo "zcat $f2 | gzip > ${i}_lmerged_R2.fastq.gz; rm $f2" | qsub -cwd -N $i
done


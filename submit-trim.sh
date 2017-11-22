#!/bin/bash
email=emmamarydann@gmail.com
Dt=15:00:00
Dmem=10G
threads=2

if [ $# !=  1 ]
then
   echo "Please, give these following inputs:"
   echo "1) directory containing fastq.gz files to be trimmed"
   exit
fi


input_dir=$1

cd $input_dir

for i in $(ls *fastq.gz | sed 's/lmerged_/lmerged\t/' | cut -f 1);
        do
	#echo $i
	echo "/hpc/hub_oudenaarden/edann/bin/BS_processing/trim_from_base_content.sh $i" | qsub -cwd -N ${i} -o trim-${i}.out -e trim-${i}.err -m eas -pe threaded ${threads} -l h_rt=${Dt} -l h_vmem=${Dmem}
 done


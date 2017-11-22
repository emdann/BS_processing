#!/bin/bash 
#module load R
source /hpc/hub_oudenaarden/edann/venv2/bin/activate

input=$1 # provide as input name of sample
path2trimgalore=/hpc/hub_oudenaarden/edann/bin/TrimGalore-0.4.3
path2cutadapt=/hpc/hub_oudenaarden/edann/venv2/bin

#unzip ${input}_R1_fastqc.zip
#unzip ${input}_R2_fastqc.zip

# Setting clip for R1
#awk '/Per base sequence content/,/Per sequence GC content/' ${input}_R1_fastqc/fastqc_data.txt | head -n-2 > ${input}_R1_base_content.txt
#cat ${input}_R1_base_content.txt | Rscript /hpc/hub_oudenaarden/edann/bin/BS_processing/set_trimming_base.r > ${input}_R1_number.txt
#rm ${input}_R1_base_content.txt
#cat number.txt
#file="./${input}_R1_number.txt" 
#clipR1=$(cat "$file" | tr ' ' '\t' | cut -f 2)  

#rm ${input}_R1_number.txt

# Setting clip for R2
#awk '/Per base sequence content/,/Per sequence GC content/' ${input}_R2_fastqc/fastqc_data.txt | head -n-2 > ${input}_R2_base_content.txt
#cat ${input}_R2_base_content.txt | Rscript /hpc/hub_oudenaarden/edann/bin/BS_processing/set_trimming_base.r  > ${input}_R2_number.txt
#rm ${input}_R2_base_content.txt
#cat number.txt
#file="./${input}_R2_number.txt" 
#clipR2=$(cat "$file" | tr ' ' '\t' | cut -f 2)  

#rm ${input}_R2_number.txt
#rm -r ${input}_R1_fastqc
#rm -r ${input}_R2_fastqc

#echo $clipR1
#echo $clipR2

# Trimming accordingly
${path2trimgalore}/trim_galore --clip_R1 10 --clip_R2 10 --three_prime_clip_R1 3 --three_prime_clip_R2 3 --paired ${input}_R1.fastq.gz ${input}_R2.fastq.gz 

mkdir trim_logs
mv ${input}_R1_val_1.fq.gz ${input}_trim1_R1.fastq.gz
mv ${input}_R2_val_2.fq.gz ${input}_trim1_R2.fastq.gz
mv ${input}_R1.fastq.gz_trimming_report.txt trim_logs/${input}_R1_trim1.log
mv ${input}_R2.fastq.gz_trimming_report.txt trim_logs/${input}_R2_trim1.log

/hpc/hub_oudenaarden/edann/bin/FastQC/fastqc ${input}_trim1_R1.fastq.gz
/hpc/hub_oudenaarden/edann/bin/FastQC/fastqc ${input}_trim1_R2.fastq.gz

rm ${input}_trim1_R1_fastqc.zip
rm ${input}_trim1_R2_fastqc.zip

#mkdir trim_logs
#mv ${input}_R1.fastq.gz_trimming_report.txt trim_logs/${input}_R1_trim1.log

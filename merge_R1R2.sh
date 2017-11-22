#!/bin/bash
#module load R

path2samtools=/hpc/hub_oudenaarden/bdebarbanson/bin/samtools-1.4.1/bin
path2bedtools=/hpc/hub_oudenaarden/edann/bin/bedtools2/bin
#path2R=/hpc/hub_oudenaarden/abarve/sw/R-3.4.0/bin

smp=$1

# Make merged bam from the two reads
#${path2samtools}/samtools merge merged_${smp}.bam ${smp}_trim1_R1_bismark_bt2.deduplicated.bam ${smp}_trim1_R2_bismark_bt2.deduplicated.bam
# Sort bam by name and convert to bed for overlap clipping
#${path2samtools}/samtools sort -n  merged_${smp}.bam | ${path2samtools}/samtools view -o sorted_merged_${smp}.bam
#${path2bedtools}/bamToBed -i sorted_merged_${smp}.bam > sorted_merged_${smp}.bed
# Make clipped bed file
#Rscript -e "source('/hpc/hub_oudenaarden/edann/bin/BS_processing/clipOverlap_R1R2.r'); makeClippedBed('$(pwd)/sorted_merged_${smp}.bed')" > sorted_merged_${smp}.clip.bed 

# The definitive version: make bed file of overlaps between R1 and R2 and remove one from the count in the cov file
cat ${smp}.bed | sed 's/_2/_1/' | awk 'NF>1{a[$4] = a[$4]"\t"$N};END{for(i in a)print a[i]}' | awk '$9
' | sed 's/[+-]\tchr/\nchr/' | sed 's/^\t//' | cut -f 5,6 --complement > ${smp}_couples.bed
cat ${smp}_couples.bed | sed 's/_2/_1/' | ${path2bedtools}/bedtools groupby -g 4 -c 1,2,3 -o distinct,max,min -full -delim '\t' | awk '{if(length($5)<=5){print}}' | awk '$6<$7' | cut -f 5,6,7 > ${smp}_R1R2_overlaps.bed

#zcat A1*cov.gz | bedtools intersect -wao -a stdin -b test_R1R2_overlaps.bed | awk '{if($7!="."){print}}' # ... to be continued 




# NOPE
#samtools view -h sorted_merged_A2_lmerged.bam -o sorted_merged_A2_lmerged.sam
#| tr '_' '\t' | awk 'NF>1{a[$1] = a[$1]"\t"$N};END{for(i in a)print i""a[i]}' | cut -f 2,19 --complement | awk '
#	$18{
#	min=$5; min_s=$11; min_s_i=11; max=$21; max_s=$27
#	if($5>$21){min=$21;min_s=$27; min_s_i=27; max=$5; max_s=$11} 
#	if(min+length(min_s)>max && min+length(min_s)<max+length(max_s) && $4==$20 ){
#		$min_s_i=substr(min_s,0,max-min);$(min_s_i+1)=substr($(min_s_i+1),0,max-min);$(min_s_i+4)=substr($(min_s_i+4),0,max-min+5) 
#		printf $1; for(i=2;i<=17;++i) printf "\t"$i"\t"; printf "\n"; printf $1; for(i=18;i<=NF;++i)printf "\t"$i"\t"; printf "\n"
#		} 
#	else {printf $1; for(i=2;i<=17;++i) printf "\t"$i"\t"; printf "\n"; printf $1; for(i=18;i<=NF;++i)printf "\t"$i"\t"; printf "\n"}
#	}
#	!$18{print}
#'' | sed 's/\t1:N:/_1:N:/' | sed 's/\t2:N:/_2:N:/'
# You might have to reorder
#awk 'FNR==NR {x2[$1] = $0; next} $1 in x2[$1] {print x2[$1]}' sorted_merged_A2_lmerge.clipsam ids_before.txt # something similar

#        {if(min+length(min_s)>max && min+length(min_s)<max+length(max_s)){
 #               $min_s_i=substr(min_s,0,max-min);$(min_s_i+1)=substr($(min_s_i+1),0,max-min);$(min_s_i+4)=substr($(min_s_i+4),0,max-min+5) 
                #printf $1; for(i=2;i<=17;++i) printf "\t"$i"\t"; printf "\n"; printf $1; for(i=18;i<=NF;++i)printf "\t"$i"\t"
 #               } 
  #      #else {print $1; for(i=2;i<=17;++i) printf "\t"$i"\t";printf "\n"; printf $1; for(i=18;i<=NF;++i)printf "\t"$i"\t"}
   #     }
#	print }
 #       !$19{print}
#'
#rm merged_${smp}.bam

#cat sorted_merged_A2.sam | cut -f 1,3,4,10 | sed 's/_2/_1/' | awk '{a[$1]=a[$1]?a[$1]"* "$0:$0} END {for (i in a) print a[i]}' | grep * * |  awk '{print $1, $3, $4, $7, $8}'

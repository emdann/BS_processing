#### CLIP OVERLAP
library(data.table)
#source("http://bioconductor.org/biocLite.R")
# #biocLite("Rsamtools")
library(dplyr)
# library(Rsamtools)
# library(parallel)

# setwd("~/mnt/organoids_bs/split_orgs_1/")
#merged_bed<-fread('sorted_merged_A2.bed') 
loadBed <- function(file_path){
  g<-fread(file_path) 
  colnames(g)<- c("chr", "start", "end", "ID", "V5", "strand")
  g$ID<-gsub(g$ID, pattern = "_2", replacement = "_1")
  return(g)
  }

clip<- function(id){
  if(nrow(id)==2 && length(unique(id$chr))==1){  
    if(id$start[1]!=id$start[2]){
    if(id$end[id$start==min(id$start)] > id$start[id$start!=min(id$start)] && id$end[id$start==min(id$start)] < id$end[id$start!=min(id$start)]){
      id$start[id$start!=min(id$start)] <- id$end[id$start==min(id$start)]+1
    }else{id<-id[id$end==max(id$end),]}
  }
  else{ if(id$end[1]!=id$end[2]){
    #id<-id[id$end==max(id$end)]
    id<-id[id$end==max(id$end),]
    }
    else{id<-id[1]}}}
  return(id)
}


# 
# start_g<-with(g[smp,],tapply(X=start, INDEX =ID, FUN = function(x) 
#   if(x[1]!=x[2]){
#     if(end[which(start==min(x))]> max(x)){
#       if(x[1]>x[2]){
#         c(x[1], end[which(start==min(x))]+1)}
#       else{c(end[which(start==min(x))]+1, x[2])}
#     }
#     else{x}
#     }
#   else{x}))

findRightReads <-function(merged_bed, perc=F){
  idx <- split(seq_len(nrow(merged_bed)), list(merged_bed$ID))
  paired_idx<-which(sapply(idx, function(x) length(x)==2))
  chim_idx<- which(sapply(idx[paired_idx], function(i) length(unique(g$chr[i]))==2))
  #lapply(id_list,function(x) if(length(unique(x["chr"]))==1){x}else{print("nope")})
  #perc<- c(single=length(idx)-length(paired_idx), paired=length(paired_idx)-length(chim_idx), chimeric=length(chim_idx))/length(idx)
  if(perc){return(perc)}
  else {return(idx[paired_idx][-chim_idx])}
  }

makeClippedBed<- function(){
  f <- file("stdin")
  # print("File loaded!")
  open(f)
  g <- loadBed(f)
  close(f)
  df<-g %>% group_by(ID) %>% do(clip(.)) %>% as.data.frame()
  fwrite(x = df, "~/mnt/sorted_merged_A2_lmerged.clip.bed", sep = "\t", col.names = F)
  }

f <- stdin()
# print("File loaded!")

print(f)
#close(f)


# smp.tab <- do.call(rbind, lapply(id_list, function(y) if(nrow(y)==2){clip(y)} else {y}))
# idx <- split(seq_len(nrow(f)), list(f$ID))
# id_list <- mclapply(idx,function(i) f[i,])

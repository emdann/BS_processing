#### SET TRIMMING BASE ####
f <- file("stdin")
# print("File loaded!")
open(f)
# print("File open!")
per_base <- read.delim(f, skip = 1)
close(f)
# print("File closed!")

set_trim_thresh <- function(per_base_content_file, thresh){
  ## ...
  deriv_tab <- apply(per_base_content_file[,2:5], 2, compute_derivative)
  #print(deriv_tab)
  cut<-max(apply(deriv_tab, 2, where_to_cut, thresh))
  #print(cut)
  if (grepl("-", per_base_content_file[cut,1])){
  base <- as.numeric(substr(per_base_content_file[cut,1], 4,5))
  }
  else {base <- cut}
  return(base)
}

where_to_cut <- function(col, thresh){
  for (i in 1:length(col)) {
    if (abs(col[i]) < thresh) {
      #print("yay")
      if (i !=1 && abs(col[i-1]) > thresh){
        # print("noice")
        first_pos <- i  
      }
    }
  }
  if(exists("first_pos")){return(first_pos)}
  else{return(5)}
}

compute_derivative <- function(col){
  deriv<- c()
  for(i in seq_along(col)){
    if (i == 1) {
      deriv <- c(deriv,0)
    }
    der <-col[i]-col[i-1]
    deriv <- c(deriv, der)
  }
  return(deriv)
}  

set_trim_thresh(per_base, 5)


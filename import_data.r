setwd("/home/kacper/Uni/spdb/project")
unzip("sources.zip")
source_files = list.files(getwd() , pattern=".csv")
sources <- lapply(source_files, function(x) {read.csv(x)})
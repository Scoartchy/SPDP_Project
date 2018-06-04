setwd("/home/kacper/Projects/study/uni/spdb/proj/workdir")
#setwd("C:/Users/Jakub/Documents/SPDP_Project")
a = Hmisc::mdb.get("CLIWOC21_2000.mdb")
for(i in seq_along(a)) {
  filename <- paste(i, ".csv", sep = "", collapse = "")
  print(filename)
  print(write.csv(a[i], file=paste(i, ".csv")))
}
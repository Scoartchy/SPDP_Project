#hexBinning
longitude <- file2[["Geodata.DecLongitude"]]
latitude <- file2[["Geodata.DecLatitude"]]
hbin <- hexBinning(longitude, latitude)
plot(hbin)

longitude <- file1[["CLIWOC21.Lon3"]]
latitude <- file1[["CLIWOC21.Lat3"]]
hbin <- hexBinning(longitude, latitude) #Error in if (dist1 < con1) { : missing value where TRUE/FALSE needed
plot(hbin)
#hexBinning
install.packages("fMultivar")
longitude <- file2[["Geodata.DecLongitude"]]
latitude <- file2[["Geodata.DecLatitude"]]
hbin <- fMultivar::hexBinning(longitude, latitude)
plot(hbin)

plotted <- filtered_logs[1:1000,]
atlantic <- ggplot2::map_data('world')
ggplot() + geom_polygon(data = atlantic, aes(x=long, y = lat, group = group)) + 
  ggplot2::geom_point(mapping = aes(plotted$CLIWOC21.Lon3, plotted$CLIWOC21.Lat3), size=0) +
  ggplot2::geom_hex(aes(hbin$x, hbin$y, fill=hbin$z), color="black", stat="identity")
  coord_fixed()

longitude <- file1[["CLIWOC21.Lon3"]]
latitude <- file1[["CLIWOC21.Lat3"]]
hbin <- fMultivar::hexBinning(longitude, latitude) #Error in if (dist1 < con1) { : missing value where TRUE/FALSE needed
plot(hbin)

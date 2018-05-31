library(ggplot2)
library(maps)

#Displaying the first 100 logs
plotted <- filtered_logs[1:1000,]
atlantic <- ggplot2::map_data('world')
ggplot() + geom_polygon(data = atlantic, aes(x=long, y = lat, group = group)) + 
  ggplot2::geom_point(mapping = aes(plotted$CLIWOC21.Lon3, plotted$CLIWOC21.Lat3), size=0) +
  ggplot2::geom_hex(mapping=aes(hbin$x, hbin$y), color = "red") +
  coord_fixed()

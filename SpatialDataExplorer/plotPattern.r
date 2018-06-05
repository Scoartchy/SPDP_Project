library(ggplot2)
library(spatstat)

setwd(".")
dir.create(file.path(getwd(), "out/plotPattern"), recursive = TRUE)


longitude <- filtered_geodata$Geodata.DecLongitude
latitude <- filtered_geodata$Geodata.DecLatitude

planarPointPattern <- ppp(longitude, latitude, c(-180, 180), c(-90,90))
summary(planarPointPattern)

plot(planarPointPattern, "Wzorzec punktów dla portów")

plot <- ggplot(data=planarPointPattern, aes(x, y)) +
  geom_point() +
  ggtitle("Point pattern for ports") 
ggsave(filename = paste("out/plotPattern/point_pattern_ports.png"), plot)


longitude <- filtered_logs$CLIWOC21.Lon3
latitude <- filtered_logs$CLIWOC21.Lat3

planarPointPattern <- ppp(longitude, latitude, c(-180, 180), c(-90,90))
summary(planarPointPattern)

plot(planarPointPattern, "Wzorzec punktów dla miejsc odwiedzonych w trakcie podró¿y")

plot <- ggplot(data=planarPointPattern, aes(x=x, y=y, group=1)) +
  geom_point() +
  ggtitle("Point pattern for travel points") 
ggsave(filename = paste("out/plotPattern/point_pattern_voyage.png"), plot)
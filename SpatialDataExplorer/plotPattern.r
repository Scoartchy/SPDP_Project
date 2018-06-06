library(ggplot2)
library(spatstat)

setwd(".")
dir.create(file.path(getwd(), "out/plotPattern"), recursive = TRUE)


longitude <- filtered_geodata$Geodata.DecLongitude
latitude <- filtered_geodata$Geodata.DecLatitude

planarPointPattern <- ppp(longitude, latitude, c(-180, 180), c(-90,90))
summary(planarPointPattern)

planarPointPattern = as.data.frame(planarPointPattern)
plot <- ggplot() +
  geom_point(aes(x=planarPointPattern$x, y = planarPointPattern$y), size = 0) +
  ggtitle("Point pattern for ports") +
  labs(x = "Longitude", y = "Latitude")
ggsave(filename = paste("out/pointPatterns/point_pattern_ports.png"), plot)


longitude <- filtered_logs$CLIWOC21.Lon3
latitude <- filtered_logs$CLIWOC21.Lat3

planarPointPattern <- ppp(longitude, latitude, c(-180, 180), c(-90,90))
summary(planarPointPattern)

planarPointPattern = as.data.frame(planarPointPattern)
plot <- ggplot() +
  geom_point(aes(x=planarPointPattern$x, y = planarPointPattern$y), size = 0) +
  ggtitle("Point pattern for travel points") +
  labs(x = "Longitude", y = "Latitude")
ggsave(filename = paste("out/pointPatterns/point_pattern_voyage.png"), plot)



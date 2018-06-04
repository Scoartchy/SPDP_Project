# Funkcja L
library(ggplot2)
library(spatstat)

#setwd(".")
#dir.create(file.path(getwd(), "out/functionL"), recursive = TRUE)

longitude <- filtered_geodata$Geodata.DecLongitude
latitude <- filtered_geodata$Geodata.DecLatitude

planarPointPattern <- ppp(longitude, latitude, c(-180, 180), c(-90,90))
summary(planarPointPattern)

result <- Lest(pointPattern)
plot(Lest(pointPattern))

# Plot of the point pattern
png("out/functionL/point_pattern.png") 
plot(planarPointPattern, main = "Point pattern", xlab = "Longitude", ylab = "Latitude")
dev.off()

# L-function (result and chart):
resultL <- Lest(planarPointPattern)
png("out/functionL/functionL.png") 
plot(resultL, main = "Funkcja L")
dev.off()

#Envelopes of L-function
png("out/functionL/envelopesOfFunctionL.png") 
plot(envelope(planarPointPattern, Lest))
dev.off()

# Funkcja L
library(spatstat)

longitude <- filtered_geodata$Geodata.DecLongitude
latitude <- filtered_geodata$Geodata.DecLatitude

planarPointPattern <- ppp(longitude, latitude, c(-180, 180), c(-90,90))
summary(planarPointPattern)

# Plot of the point pattern
plot(planarPointPattern, main = "Point pattern", xlab = "Longitude", ylab = "Latitude")

# L-function (result and chart):
resultL <- Lest(planarPointPattern)
plot(resultL, main = "Funkcja L")

#Envelopes of L-function
plot(envelope(planarPointPattern, Lest))
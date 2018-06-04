# Funckja K
library(spatstat)

longitude <- filtered_geodata$Geodata.DecLongitude
latitude <- filtered_geodata$Geodata.DecLatitude

planarPointPattern <- ppp(longitude, latitude, c(-180, 180), c(-90,90))
summary(planarPointPattern)

# Plot of the point pattern
plot(planarPointPattern, main = "Point pattern", xlab = "Longitude", ylab = "Latitude")

# Ripley's K-function (result and chart):
resultK <- Kest(planarPointPattern)
plot(resultK, main = "Funkcja K")

plot(Kest(planarPointPattern, correction = "border"), main = "Funkcja K (z zastosowaniem korekcji granicznej")
plot(Kest(planarPointPattern, correction = "isotropicr"), main = "Funkcja K (z zastosowaniem korekcji isotropowej")
plot(Kest(planarPointPattern, correction = "Ripley"), main = "Funkcja K (z zastosowanie korekcji Ripleya)")
plot(Kest(planarPointPattern, correction = "translate"), main = "Funkcja K (z zastosowaniem korekcji translacyjnej")
plot(Kest(planarPointPattern, correction = "all"), main = "Funkcja K (z zastosowaniem wszystkich korekcji")

correction=c("border", "isotropic", "Ripley", "translate"),

#Envelopes of K-function
plot(envelope(planarPointPattern, Kest))





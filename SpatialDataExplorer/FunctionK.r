# Funckja K
library(ggplot2)
library(spatstat)

#setwd(".")
#dir.create(file.path(getwd(), "out/functionK"), recursive = TRUE)

longitude <- filtered_geodata$Geodata.DecLongitude
latitude <- filtered_geodata$Geodata.DecLatitude

planarPointPattern <- ppp(longitude, latitude, c(-180, 180), c(-90,90))
summary(planarPointPattern)

result <- Kest(pointPattern)
plot(Kest(pointPattern))

# Plot of the point pattern
plot(planarPointPattern, main = "Point pattern", xlab = "Longitude", ylab = "Latitude")

# Ripley's K-function (result and chart):
resultK <- Kest(planarPointPattern)
png("out/functionK/functionK.png")
plot <- plot(resultK, main = "Funkcja K")
dev.off()

png("out/functionK/functionK_border.png")
plot <- plot(Kest(planarPointPattern, correction = "border"), main = "Funkcja K (z zastosowaniem korekcji granicznej)")
dev.off()

png("out/functionK/functionK_isotropic.png")
plot <- plot(Kest(planarPointPattern, correction = "isotropic"), main = "Funkcja K (z zastosowaniem korekcji izotropowej)")
dev.off()

png("out/functionK/functionK_Ripley.png")
plot <- plot(Kest(planarPointPattern, correction = "Ripley"), main = "Funkcja K (z zastosowanie korekcji Ripleya)")
dev.off()

png("out/functionK/functionK_translate.png")
plot <- plot(Kest(planarPointPattern, correction = "translate"), main = "Funkcja K (z zastosowaniem korekcji translacyjnej)")
dev.off()

png("out/functionK/functionK_all.png")
plot <- plot(Kest(planarPointPattern, correction = "all"), main = "Funkcja K (z zastosowaniem wszystkich korekcji)")
dev.off()

#Envelopes of K-function
png("out/functionK/envelopeOfFunctionK.png")
plot <- plot(envelope(planarPointPattern, Kest))
dev.off()





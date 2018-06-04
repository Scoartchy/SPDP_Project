# Funkcja G
library(ggplot2)
library(spatstat)

setwd(".")
dir.create(file.path(getwd(), "out/functionG"), recursive = TRUE)

longitude <- filtered_geodata$Geodata.DecLongitude
latitude <- filtered_geodata$Geodata.DecLatitude
  
pointPattern <- ppp(longitude, latitude, c(-180, 180), c(-90,90))
summary(planarPointPattern)

# Plot of the point pattern
png("out/functionG/pointPattern.png")
plot <- plot(planarPointPattern, main = "Point pattern", xlab = "Longitude", ylab = "Latitude")
dev.off()

# G-function (result and chart):
resultG <- Gest(planarPointPattern)
png("out/functionL/functionL.png")
plot(resultG, main = "Funkcja L")
dev.off()
  
png("out/functionG/functionG.png")  
plot <- plot(Gest(pointPattern), main = "Funkcja G")
dev.off()

png("out/functionG/functionG_cbindRs.png")
plot <- plot(Gest(pointPattern), cbind(rs, theo) ~ theo, main = "Funkcja G")
dev.off()

png("out/functionG/functionG_cbindKm.png")
plot <- plot(Gest(pointPattern), cbind(km, theo) ~ theo, main = "Funkcja G")
dev.off()

png("out/functionG/functionG_cbindHan.png")
plot <- plot(Gest(pointPattern), cbind(han, theo) ~ theo, main = "Funkcja G")
dev.off()

png("out/functionG/functionG_cbindKm.png")
plot <- plot(Gest(planarPointPattern, correction="rs"), main = "Funkcja G (z zastosowanie korekcji rs)")
dev.off()

png("out/functionG/functionG_Correlation_km.png")
plot <- plot(Gest(planarPointPattern, correction="km"), main = "Funkcja G (z zastosowanie korekcji km)")
dev.off()

png("out/functionG/functionG_CorrelationHan.png")
plot <- plot(Gest(planarPointPattern, correction_han="han"), main = "Funkcja G (z zastosowanie korekcji han)")
dev.off()
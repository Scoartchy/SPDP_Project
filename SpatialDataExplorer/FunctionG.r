# Funkcja G
library(spatstat)

longitude <- geodata$Geodata.DecLongitude
latitude <- geodata$Geodata.DecLatitude
  
pointPattern <- ppp(longitude, latitude, c(-180, 180), c(-90,90))
summary(planarPointPattern)

# Plot of the point pattern
plot(planarPointPattern, main = "Point pattern", xlab = "Longitude", ylab = "Latitude")

# G-function (result and chart):
resultG <- Gest(planarPointPattern)
plot(resultG, main = "Funkcja L")
  
plot(Gest(pointPattern))
plot(Gest(pointPattern), main = "Funkcja G")
plot(Gest(pointPattern), cbind(rs, theo) ~ theo, main = "Funkcja G")
plot(Gest(pointPattern), cbind(km, theo) ~ theo, main = "Funkcja G")
plot(Gest(pointPattern), cbind(han, theo) ~ theo, main = "Funkcja G")

plot(Gest(planarPointPattern, correction="rs"), main = "Funkcja G (z zastosowanie korekcji rs)")
plot(Gest(planarPointPattern, correction="km"), main = "Funkcja G (z zastosowanie korekcji km)")
plot(Gest(planarPointPattern, correction="han"), main = "Funkcja G (z zastosowanie korekcji han)")
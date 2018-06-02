longitude <- filtered_geodata$Geodata.DecLongitude
latitude <- filtered_geodata$Geodata.DecLatitude

planarPointPattern <- ppp(longitude, latitude, c(-180, 180), c(-90,90))
summary(planarPointPattern)

# Plot of the point pattern
plot(planarPointPattern, main = "Wzorzec punktów", xlab = "Szerokość geograficzna", ylab = "Długość geograficzna")

# Chart of the Ripley’s K-function:
plot(Kest(planarPointPattern), main = "Funkcja K")

#Envelopes of K-function
plot(envelope(planarPointPattern,Kest))

#Density of the pointPattern
dens <- density(planarPointPattern)
plot(dens)
persp(dens)
contour(dens)

#Kest(planarPointPattern, r=NULL, breaks=NULL, correction=c("Ripley"), nlarge=NULL) 
#"border", "isotropic", , "translate"

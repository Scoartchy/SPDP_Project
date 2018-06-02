longitude <- geodata$Geodata.DecLongitude
latitude <- geodata$Geodata.DecLatitude

pointPattern <- ppp(longitude, latitude, c(-180, 180), c(-90,90))
summary(pointPattern)

# Plot of the point pattern
plot(pointPattern)

# Chart of the Ripley’s K-function:
plot(Kest(pointPattern))

#Envelopes of K-function
plot(envelope(pointPattern,Kest))

#Density of the pointPattern
plot(density(pointPattern))

Kest(pointPattern, r=NULL, breaks=NULL, correction=c("Ripley"), nlarge=NULL) 
#"border", "isotropic", , "translate"
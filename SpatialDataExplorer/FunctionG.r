#Funkcja G # potrzebna paczka install.packages("inlabru")?
#Funkcja G
longitude <- geodata$Geodata.DecLongitude
latitude <- geodata$Geodata.DecLatitude

pointPattern <- ppp(longitude, latitude, c(-180, 180), c(-90,90))

plot(Gest(pointPattern))

Gest(pointPattern, r=NULL, breaks=NULL, correction=c("km"), domain=NULL)
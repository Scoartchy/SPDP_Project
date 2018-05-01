# KDE
longitude <- file2[["Geodata.DecLongitude"]]
latitude <- file2[["Geodata.DecLatitude"]]
lonlat <- cbind(longitude, latitude)
pts <- SpatialPoints(lonlat) #Error in .local(obj, ...) : NA values in coordinates
h <- 1 # scaled kernel should be adjusted
kde.points(pts, h, n=200, lims=NULL)

longitude <- file1[["CLIWOC21.Lon3"]]
latitude <- file1[["CLIWOC21.Log3"]]
lonlat <- cbind(longitude, latitude)
library(sp)
pts <- SpatialPoints(lonlat)
h <- 1 # scaled kernel should be adjusted
kde.points(pts, h, n=200, lims=NULL)
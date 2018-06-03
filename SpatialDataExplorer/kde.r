# KDE
install.packages("GISTools")
install.packages("ggplot2")

library(GISTools)
library(sp)
library(ggplot2)

#Perform KDE on geodata with h = 1 and n = 200
longitude <- filtered_geodata$Geodata.DecLongitude
latitude <- filtered_geodata$Geodata.DecLatitude
lonlat <- cbind(longitude, latitude)
pts <- SpatialPoints(lonlat) 
h <- 1 
res <- kde.points(pts, h, n=100, lims=NULL)
res <- as.data.frame(res)
ggplot(mapping = aes(x=res$Var1, y=res$Var2)) + 
  geom_tile(mapping = aes(fill = res$kde)) +
  geom_polygon(data = wmap, aes(x = long, y = lat, group = group)) +
  xlim(-180, 180) +
  ylim(-90, 90) +
  scale_fill_gradient(low = "white", high = "steelblue") +
  labs(fill = "level") +
  coord_fixed(1.3)
level.plot(res)

#Perform KDE on log data for british ships with h = 1 n = 300
nat_logs = filtered_logs[filtered_logs$CLIWOC21.Nationality == "British",]
longitude <- nat_logs$CLIWOC21.Lon3
latitude <- nat_logs$CLIWOC21.Lat3
lonlat <- cbind(longitude, latitude)
pts <- SpatialPoints(lonlat) #Error in .local(obj, ...) : NA values in coordinates
h <- 0.3 # scaled kernel should be adjusted
res <- kde.points(pts, h, n=300, lims=NULL)
ggplot(mapping = aes(x=res$Var1, y=res$Var2)) + 
  geom_tile(mapping = aes(fill = res$kde)) +
  geom_polygon(data = wmap, aes(x = long, y = lat, group = group)) +
  xlim(-180, 180) +
  ylim(-90, 90) +
  scale_fill_gradient(low = "white", high = "steelblue") +
  labs(fill = "level") +
  coord_fixed(1.3)

setwd(".")
dir.create(file.path(getwd(), "out/kde"), recursive = TRUE)

#But what if we used ggplot once again!
#Prepare parameters
nationalities = data.frame(matrix(unlist(
  levels(filtered_logs$CLIWOC21.Nationality)
), dimnames = list(c(), c("fac")), ncol = 1))
nationalities$name = as.character(nationalities[, 1])
parameters = rep(nationalities$name, 3)
parameters = data.frame(matrix(unlist(parameters), ncol = 1, dimnames = list(c(), "name")))
parameters[,1] = as.character(parameters[,1])
parameters=data.frame(matrix(unlist(parameters[order(parameters[,1]),]), ncol = 1))
parameters$n_s=data.frame(matrix(unlist(rep(list(100, 300, 500), 8)), ncol=1, dimnames=list(c(), "n")))[,1]
parameters[,1] = as.character(parameters[,1])
colnames(parameters)[1] <- "name"
by(parameters, 1:nrow(parameters), function(row) {
  nat_logs = filtered_logs[as.character(filtered_logs$CLIWOC21.Nationality) == row$name,]
  longitude <- nat_logs$CLIWOC21.Lon3
  latitude <- nat_logs$CLIWOC21.Lat3
  wmap <- map_data('world')
  
  plot <- ggplot() + 
    geom_polygon(data = wmap, aes(x = long, y = lat, group = group)) +
    xlim(-180, 180) +
    ylim(-90, 90) +
    geom_point(mapping = aes(x=longitude, y=latitude), size = 0) +
    stat_density_2d(aes(x=longitude, y=latitude, fill=..level..), geom = "polygon", n=row$n_s) +
    ggtitle(paste("kde ", row$name, "n =", row$n_s, sep = " ")) +
    labs(fill = "level") +
    coord_fixed(1.3)
  ggsave(paste("out/kde/", row$name, row$n_s, ".png", sep = "_"), plot)
})

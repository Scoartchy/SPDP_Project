library(raster)
library(colorRamps) # for some crispy colors
library(vegan) # will be used for PCNM
library(ggplot2)

#sudo apt-get install gdal-bin gdal-data libproj-dev libgdal-dev
#install.package("rgdal", type=source)
#install.packages("pgirmess")
library(pgirmess)

################################ Setup output directory

setwd(".")
dir.create(file.path(getwd(), "out/acf"), recursive = TRUE)
wmap <- map_data('world')

##########################################################################

dutch_logs = filtered_logs[as.character(filtered_logs$CLIWOC21.Nationality) == "Dutch", ]
dutch_logs = dutch_logs[1:1000, ]
american_logs = filtered_logs[as.character(filtered_logs$CLIWOC21.Nationality) == "American", ]
american_dutch_logs = rbind(dutch_logs, american_logs)

plot <- ggplot() + 
  geom_polygon(data = wmap, aes(x = long, y = lat, group = group)) +
  geom_point(aes(american_dutch_logs$CLIWOC21.Lon3, american_dutch_logs$CLIWOC21.Lat3, colour = american_dutch_logs$CLIWOC21.Nationality), size = 0) +
  xlim(-180, 180) +
  ylim(-90, 90) +
  scale_fill_gradient(low = "white", high = "red") +
  labs(colour = "Nationality", x="Longitude", y = "Lattitude") +
  ggtitle("American and Dutch logs") +
  coord_fixed(1.3)
ggsave(filename = paste("out/acf/logs_nl_us_visual.png"), plot)
corr.data <- american_dutch_logs[, c("CLIWOC21.Lon3", "CLIWOC21.Lat3", "CLIWOC21.Nationality")]
corr.data$CLIWOC21.Nationality = as.integer(corr.data$CLIWOC21.Nationality)
corr.data$CLIWOC21.Nationality = corr.data$CLIWOC21.Nationality * 100

da.corr <- correlog(coords=corr.data[,1:2], z=corr.data$CLIWOC21.Nationality, method="Moran")
da.corr <- as.data.frame(da.corr)
plot <- ggplot() +
  geom_line(aes(x=da.corr$dist.class, y=da.corr$coef), color = 3) +
  geom_point(aes(x=da.corr$dist.class, y=da.corr$coef)) +
  xlab("Distance") +
  ylab("Moran I") +
  ggtitle("American and Dutch spatial correlation")
ggsave(filename = paste("out/acf/corr_nl_us.png"), plot)

###################

british_logs = filtered_logs[as.character(filtered_logs$CLIWOC21.Nationality) == "British", ]
british_logs = british_logs[1:1000, ]
french_logs = filtered_logs[as.character(filtered_logs$CLIWOC21.Nationality) == "Dutch", ]
french_logs = french_logs[1:1000,]
british_dutch_logs = rbind(british_logs, french_logs)

ggplot() + 
  geom_polygon(data = wmap, aes(x = long, y = lat, group = group)) +
  geom_point(aes(british_dutch_logs$CLIWOC21.Lon3, british_dutch_logs$CLIWOC21.Lat3, colour = british_dutch_logs$CLIWOC21.Nationality), size = 0) +
  xlim(-180, 180) +
  ylim(-90, 90) +
  scale_fill_gradient(low = "white", high = "red") +
  labs(colour = "Nationality", x="Longitude", y = "Lattitude") +
  ggtitle("American and Dutch logs") +
  coord_fixed(1.3)
ggsave(filename = paste("out/acf/logs_fr_uk_visual.png"), plot)
corr.data <- british_dutch_logs[, c("CLIWOC21.Lon3", "CLIWOC21.Lat3", "CLIWOC21.Nationality")]
corr.data$CLIWOC21.Nationality = as.integer(corr.data$CLIWOC21.Nationality)
corr.data$CLIWOC21.Nationality = corr.data$CLIWOC21.Nationality * 100
corr.data$CLIWOC21.Nationality[corr.data$CLIWOC21.Nationality == 200] = -200

da.corr <- correlog(coords=corr.data[,1:2], z=corr.data$CLIWOC21.Nationality, method="Moran")
#As you see spatial correlation is not always possible
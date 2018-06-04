#hexBinning
library(ggplot2)
library(fMultivar)

################################ Setup output directory

setwd(".")
dir.create(file.path(getwd(), "out/hexbin"), recursive = TRUE)

################################ For geodata ie ports ####################################################

longitude <- geodata$Geodata.DecLongitude
latitude <- geodata$Geodata.DecLatitude
#using fmultivar for binning
hbin <- hexBinning(longitude, latitude)
wmap <- map_data('world')
plot <- ggplot() + geom_polygon(data = wmap, aes(x = long, y = lat, group = group)) +
  geom_hex(
    aes(hbin$x, hbin$y, fill = hbin$z),
    color = "black",
    stat = "identity",
    alpha = 0.8
  ) +
  ggtitle("fMultivar binning with 30 bins") +
  labs(fill = "count") +
  coord_fixed(1.3)
ggsave(filename = paste("out/hexbin/ports_fMultivar_30.png"), plot)

######lets see with more bins
hbin <- hexBinning(longitude, latitude, bins = 60)
plot <- ggplot() + geom_polygon(data = wmap, aes(x = long, y = lat, group = group)) +
  geom_hex(
    aes(hbin$x, hbin$y, fill = hbin$z),
    color = "black",
    stat = "identity",
    alpha = 0.8
  ) +
  ggtitle("fMultivar binning with 60 bins") +
  labs(fill = "count") +
  coord_fixed(1.3)
ggsave(filename = paste("out/hexbin/ports_fMultivar_60.png"), plot)

##########################################3ggplot has its own binning too!
wmap <- map_data('world')
plot <- ggplot() + geom_polygon(data = wmap, aes(x = long, y = lat, group = group)) +
  geom_hex(aes(x = longitude, y = latitude),
           color = "black",
           alpha = 0.8) +
  ggtitle("ggplot binning with 30 bins") +
  labs(fill = "count") +
  coord_fixed(1.3)
ggsave(filename = paste("out/hexbin/ports_ggplot_30.png"), plot)


########and with more bins
wmap <- map_data('world')
plot <- ggplot() + geom_polygon(data = wmap, aes(x = long, y = lat, group = group)) +
  geom_hex(
    aes(x = longitude, y = latitude),
    color = "black",
    alpha = 0.8,
    bins = 60
  ) +
  ggtitle("ggplot binning with 60 bins") +
  labs(fill = "count") +
  coord_fixed(1.3)
ggsave(filename = paste("out/hexbin/ports_ggplot_60.png"), plot)

############################################## For ships ########################################################

#################For all

longitude <- filtered_logs$CLIWOC21.Lon3
latitude <- filtered_logs$CLIWOC21.Lat3

#using fmultivar for binning
hbin <- hexBinning(longitude, latitude)
wmap <- map_data('world')
plot <-
  ggplot() + geom_polygon(data = wmap, aes(x = long, y = lat, group = group)) +
  geom_hex(
    aes(hbin$x, hbin$y, fill = hbin$z),
    color = "black",
    stat = "identity",
    alpha = 0.8
  ) +
  ggtitle("fMultivar binning with 30 bins") +
  labs(fill = "count") +
  coord_fixed(1.3)
ggsave(plot = plot,
       filename = paste("out/hexbin/fmulti_30.png"))

#lets see with more bins
hbin <- hexBinning(longitude, latitude, bins = 60)
plot <-
  ggplot() + geom_polygon(data = wmap, aes(x = long, y = lat, group = group)) +
  geom_hex(
    aes(hbin$x, hbin$y, fill = hbin$z),
    color = "black",
    stat = "identity",
    alpha = 0.8
  ) +
  ggtitle("fMultivar binning with 60 bins") +
  labs(fill = "count") +
  coord_fixed(1.3)
ggsave(plot = plot,
       filename = paste("out/hexbin/fmulti_60.png"))

#ggplot has its own binning too!
wmap <- map_data('world')
plot <-
  ggplot() + geom_polygon(data = wmap, aes(x = long, y = lat, group = group)) +
  geom_hex(aes(x = longitude, y = latitude),
           color = "black",
           alpha = 0.8) +
  ggtitle("ggplot binning with 30 bins") +
  labs(fill = "count") +
  coord_fixed(1.3)
ggsave(plot = plot,
       filename = paste("out/hexbin/ggplot_30.png"))

#and with more bins
wmap <- map_data('world')
plot <-
  ggplot() + geom_polygon(data = wmap, aes(x = long, y = lat, group = group)) +
  geom_hex(
    aes(x = longitude, y = latitude),
    color = "black",
    alpha = 0.8,
    bins = 45
  ) +
  ggtitle("ggplot binning with 45 bins") +
  labs(fill = "count") +
  coord_fixed(1.3)
ggsave(plot = plot,
       filename = paste("out/hexbin/ggplot_45.png"))

#### Looks a little messy doesn't it? Perhaps let's try a more robust analysis - by nations
nationalities = data.frame(matrix(unlist(
  levels(filtered_logs$CLIWOC21.Nationality)
), dimnames = list(c(), c("fac")), ncol = 1))
nationalities$name = as.character(nationalities[, 1])

by(nationalities, 1:nrow(nationalities), function(row) {
  nat_logs = filtered_logs[filtered_logs$CLIWOC21.Nationality == row$fac,]
  longitude <- nat_logs$CLIWOC21.Lon3
  latitude <- nat_logs$CLIWOC21.Lat3
  
  #using fmultivar for binning
  hbin <- hexBinning(longitude, latitude)
  wmap <- map_data('world')
  plot <-
    ggplot() + geom_polygon(data = wmap, aes(x = long, y = lat, group = group)) +
    geom_hex(
      aes(hbin$x, hbin$y, fill = hbin$z),
      color = "black",
      stat = "identity",
      alpha = 0.8
    ) +
    ggtitle(paste("fMultivar binning with 30 bins for ", row$name, sep = "")) +
    labs(fill = "count") +
    coord_fixed(1.3)
  ggsave(
    plot = plot,
    filename = paste("out/hexbin/multivar30", row$name, ".png", sep = "")
  )
  
  #lets see with more bins
  hbin <- hexBinning(longitude, latitude, bins = 60)
  plot <- ggplot() + geom_polygon(data = wmap, aes(x = long, y = lat, group = group)) +
    geom_hex(
      aes(hbin$x, hbin$y, fill = hbin$z),
      color = "black",
      stat = "identity",
      alpha = 0.8
    ) +
    ggtitle(paste("fMultivar binning with 60 bins ", row$name, sep = "")) +
    labs(fill = "count") +
    coord_fixed(1.3)
  ggsave(
    plot = plot,
    filename = paste("out/hexbin/multivar60", row$name, ".png", sep = "")
  )
  
  #ggplot has its own binning too!
  wmap <- map_data('world')
  plot <- ggplot() + geom_polygon(data = wmap, aes(x = long, y = lat, group = group)) +
    geom_hex(aes(x = longitude, y = latitude),
             color = "black",
             alpha = 0.8) +
    ggtitle(paste("ggplot binning with 30 bins for ", row$name, sep = "")) +
    labs(fill = "count") +
    coord_fixed(1.3)
  ggsave(
    plot = plot,
    filename = paste("out/hexbin/ggplot30", row$name, ".png", sep = "")
  )
  
  #and with more bins
  wmap <- map_data('world')
  plot <- ggplot() + geom_polygon(data = wmap, aes(x = long, y = lat, group = group)) +
    geom_hex(
      aes(x = longitude, y = latitude),
      color = "black",
      alpha = 0.8,
      bins = 45
    ) +
    ggtitle(paste("ggplot binning with 45 bins ", row$name, sep = "")) +
    labs(fill = "count") +
    coord_fixed(1.3)
  ggsave(
    plot = plot,
    filename = paste("out/hexbin/ggplot45", row$name, ".png", sep = "")
  )
  
})

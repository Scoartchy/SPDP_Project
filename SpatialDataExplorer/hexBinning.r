#hexBinning
install.packages("fMultivar")
library(ggplot2)
library(fMultivar)
longitude <- geodata$Geodata.DecLongitude
latitude <- geodata$Geodata.DecLatitude

################################ For geodata ie ports ####################################################

#using fmultivar for binning
hbin <- hexBinning(longitude, latitude)
wmap <- map_data('world')
ggplot() + geom_polygon(data = wmap, aes(x=long, y = lat, group = group)) + 
  geom_hex(aes(hbin$x, hbin$y, fill=hbin$z), color="black", stat="identity", alpha=0.8) +
  ggtitle("fMultivar binning with 30 bins") +
  labs(fill="count") +
  coord_fixed(1.3)
  
#lets see with more bins
hbin <- hexBinning(longitude, latitude, bins=60)
ggplot() + geom_polygon(data = wmap, aes(x=long, y = lat, group = group)) + 
  geom_hex(aes(hbin$x, hbin$y, fill=hbin$z), color="black", stat="identity", alpha=0.8) +
  ggtitle("fMultivar binning with 60 bins") +
  labs(fill="count") +
  coord_fixed(1.3)
  
#ggplot has its own binning too!
wmap <- map_data('world')
ggplot() + geom_polygon(data = wmap, aes(x=long, y = lat, group = group)) + 
    geom_hex(aes(x = longitude, y = latitude), color="black", alpha=0.8) +
    ggtitle("ggplot binning with 30 bins") +
    labs(fill="count") +
    coord_fixed(1.3)

#and with more bins
wmap <- map_data('world')
ggplot() + geom_polygon(data = wmap, aes(x=long, y = lat, group = group)) + 
  geom_hex(aes(x = longitude, y = latitude), color="black", alpha=0.8, bins=60) +
  ggtitle("ggplot binning with 60 bins") +
  labs(fill="count") +
  coord_fixed(1.3)

############################################## For ships ########################################################

#################For all 

longitude <- filtered_logs$CLIWOC21.Lon3
latitude <- filtered_logs$CLIWOC21.Lat3

#using fmultivar for binning
hbin <- hexBinning(longitude, latitude)
wmap <- map_data('world')
ggplot() + geom_polygon(data = wmap, aes(x=long, y = lat, group = group)) + 
  geom_hex(aes(hbin$x, hbin$y, fill=hbin$z), color="black", stat="identity", alpha=0.8) +
  ggtitle("fMultivar binning with 30 bins") +
  labs(fill="count") +
  coord_fixed(1.3)

#lets see with more bins
hbin <- hexBinning(longitude, latitude, bins=60)
ggplot() + geom_polygon(data = wmap, aes(x=long, y = lat, group = group)) + 
  geom_hex(aes(hbin$x, hbin$y, fill=hbin$z), color="black", stat="identity", alpha=0.8) +
  ggtitle("fMultivar binning with 60 bins") +
  labs(fill="count") +
  coord_fixed(1.3)

#ggplot has its own binning too!
wmap <- map_data('world')
ggplot() + geom_polygon(data = wmap, aes(x=long, y = lat, group = group)) + 
  geom_hex(aes(x = longitude, y = latitude), color="black", alpha=0.8) +
  ggtitle("ggplot binning with 30 bins") +
  labs(fill="count") +
  coord_fixed(1.3)

#and with more bins
wmap <- map_data('world')
ggplot() + geom_polygon(data = wmap, aes(x=long, y = lat, group = group)) + 
  geom_hex(aes(x = longitude, y = latitude), color="black", alpha=0.8, bins=45) +
  ggtitle("ggplot binning with 60 bins") +
  labs(fill="count") +
  coord_fixed(1.3)

#### Looks a little messy doesn't it? Perhaps let's try a more robust analysis


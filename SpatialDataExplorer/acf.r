library(raster)
library(colorRamps) # for some crispy colors
library(vegan) # will be used for PCNM

# empty matrix and spatial coordinates of its cells
side=30
my.mat <- matrix(NA, nrow=side, ncol=side)
x.coord <- rep(1:side, each=side)
y.coord <- rep(1:side, times=side)
xy <- data.frame(x.coord, y.coord)

# all paiwise euclidean distances between the cells
xy.dist <- dist(xy)

# PCNM axes of the dist. matrix (from 'vegan' package)
pcnm.axes <- pcnm(xy.dist)$vectors

# using 8th PCNM axis as my atificial z variable
z.value <- pcnm.axes[,8]*200 + rnorm(side*side, 0, 1)

# plotting the artificial spatial data
my.mat[] <- z.value
r <- raster(my.mat)
plot(r, axes=F, col=matlab.like(20))




library(ncf)
ncf.cor <- correlog(x.coord, y.coord, z.value,
                    increment=2, resamp=500)




library(pgirmess)
pgi.cor <- correlog(coords=xy, z=z.value, method="Moran", nbclass=21)


dutch_logs = filtered_logs[as.character(filtered_logs$CLIWOC21.Nationality) == "Dutch"]
american_logs = filtered_logs[as.character(filtered_logs$CLIWOC21.Nationality) == "American"]


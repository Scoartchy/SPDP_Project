install.packages("raster")
install.packages("colorRamps")
install.packages("vegan")
install.packages("ncf")
library(ncf)
install.packages("pgirmess")

# packages used for the data generation
library(raster)
library(colorRamps) # for some crispy colors
library(vegan) # will be used for PCNM
library(pgirmess)

longitude <- filtered_logs$CLIWOC21.Lat3
latitude <- filtered_logs$CLIWOC21.Lon3

# empty matrix and spatial coordinates of its cells
side=30
my.mat <- matrix(NA, nrow=side, ncol=side)
x.coord <- longitude
y.coord <- latitude
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


#NCF
ncf.cor <- correlog(x.coord, y.coord, z.value,
                    increment=2, resamp=500)
plot(ncf.cor)


#PGI
pgi.cor <- correlog(coords=xy, z=z.value, method="Moran", nbclass=21)

plot(pgi.cor)


#SP
# 'nb' - neighbourhood of each cell
r.nb <- dnearneigh(as.matrix(xy), d1=0.5, d2=1.5)
# 'nb' - an alternative way to specify the neighbourhood
# r.nb <- cell2nb(nrow=side, ncol=side, type="queen")
sp.cor <- sp.correlogram(r.nb, z.value, order=15,
                         method="I", randomisation=FALSE)
plot(spi.cor)
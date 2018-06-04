library("gstat")
library("sp")
library(ggplot2)
suppressPackageStartupMessages({
  library(dplyr) # for "glimpse"
  library(ggplot2)
  library(scales) # for "comma"
  library(magrittr)
})
library(gridExtra)

################################ Setup output directory

setwd(".")
dir.create(file.path(getwd(), "out/krige"), recursive = TRUE)
wmap <- map_data('world')

############################################ On to the good stuff

##########Let's try to krieg 
####First let's clean the data
filtered_logs$CLIWOC21.WindForce = as.character(filtered_logs$CLIWOC21.WindForce)
wind_logs = filtered_logs[
  filtered_logs$CLIWOC21.WindForce == "0" |
    filtered_logs$CLIWOC21.WindForce == "1" |
    filtered_logs$CLIWOC21.WindForce == "2" |
    filtered_logs$CLIWOC21.WindForce == "3" |
    filtered_logs$CLIWOC21.WindForce == "4" |
    filtered_logs$CLIWOC21.WindForce == "5" |
    filtered_logs$CLIWOC21.WindForce == "6" |
    filtered_logs$CLIWOC21.WindForce == "7" |
    filtered_logs$CLIWOC21.WindForce == "8" |
    filtered_logs$CLIWOC21.WindForce == "9" |
    filtered_logs$CLIWOC21.WindForce == "10" |
    filtered_logs$CLIWOC21.WindForce == "11" |
    filtered_logs$CLIWOC21.WindForce == "12" , ]

wind_logs$CLIWOC21.WindForce = as.integer(wind_logs$CLIWOC21.WindForce)
wind_logs = wind_logs[wind_logs$CLIWOC21.Lat3 > -45 & wind_logs$CLIWOC21.Lat3 < 60, ]
wind_logs = wind_logs[wind_logs$CLIWOC21.Lon3 > -75 & wind_logs$CLIWOC21.Lon3 < 125, ]
#We are left with 36.6k records out of original 247.4k, so only 1 in 8. Could do with some heuristics here to show a little bit more. 
#Still this is decent enough. Let's see it on the graph.

plot <- ggplot() +
  geom_point(aes(x = wind_logs$CLIWOC21.Lon3, y = wind_logs$CLIWOC21.Lat3, color = wind_logs$CLIWOC21.WindForce), alpha=0.75) +
  ggtitle("Wind force in beaufort") + 
  labs(x = "longitude", y = "latitude", color = "Wind Force[Beaufort]") +
  coord_equal() + 
  theme_bw()
ggsave(filename = paste("out/krige/winds.png"))

#Nice!
#So let's get down to business (to defeat the huns)
#1. Convert to spatial data frame!
str(wind_logs)
coordinates(wind_logs) <- ~ CLIWOC21.Lon3 + CLIWOC21.Lat3
class(wind_logs)
str(wind_logs)
#2. Variogram
winds.vgm <- variogram(list(wind_logs@data$CLIWOC21.WindForce), list(wind_logs@coords))
winds.fit <- fit.variogram(winds.vgm, model=vgm(1.7, "Sph", 70, 1.5))
plot(winds.vgm, winds.fit)
#3. Prep
plot1 <- wind_logs %>% as.data.frame %>%
  ggplot(aes(CLIWOC21.Lon3, CLIWOC21.Lat3)) + geom_point(size=0) + coord_equal() + 
  ggtitle("Points with measurements")

winds_grid = makegrid(wind_logs)

plot2 <- winds_grid %>% as.data.frame %>%
  ggplot(aes(x1, x2)) + geom_point(size=0) + coord_equal() + 
  ggtitle("Points at which to estimate")
grid.arrange(plot1, plot2, ncol = 2)
#4. KRIGE!
coordinates(winds_grid) <- ~ x1 + x2 # step 3 above
winds.kriged <- krige(wind_logs@data$CLIWOC21.WindForce ~ 1, wind_logs, winds_grid, model=winds.fit, nmax=10, nmin=1)
plot <- winds.kriged %>% as.data.frame %>%
  ggplot(aes(x=x1, y=x2)) + 
  geom_tile(aes(fill=var1.pred)) + 
  coord_equal() +
  scale_fill_gradient(low = "yellow", high="red") +
  scale_x_continuous(labels=comma) + scale_y_continuous(labels=comma) +
  theme_bw()
ggsave(filename = paste("out/krige/winds_kriged.png"))

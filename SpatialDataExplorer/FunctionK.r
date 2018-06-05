# Funckja K
library(ggplot2)
library(spatstat)

setwd(".")
dir.create(file.path(getwd(), "out/functionK"), recursive = TRUE)

longitude <- filtered_geodata$Geodata.DecLongitude
latitude <- filtered_geodata$Geodata.DecLatitude

planarPointPattern <- ppp(longitude, latitude, c(-180, 180), c(-90,90))
summary(planarPointPattern)

result <- Kest(pointPattern)

plot <- ggplot(data=result, aes(x=r, y=theo, group=1)) +
  geom_line() +
  ylab("K(r) (theo)") +
  ggtitle("K function (theo)") 
ggsave(filename = paste("out/functionK/functionK_theo.png"), plot)

plot <- ggplot(data=result, aes(x=r, y=border, group=1)) +
  geom_line() +
  ylab("K(r) (border)") +
  ggtitle("K function (border)") 
ggsave(filename = paste("out/functionK/functionK_border.png"), plot)

plot <- ggplot(data=result, aes(x=r, y=trans, group=1)) +
  geom_line()  +
  ylab("K(r) (trans)") +
  ggtitle("K function (trans)") 
ggsave(filename = paste("out/functionK/functionK_trans.png"), plot)

plot <- ggplot(data=result, aes(x=r, y=iso, group=1)) +
  geom_line() +
  ylab("K(r) (iso)") +
  ggtitle("K function (iso)") 
ggsave(filename = paste("out/functionK/functionK_iso.png"), plot)

plot <- ggplot(data=result, aes(x=r, y=theo)) +
  geom_line(aes(y=theo, colour = "theo"), group = 1) +
  geom_line(aes(y=border, colour = "border"), group = 2) +
  geom_line(aes(y=trans, colour = "trans"), group = 3) +
  geom_line(aes(y=iso, colour = "iso"), group = 4) +
  ylab("K(r)") +
  ggtitle("K function") 
ggsave(filename = paste("out/functionK/functionK.png"), plot)
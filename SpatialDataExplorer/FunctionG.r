# Funkcja G
library(ggplot2)
library(spatstat)

setwd(".")
dir.create(file.path(getwd(), "out/functionG"), recursive = TRUE)

longitude <- filtered_geodata$Geodata.DecLongitude
latitude <- filtered_geodata$Geodata.DecLatitude
  
pointPattern <- ppp(longitude, latitude, c(-180, 180), c(-90,90))
summary(pointPattern)

result <- Gest(pointPattern)

plot <- ggplot(data=result, aes(x=r, y=theo, group=1)) +
  geom_line() +
  ylab("G(r) (theo)") +
  ggtitle("G function (theo)") 
ggsave(filename = paste("out/functionG/functionG_theo.png"), plot)

plot <- ggplot(data=result, aes(x=r, y=han, group=1)) +
  geom_line() +
  ylab("G(r) (han)") +
  ggtitle("G function (han)") 
ggsave(filename = paste("out/functionG/functionG_han.png"), plot)

plot <- ggplot(data=result, aes(x=r, y=rs, group=1)) +
  geom_line()  +
  ylab("G(r) (rs)") +
  ggtitle("G function (rs)") 
ggsave(filename = paste("out/functionG/functionG_rs.png"), plot)

plot <- ggplot(data=result, aes(x=r, y=km, group=1)) +
  geom_line() +
  ylab("G(r) (km)") +
  ggtitle("G function (km)") 
ggsave(filename = paste("out/functionG/functionG_km.png"), plot)

plot <- ggplot(data=result, aes(x=r, y=hazard, group=1)) +
  geom_line() +
  ylab("G(r) (hazard)") +
  ggtitle("G function (hazard)") 
ggsave(filename = paste("out/functionG/functionG_hazard.png"), plot)

plot <- ggplot(data=result, aes(x=r, y=theohaz, group=1)) +
  geom_line() +
  ylab("G(r) (theohaz)") +
  ggtitle("G function (theohaz)") 
ggsave(filename = paste("out/functionG/functionG_theohaz.png"), plot)

plot <- ggplot(data=result, aes(x=r, y=theo)) +
  geom_line(aes(y=theo, colour = "theo"), group = 1) +
  geom_line(aes(y=han, colour = "han"), group = 2) +
  geom_line(aes(y=rs, colour = "rs"), group = 3) +
  geom_line(aes(y=km, colour = "km"), group = 4) +
  geom_line(aes(y=hazard, colour = "hazard"), group = 5) +
  geom_line(aes(y=theohaz, colour = "theohaz"), group = 6) +
  ylab("G(r)") +
  ggtitle("G function") 
ggsave(filename = paste("out/functionG/functionG.png"), plot)

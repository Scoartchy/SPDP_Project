# Funkcja L
library(ggplot2)
library(spatstat)

setwd(".")
dir.create(file.path(getwd(), "out/functionL"), recursive = TRUE)

longitude <- filtered_geodata$Geodata.DecLongitude
latitude <- filtered_geodata$Geodata.DecLatitude

planarPointPattern <- ppp(longitude, latitude, c(-180, 180), c(-90,90))
summary(planarPointPattern)

result<- Lest(pointPattern)

plot <- ggplot(data=result, aes(x=r, y=theo, group=1)) +
  geom_line() +
  ylab("L(r) (theo)") +
  ggtitle("L function (theo)") 
ggsave(filename = paste("out/functionL/functionL_theo.png"), plot)

plot <- ggplot(data=result, aes(x=r, y=border, group=1)) +
  geom_line() +
  ylab("L(r) (border)") +
  ggtitle("L function (border)") 
ggsave(filename = paste("out/functionL/functionL_border.png"), plot)

plot <- ggplot(data=result, aes(x=r, y=trans, group=1)) +
  geom_line()  +
  ylab("L(r) (trans)") +
  ggtitle("L function (trans)") 
ggsave(filename = paste("out/functionL/functionL_trans.png"), plot)

plot <- ggplot(data=result, aes(x=r, y=iso, group=1)) +
  geom_line() +
  ylab("L(r) (iso)") +
  ggtitle("L function (iso)") 
ggsave(filename = paste("out/functionL/functionL_iso.png"), plot)

plot <- ggplot(data=result, aes(x=r, y=theo)) +
  geom_line(aes(y=theo, colour = "theo"), group = 1) +
  geom_line(aes(y=border, colour = "border"), group = 2) +
  geom_line(aes(y=trans, colour = "trans"), group = 3) +
  geom_line(aes(y=iso, colour = "iso"), group = 4) +
  ylab("L(r)") +
  ggtitle("L function") 
ggsave(filename = paste("out/functionL/functionL.png"), plot)

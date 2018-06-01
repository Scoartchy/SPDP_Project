source_files = list.files(getwd() , pattern=".csv")
sources <- lapply(source_files, function(x) {read.csv(x)})

###########################filter the data

logs <- sources[[1]]
filtered_logs <- logs[logs$CLIWOC21.Year >= 1750, ]
filtered_logs <- filtered_logs[filtered_logs$CLIWOC21.Year <= 1850, ]
filtered_logs <- filtered_logs[!is.na(filtered_logs$CLIWOC21.Lat3), ]
filtered_logs <- filtered_logs[!is.na(filtered_logs$CLIWOC21.Lon3), ]
filtered_logs <- filtered_logs[, c("CLIWOC21.RecID", "CLIWOC21.VoyageFrom", "CLIWOC21.VoyageTo", "CLIWOC21.Nationality", "CLIWOC21.Lat3", "CLIWOC21.Lon3", 
                                   "CLIWOC21.Anchored", "CLIWOC21.WindDirection", "CLIWOC21.WindForce", "CLIWOC21.ShipName")]
geodata <- sources[[6]]
filtered_geodata <- geodata[!is.na(geodata$Geodata.DecLongitude), ]
filtered_geodata <- filtered_geodata[!is.na(filtered_geodata$Geodata.DecLatitude), ]
filtered_geodata <- filtered_geodata[, c("Geodata.ID", "Geodata.DecLatitude", "Geodata.DecLongitude")]

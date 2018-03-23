library(tidyverse)
library(ggmap)


# ---------------------------------
# Bude Roadmap and Watercolor map |
# ---------------------------------

# Rodamap
map_Bude_roadmap <- get_map(location = c(lon = -4.54, lat = 50.826), zoom = 14, maptype = 'roadmap', source = 'google')
ggmap(map_Bude_roadmap, extent = 'device')

# watercolor map
map_Bude_watercolormap <- get_map(location = c(lon = -4.54, lat = 50.826), zoom = 14, maptype = 'watercolor', source = 'google')
ggmap(map_Bude_watercolormap, extent = 'device')

# ---------------------------------------------------------------
# One cricket court and two surfing beaches marked on both maps |
# ---------------------------------------------------------------
# convert address to location: https://www.latlong.net/convert-address-to-lat-long.html
# places chosen: 
# 50.832584 -4.553165 North Cornwall Cricket Club 
# 50.836809 -4.553006 Crooklets Beach
# 50.830965 -4.549856 Summerleaze Beach

# store location and name in a data.frame
my_lon = c(-4.553165, -4.553006, -4.549856)
my_lat = c(50.832584, 50.836809, 50.830965)
my_placename = c('North Cornwall Cricket Club', 'Crooklets Beach', 'Summerleaze Beach')
my_place <- data.frame(my_lon, my_lat, my_placename)

# Rodamap with markers
ggmap(map_Bude_roadmap, extent = 'device') + geom_point(aes(x = my_lon, y = my_lat), data = my_place) + geom_text(aes(x = my_lon, y = my_lat, label = my_placename), hjust = - 0.1, data = my_place)

# watercolor map with markers
ggmap(map_Bude_watercolormap, extent = 'device') + geom_point(aes(x = my_lon, y = my_lat), data = my_place) + geom_text(aes(x = my_lon, y = my_lat, label = my_placename), hjust = - 0.1, data = my_place)


# ------------------------------------------------
# Find a pub and mark the route to cricket court |
# ------------------------------------------------

# pub chosen: 
# 50.830066 -4.543023 The Barrel at Bude

# use place name to fetch route from google
from <- "North Cornwall Cricket Club"
to <- "The Barrel at Bude"
route_df <- route(from, to, mode = 'walking', output = 'simple' , structure = "route")

# make a new data.frame only have pub and cricket court
my_lon = c(-4.553165, -4.543023)
my_lat = c(50.832584, 50.830066)
my_placename = c('North Cornwall Cricket Club', 'The Barrel at Bude')
my_place2 <- data.frame(my_lon, my_lat, my_placename)

# roadmap with route from cricket ground to pub
ggmap(map_Bude_roadmap, extent = 'device') + geom_point(aes(x = my_lon, y = my_lat), data = my_place2) + geom_text(aes(x = my_lon, y = my_lat, label = my_placename), hjust = - 0.1, data = my_place2) + 
  geom_path(
    aes(x = lon, y = lat),  colour = "blue", size = 1,
    data = route_df, lineend = "round"
  )



# ---------------------------------------------
# Adding Hotels 
# ---------------------------------------------

# Tommy Jacks Beach Hotel
tommyjacks <- geocode("Crooklets Beach Cafe, Crooklets, Bude EX23 8NF, UK")

# Edgcumbe Hotel
edgecumbe <- geocode("Edgecumbe Hotel, 19 Summerleaze Cres, Bude EX23 8HJ, UK")

#Add these hotels to maps of Bude

#road map
ggmap(map_Bude_roadmap) + 
  geom_point(aes(x = my_lon, y = my_lat), data = my_place) + 
  geom_text(aes(x = my_lon, y = my_lat, label = my_placename), hjust = - 0.1, data = my_place) +
  geom_point(aes(x = edgecumbe$lon, y = edgecumbe$lat)) +
  geom_text(aes(x = edgecumbe$lon, y = edgecumbe$lat, label = "Edgecumbe Hotel", hjust=1, vjust=1)) +
  geom_point(aes(x = tommyjacks$lon, y = tommyjacks$lat)) +
  geom_text(aes(x = tommyjacks$lon, y = tommyjacks$lat, label = "Tommy Jacks Beach Hotel", hjust=1, vjust=1))

# watercolor map 
ggmap(map_Bude_watercolormap) + 
  geom_point(aes(x = my_lon, y = my_lat), data = my_place) + 
  geom_text(aes(x = my_lon, y = my_lat, label = my_placename), hjust = - 0.1, data = my_place) +
  geom_point(aes(x = edgecumbe$lon, y = edgecumbe$lat)) +
  geom_text(aes(x = edgecumbe$lon, y = edgecumbe$lat, label = "Edgecumbe Hotel", hjust=1, vjust=1)) +
  geom_point(aes(x = tommyjacks$lon, y = tommyjacks$lat)) +
  geom_text(aes(x = tommyjacks$lon, y = tommyjacks$lat, label = "Tommy Jacks Beach Hotel", hjust=1, vjust=1))
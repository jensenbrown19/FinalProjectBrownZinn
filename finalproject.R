# Final Project
# Jensen Brown & Cameron Zinn

# Required libraries
library(rgdal)
library(ggplot2)
library(readxl)
library(tidyverse)

# Reading spreadsheets, merging spreadsheets, and filtering spreadsheet
class_data <- read_xlsx("ENVS 4826 Project Data.xlsx")
tree_data <-  read_xlsx("SMUtreedatabase2021.xlsx")
project_data <- merge(class_data, tree_data, by = "uid_4826")
campus_data <- filter(project_data, location == "SMU campus")
campus_data_fixed <- 

# Reading shapefiles
campus_buildings <- readOGR(dsn = 'C:/Users/jense/Desktop/ENVS 4826 - Data Science in the Environment/FinalProject/CampusMap_Background_SHP', layer = "CampusBuildings")
greenspace <- readOGR(dsn = 'C:/Users/jense/Desktop/ENVS 4826 - Data Science in the Environment/FinalProject/CampusMap_Background_SHP', layer = "Greenspace")
pathways <- readOGR(dsn = 'C:/Users/jense/Desktop/ENVS 4826 - Data Science in the Environment/FinalProject/CampusMap_Background_SHP', layer = "Pathways")
pavement <- readOGR(dsn = 'C:/Users/jense/Desktop/ENVS 4826 - Data Science in the Environment/FinalProject/CampusMap_Background_SHP', layer = "Pavement")

# Fortifying shapefiles to be dataframes
campus_buildings_df <- fortify(campus_buildings)
greenspace_df <- fortify(greenspace)
pathways_df <- fortify(pathways)
pavement_df <- fortify(pavement)

# Plotting
ggplot() +
  geom_polygon(data = campus_buildings_df, aes(x = long, y = lat, group = group), colour = "Blue") +
  geom_polygon(data = greenspace_df, aes(x = long, y = lat, group = group), colour = "Green") +
  geom_polygon(data = pathways_df, aes(x = long, y = lat, group = group)) +
  geom_polygon(data = pavement_df, aes(x = long, y = lat, group = group)) +
  geom_point(data = campus_data, aes(x = UTMX, y = UTMY), colour = "Red") +
  labs(title = "Crown Condition of Trees Around SMU Campus", x = "Longitude", y = "Latitude")

# Final Project
# Jensen Brown & Cameron Zinn

# Required libraries
library(rgdal)
library(ggplot2)
library(readxl)
library(tidyverse)
library(rgeos)
library(dplyr)
library(sf)
library(sp)
library(spdep)
library(foreign)

# Reading spreadsheets, merging spreadsheets, and filtering spreadsheet
class_data <- st_read("ENVS 4826 Project Data.csv",
                      options = c("X_POSSIBLE_NAMES=x", 
                                  "Y_POSSIBLE_NAMES=y"),
                      crs = 4326)
st_crs(class_data)
tree_data <-  read_xlsx("SMUtreedatabase2021.xlsx")
project_data <- merge(class_data, tree_data, by = "uid_4826")
campus_data <- filter(project_data, location == "SMU campus")
campus_data %>% drop_na(crown_condition)
crown_condition_int <- recode(campus_data$crown_condition, 'G' = 'G', 'F' = 'FP', 'P' = 'FP')
campus_data$crown_condition_int <- crown_condition_int

# Reading shapefiles
campus_buildings <- readOGR(dsn = 'C:/Users/jense/Desktop/ENVS 4826 - Data Science in the Environment/FinalProject/CampusMap_Background_SHP', layer = "CampusBuildings")
greenspace <- readOGR(dsn = 'C:/Users/jense/Desktop/ENVS 4826 - Data Science in the Environment/FinalProject/CampusMap_Background_SHP', layer = "Greenspace")
pathways <- readOGR(dsn = 'C:/Users/jense/Desktop/ENVS 4826 - Data Science in the Environment/FinalProject/CampusMap_Background_SHP', layer = "Pathways")
pavement <- readOGR(dsn = 'C:/Users/jense/Desktop/ENVS 4826 - Data Science in the Environment/FinalProject/CampusMap_Background_SHP', layer = "Pavement")
campus_data_fixed <- st_write(campus_data, "campus_data_fixed.shp")

# Fortifying shapefiles to be dataframes
campus_buildings_df <- fortify(campus_buildings)
greenspace_df <- fortify(greenspace)
pathways_df <- fortify(pathways)
pavement_df <- fortify(pavement)

# Plotting Crown Condition Map
ggplot() +
  geom_polygon(data = campus_buildings_df, aes(x = long, y = lat, group = group), colour = "Blue", fill = "Light Blue") +
  geom_polygon(data = pavement_df, aes(x = long, y = lat, group = group), colour = "Black", fill = "Gray") +
  geom_point(data = campus_data, aes(x = UTMX, y = UTMY, col = crown_condition_int), size = 1) +
  scale_colour_manual(values = c('Red', 'Green', 'Black'), labels = c('Fair/Poor', 'Good', 'NA')) +
  labs(title = "Crown Condition of Trees Around SMU Campus", x = "UTMX", y = "UTMY", colour = "Crown Condition") +
  theme_bw()

# Plotting Trunk Damage Map
ggplot() +
  geom_polygon(data = campus_buildings_df, aes(x = long, y = lat, group = group), colour = "Blue", fill = "Light Blue") +
  geom_polygon(data = pavement_df, aes(x = long, y = lat, group = group), colour = "Black", fill = "Gray") +
  geom_point(data = campus_data, aes(x = UTMX, y = UTMY, col = trunk_damage), size = 1) +
  scale_colour_manual(values = c('Green', 'Red', 'Black'), labels = c('Absent', 'Present', 'NA')) +
  labs(title = "Presence of Trunk Damage Trees Around SMU Campus", x = "UTMX", y = "UTMY", colour = "Crown Condition") +
  theme_bw()

campus_data_fixed <- st_read("C:/Users/jense/Desktop/ENVS 4826 - Data Science in the Environment/FinalProject/campus_data_fixed.shp")
st_crs(campus_data_fixed)
st_crs(campus_buildings)
campus_data_fixed <- st_set_crs(campus_data_fixed, 26920)


tree_distances <- min(st_distance(campus_buildings, campus_data_fixed[1, ]))

lm_crown <- lm(crown_condition_int ~ distance_crown, data = )

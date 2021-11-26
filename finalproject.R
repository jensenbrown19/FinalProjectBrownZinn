# Final Project
# Jensen Brown & Cameron Zinn

library(rgdal)
library(ggplot2)
library(readxl)
library(tidyverse)

class_data <- read_xlsx("ENVS 4826 Project Data.xlsx")
tree_data <-  read_xlsx("SMUtreedatabase2021.xlsx")
project_data <- merge(class_data, tree_data, by = "uid_4826")
campus_data <- filter(project_data, location == "SMU campus")

campus_buildings <- readOGR(dsn = 'C:/Users/jense/Desktop/ENVS 4826 - Data Science in the Environment/FinalProject/CampusMap_Background_SHP', layer = "CampusBuildings")
greenspace <- readOGR(dsn = 'C:/Users/jense/Desktop/ENVS 4826 - Data Science in the Environment/FinalProject/CampusMap_Background_SHP', layer = "Greenspace")
pathways <- readOGR(dsn = 'C:/Users/jense/Desktop/ENVS 4826 - Data Science in the Environment/FinalProject/CampusMap_Background_SHP', layer = "Pathways")
pavement <- readOGR(dsn = 'C:/Users/jense/Desktop/ENVS 4826 - Data Science in the Environment/FinalProject/CampusMap_Background_SHP', layer = "Pavement")

campus_buildings_df <- fortify(campus_buildings)
greenspace_df <- fortify(greenspace)
pathways_df <- fortify(pathways)
pavement_df <- fortify(pavement)


ggplot()+
  geom_point(data = project_data, x = project_data$long, y = project_data$lat) +
  geom_polygon(data = campus_buildings_df, x = campus_buildings_df$long, y = campus_buildings_df$lat)

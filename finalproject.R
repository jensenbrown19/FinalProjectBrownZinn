# Final Project
# Jensen Brown & Cameron Zinn

library(rgdal)
library(ggplot2)
library(readxl)
library(tidyverse)

class_data <- read_xlsx("ENVS 4826 Project Data.xlsx")
excel_sheets("ENVS 4826 Project Data.xlsx")
project_data <- excel_sheets("ENVS 4826 Project Data.xlsx") %>% map_df(~read_xlsx("ENVS 4826 Project Data.xlsx", .))


campus_buildings <- readOGR(dsn = 'C:/Users/jense/Desktop/ENVS 4826 - Data Science in the Environment/FinalProject/CampusMap_Background_SHP', layer = "CampusBuildings")
greenspace <- readOGR(dsn = 'C:/Users/jense/Desktop/ENVS 4826 - Data Science in the Environment/FinalProject/CampusMap_Background_SHP', layer = "Greenspace")
pathways <- readOGR(dsn = 'C:/Users/jense/Desktop/ENVS 4826 - Data Science in the Environment/FinalProject/CampusMap_Background_SHP', layer = "Pathways")
pavement <- readOGR(dsn = 'C:/Users/jense/Desktop/ENVS 4826 - Data Science in the Environment/FinalProject/CampusMap_Background_SHP', layer = "Pavement")


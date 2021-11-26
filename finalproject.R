# Final Project
# Jensen Brown & Cameron Zinn

library(rgdal)

tree_data <- read_xlsx("ENVS 4826 Project Data.xlsx")

campus_buildings <- readOGR(dsn = 'C:/Users/jense/Desktop/ENVS 4826 - Data Science in the Environment/FinalProject/CampusMap_Background_SHP', layer = "CampusBuildings")
greenspace <- readOGR(dsn = 'C:/Users/jense/Desktop/ENVS 4826 - Data Science in the Environment/FinalProject/CampusMap_Background_SHP', layer = "Greenspace")
pathways <- readOGR(dsn = 'C:/Users/jense/Desktop/ENVS 4826 - Data Science in the Environment/FinalProject/CampusMap_Background_SHP', layer = "Pathways")
pavement <- readOGR(dsn = 'C:/Users/jense/Desktop/ENVS 4826 - Data Science in the Environment/FinalProject/CampusMap_Background_SHP', layer = "Pavement")

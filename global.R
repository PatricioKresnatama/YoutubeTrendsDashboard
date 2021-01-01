library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(plotly)
library(ggthemes)
library(scales)
library(lubridate)

yt <- read.csv("USvideos.csv")
yt <- yt %>% 
  mutate(category_id = as.character(category_id),
         category_id = sapply(category_id, switch,
                              "1" = "Film and Animation",
                              "2" = "Autos and Vehicles", 
                              "10" = "Music", 
                              "15" = "Pets and Animals", 
                              "17" = "Sports",
                              "19" = "Travel and Events", 
                              "20" = "Gaming", 
                              "22" = "People and Blogs", 
                              "23" = "Comedy",
                              "24" = "Entertainment", 
                              "25" = "News and Politics",
                              "26" = "Howto and Style", 
                              "27" = "Education",
                              "28" = "Science and Technology", 
                              "29" = "Nonprofit and Activism",
                              "43" = "Shows"),
         category_id = as.factor(category_id),
         publish_time = ymd_hms(publish_time, tz = "America/New_York"),
         year_publish = year(publish_time),
         year_publish = as.factor(year_publish),
         like_ratio = likes/views,
         dislike_ratio = dislikes/views,
         comment_ratio = comment_count/views)

yt1 <- yt %>% 
  group_by(channel_title, category_id, year_publish) %>% 
  summarise(total_views = sum(views))

yt2 <- yt %>% 
  group_by(category_id, year_publish) %>% 
  summarise(total_views = sum(views), 
            mean_like_ratio = mean(like_ratio), 
            mean_dislike_ratio = mean(dislike_ratio),
            mean_comment_ratio = mean(comment_ratio))

source("ui.R")
source("server.R")

shinyApp(ui = ui,server = server)
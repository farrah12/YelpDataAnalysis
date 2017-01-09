library(tidyverse)
library(readxl)

business.data.raw <- readRDS("yelp_data/yelp_academic_dataset_business.rds") 
review.data.raw <- readRDS("yelp_data/yelp_academic_dataset_review.rds")
user.data.raw <- readRDS("yelp_data/yelp_academic_dataset_user.rds") 

# Remove some problem fields to make them able to join
business.data <- business.data.raw %>% 
  select(business_id, full_address,open, categories,city, review_count, name, longitude, state, stars, latitude, type)
user.data <- user.data.raw %>%
  select(yelping_since, review_count,name,user_id,friends,fans,average_stars,type,elite)
review.data <- review.data.raw

# Focus on Chinese restaurants(#943)
business.category <- list(c("Chinese","Restaurants"))   
business.chinese.restaurants <- business.data %>%  
  filter (categories %in% business.category)

# Only focus on the hottest city - Las Vegas
# total 155 Chinese restaurants
business.chinese.restaurants.las_vegas <- business.chinese.restaurants %>%
  group_by(city) %>%
  summarise(number.restaurants = n()) %>%
  arrange(desc(number.restaurants)) %>%
  slice(1:1) %>%
  select(city) %>%
  left_join(business.chinese.restaurants)
# Total 8744 reviews
review.chinese.restaurants.las_vegas <- business.chinese.restaurants.las_vegas %>%
  select (business_id, city) %>%
  left_join(review.data)
# Total 7120 users who wrote down those reviews
user.chinese.restaurants.las_vegas <- review.chinese.restaurants.las_vegas %>%
  group_by(user_id) %>%
  summarise(number.restaurants = n()) %>%
  select (user_id) %>% 
  left_join(user.data) 

saveRDS(business.chinese.restaurants.las_vegas,file='yelp_data/business_LasVegas_Chinese_Restaurants.rds') 
saveRDS(review.chinese.restaurants.las_vegas,file='yelp_data/review_LasVegas_Chinese_Restaurants.rds')
saveRDS(user.chinese.restaurants.las_vegas,file='yelp_data/user_LasVegas_Chinese_Restaurants.rds')







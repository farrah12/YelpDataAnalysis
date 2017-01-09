library(jsonlite)
business.data <- stream_in(gzfile("yelp_data/yelp_academic_dataset_business.json"))
saveRDS(business.data,file='yelp_data/yelp_academic_dataset_business.rds')
review.data <- stream_in(gzfile("yelp_data/yelp_academic_dataset_review.json"))
saveRDS(review.data,file='yelp_data/yelp_academic_dataset_review.rds')
user.data <- stream_in(gzfile("yelp_data/yelp_academic_dataset_user.json"))
saveRDS(user.data,file='yelp_data/yelp_academic_dataset_user.rds') 


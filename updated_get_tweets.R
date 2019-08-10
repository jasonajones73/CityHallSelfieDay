## Purpose: Get #CityHallSelfie Day Tweets
## Author: Jason Jones
## Date: 2019-08-09

# Packages ----
library(tidyverse)
library(rtweet)

# Search Tweets ----
tweets <- search_tweets(q = "#CityHallSelfie",
                        include_rts = FALSE,
                        n = 18000,
                        type = "mixed",
                        retryonratelimit = TRUE)

# Create status url and clean up ----
clean_tweets <- tweets %>% 
  mutate(status_url = paste0("https://twitter.com/", screen_name, "/status/", status_id)) %>%
  select(status_url, screen_name, created_at, favorite_count, retweet_count) %>%
  mutate(dataset_id = "1")

# Write data ----
clean_tweets %>%
  write_tsv(file.path("data", "tweets.tsv"))

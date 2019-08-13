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
                        retryonratelimit = TRUE,
                        verbose = TRUE)

# Read in existing tweets ----
tweets_existing <- read_tsv(file.path("data", "tweets_master.tsv"), 
                            col_types = cols(status_id = col_character()))

# Remove tweets we have already captured ----
new_tweets <- tweets %>%
  filter(!status_id %in% tweets_existing$status_id)

# Create status url and clean up ----
clean_tweets <- new_tweets %>% 
  mutate(status_url = paste0("https://twitter.com/", screen_name, "/status/", status_id)) %>%
  select(status_url, screen_name, created_at, favorite_count, retweet_count, status_id, )

# Append new data ----
clean_tweets %>%
  write_tsv(file.path("data", "tweets_master.tsv"), append = TRUE)

# Extract photo endpoints ----
photos <- tweets %>%
  unnest(ext_media_url) %>%
  mutate(file_name = paste0(status_id, ".png")) %>%
  filter(is.na(ext_media_url) != TRUE) %>%
  mutate(file_type = str_sub(ext_media_url, start = -3, end = -1))

# Loop through photos and download
for (i in seq_along(photos$file_name)) {
  download.file(url = photos$ext_media_url[i],
                destfile = here::here(paste0("photos/", photos$status_id[i],
                                             i, ".", photos$file_type[i])))
}

















#library(annotinder)
library(tidyverse)

## ad hoc fix for broken tweet ids in the 'old' data, where tweet ids are read as numeric
df_old <- read.csv("../data/X_data/final_stratified_immigration.csv")
df <- read.csv("../data/X_data/final_stratified_immigration.csv", colClasses=c('tweet_id'='character'))

## confirms that coercing to numeric breaks it 'in the same way'
mean(df_old$tweet_id == as.numeric(df$tweet_id))

## create joining table
id_matcher = data.frame(tweet_id_character = df$tweet_id, tweet_id_numeric = as.numeric(df$tweet_id))
mean(id_matcher$tweet_id_character == df$tweet_id)
mean(id_matcher$tweet_id_numeric == df_old$tweet_id)
write.csv(id_matcher, "data/id_matcher.csv", row.names = FALSE)


df$id <- as.character(df$tweet_id)
# Print the data frame
# Combine author and twitter_handle columns with Markdown formatting for author name
df$author_with_handle <- paste0("**", df$Name, "** (@", df$twitter_username, ")")
# Create the new column with party name bolded using Markdown
df$review_message <- paste0(
  "Beoordeel het volgende social media bericht afkomstig van **", 
  df$normalized_party, "** lid ", df$author_with_handle , ":"
)

mean(df$id == df$tweet_id)


units_condition_1_2_3 <- create_units(df,
  set_text("text", text, align = "left", text_size = 1.5, bold = TRUE, underline = TRUE),
  id = "id"
)

units_condition_4_5_6 <- create_units(df,
  set_markdown("review_message", review_message, align="left", text_size = 1),                 
  set_text("text", text, align = "left", text_size = 1.5, bold = TRUE, underline = TRUE),
  id = "id",
  set_markdown("author_with_handle", author_with_handle, align = "left", text_size = 1.2)
)

unit_ids = df$id



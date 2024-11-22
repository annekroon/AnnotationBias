df <- read.csv("data/final_stratified_immigration.csv")

df$id <- as.character(df$tweet_id)
# Print the data frame
# Combine author and twitter_handle columns with Markdown formatting for author name
df$author_with_handle <- paste0("**", df$Name, "** (@", df$twitter_username, ")")
# Create the new column with party name bolded using Markdown
df$review_message <- paste0(
  "Beoordeel het volgende social media bericht afkomstig van **", 
  df$normalized_party, "** lid ", df$author_with_handle , ":"
)

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



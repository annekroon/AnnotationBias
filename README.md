# AnnotationBias

Understanding and Overcoming Implicit Annotation Bias in Crowd-sourced Datasets

`00_get-Xaccounts-MPs.ipynb`
This script scrapes data about members of the Dutch **Tweede Kamer** (House of Representatives) from 2012–2024, combines it into a dataset, and extracts their unique Twitter usernames.

## Outputs

- `data/X_data/tweedekamerleden.csv`: Full dataset of Tweede Kamer members (2012–2024).
- `data/X_data/MPs_twitter_usernames.txt`: List of unique Twitter usernames.

`01_get_twitter_data.ipynb`
This script gets the tweets of the members of parliament, based on the `data/X_data/MPs_twitter_usernames.txt` file. For this, Twi-XL is used. 

## Outputs

-   `data/X_data/full_twitter_data.csv`
-   `data/X_data/immigratie_tweets_non_stratefied.csv`
-   `data/X_data/final_stratified_immigration.csv`

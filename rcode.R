## LOAD PACKAGES##

library(rtweet)
library(dplyr)
library(tidytext)
library(widyr)

## store api keys (these are fake example values; replace with your own keys)
api_key <-
api_secret_key <-
access_token <- 
access_token_secret <-

## authenticate via web browser
token <- create_token(
  app = "",
  consumer_key = api_key,
  consumer_secret = api_secret_key,
  access_token = access_token,
  access_secret = access_token_secret)



### SEARCHING TWEETS ###

#q#

Elecciones = c("#JornadaDeReflexión","#10N")

tweets_elecciones = search_tweets2(q = Elecciones, n = 18000, type = "mixed")



### CLEANING ###

tweets_elecciones_time$stripped_text = gsub("http.*","",  tweets_elecciones_time$text)

#words#
tweets_clean = tweets_elecciones %>%
  dplyr::select(stripped_text) %>%
  unnest_tokens(word, stripped_text)


tweets_cleanned  = tweets_clean %>%
  anti_join(stopwordslangs)



### TOP 500 WORDS RELATED TO THE HASTAGS ###
TopWords = tweets_cleanned %>%
  count(word,sort = TRUE) %>%
  top_n(500)


### MANUAL CLEANING ###

TopWords_cleanned = TopWords %>% slice(5,6...)
### PLOTTING ###

library(wordcloud2)
library(ggplot2)

wordcloud2(TopWords_cleanned, fontFamily = "sans",backgroundColor = "ghostwhite" )
  
  
ggplot(TopWords_cleanned, aes(x = reorder(word, n), y =n)) +
  geom_bar(stat = "identity", width  = 0.2) +
  coord_flip()

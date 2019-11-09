## LOAD PACKAGES##

library(rtweet)
library(dplyr)
library(tidytext)
library(widyr)

## store api keys (these are fake example values; replace with your own keys)
api_key <-"DPO4LLEC3pvMsOipc2h2kSWlY "
api_secret_key <-"Q6iqJ6pteGCzW38uV1MTmShZqZIhRjb9emJjDTugkiPo64hcbq"
access_token <- "453384161-BxCJjFD72LjXjJs6chfT4CffaNc2ioFpNApjePNn"
access_token_secret <-"deYRE548BQC0xsqt0LH36D4AE7PcRod4wemvxkSbN8g8Y"

## authenticate via web browser
token <- create_token(
  app = "debate_07/11/2019",
  consumer_key = api_key,
  consumer_secret = api_secret_key,
  access_token = access_token,
  access_secret = access_token_secret)



### SEARCHING TWEETS ###

#q#

Elecciones = c("#JornadaDeReflexión",#10N)

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

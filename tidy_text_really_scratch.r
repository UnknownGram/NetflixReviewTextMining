install.packages("tidytext")
library("tidytext")
library("tidyverse");theme_set(theme_bw())


text <- c("Because I could not stop for Death -",
          "He kindly stopped for me -",
          "The Carriage held but just Ourselves -",
          "and Immortality")

text


text_df <- tibble(line = 1:4, text = text)

text_df


library(tidytext)

new_df <- text_df %>%
    unnest_tokens(word, text)

new_df |> 
    count(word)

library(janeaustenr)
library(dplyr)
library(stringr)

original_books <- austen_books() %>%
    group_by(book) %>%
    mutate(linenumber = row_number(),
           chapter = cumsum(str_detect(text, 
                                       regex("^chapter [\\divxlc]",
                                             ignore_case = TRUE)))) %>%
    ungroup()

original_books

tidy_books <- original_books %>%
    unnest_tokens(word, text)

tidy_books |> 
    count(word) |> 
    arrange(desc(n))


data(stop_words)

tidy_books <- tidy_books %>%
    anti_join(stop_words)


tidy_books |> 
    count(word) |> 
    arrange(desc(n))


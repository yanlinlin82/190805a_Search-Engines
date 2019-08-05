library(tidyverse)

a <- read_tsv("data.txt", col_types = cols())

if (!file.exists("plot.png")) {
  g <- a %>%
    arrange(desc(count)) %>%
    mutate(rank = row_number(),
           text = count %>%
             formatC(digits = 20, big.mark = ",") %>%
             gsub(" ", "", .)) %>%
    ggplot(aes(x = engine, y = query, fill = rank)) +
    geom_tile() +
    geom_text(aes(label = text)) +
    scale_fill_gradient(low = "red", high = "white") +
    guides(fill = FALSE) +
    labs(x = "Search Engine", y = "Query Keyword") +
    ggtitle("How many records can be found between search engines?")
  g %>% ggsave(filename = "plot.png", width = 8, height = 7)
}

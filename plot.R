library(tidyverse)

a <- read_tsv("data.txt", col_types = cols())

if (!file.exists("plot.png")) {
  g <- a %>%
    mutate(value = order(count)) %>%
    ggplot(aes(x = engine, y = query, fill = value)) +
    geom_tile() +
    geom_text(aes(label = gsub(" ", "", formatC(count, digits = 20, big.mark = ","))), hjust = .5) +
    scale_fill_gradient(low = "white", high = "red") +
    guides(fill = FALSE) +
    labs(x = "Search Engine", y = "Query Keyword") +
    ggtitle("How many records can be found between search engines?")
  g %>% ggsave(filename = "plot.png", width = 8, height = 7)
}

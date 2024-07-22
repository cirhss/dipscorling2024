library(tidyverse)

lexverbfiles <- dir("results", pattern = "lex", full.names = TRUE)
lexverbfiles

(editorial_ame <- read_csv(str_subset(lexverbfiles, "editorial-american"), skip = 2) |> mutate(variety = "AmE", genre = "editorial"))
(reportage_ame <- read_csv(str_subset(lexverbfiles, "reportage-american"), skip = 2) |> mutate(variety = "AmE", genre = "reportage"))
(editorial_bre <- read_csv(str_subset(lexverbfiles, "editorial-british"), skip = 2) |> mutate(variety = "BrE", genre = "editorial"))
(reportage_bre <- read_csv(str_subset(lexverbfiles, "reportage-british"), skip = 2) |> mutate(variety = "BrE", genre = "reportage"))

lxv <- bind_rows(editorial_ame, editorial_bre, reportage_ame, reportage_bre)
lxv

lxv |> 
  filter(Frequency > 1000) |> 
  filter(Item %in% c("VVI", "VVN", "VVG", "VVD", "VVO", "VVZ")) |> 
  ggplot(aes(x = genre, y = `Relative frequency`, fill = Item)) +
  geom_bar(stat = "identity", position = "dodge")

# Get the Data

# Read in with tidytuesdayR package
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-01-25')
tuesdata <- tidytuesdayR::tt_load(2022, week = 4)

ratings <- tuesdata$ratings
details <- tuesdata$details

caption_title <- '#TidyTuesday 4 of 2022 | Source: Kaggle-Board Games Geek | Author: Paula LC (@elartedeldato)'


ratings %>%
  inner_join(details, by='id') -> df_full

df_full %>%
  mutate(category:=lapply(lapply(str_split(boardgamecategory, ','), str_trim), str_replace_all, '[[:punct:]]', '')) %>%
  unnest(category) %>%
  mutate(mechanic:=lapply(lapply(str_split(boardgamemechanic, ','), str_trim), str_replace_all, '[[:punct:]]', '')) %>%
  unnest(mechanic) -> df_full_unnested

details %>%
  mutate(category:=lapply(lapply(str_split(boardgamecategory, ','), str_trim), str_replace_all, '[[:punct:]]', '')) %>%
  unnest(category) -> df_category

df_category %>%
  count(category) %>%
  arrange(desc(n)) %>%
  top_n(19) %>%
  pull(category) -> top_categories

details %>%
  mutate(mechanic:=lapply(lapply(str_split(boardgamemechanic, ','), str_trim), str_replace_all, '[[:punct:]]', '')) %>%
  unnest(mechanic) -> df_mechanic

df_mechanic %>%
  count(mechanic) %>%
  arrange(desc(n)) %>%
  filter(!is.na(mechanic)) %>%
  top_n(19) %>%
  pull(mechanic) -> top_mechanics


df_full_unnested %>%
  filter(category %in% top_categories, mechanic %in% top_mechanics) %>%
  group_by(category, mechanic) %>%
  summarise(avg_rating := mean(average)) %>%
  mutate(global_mean:=mean(avg_rating)) %>%
  mutate(rating_level:=ifelse(avg_rating>=global_mean,'over', 'under')) %>%
  ggplot() +
    geom_point(aes(category, reorder(mechanic, avg_rating), color=rating_level), size=5) +
    scale_color_manual(values=c('black','white')) +
  labs(title='Let\'s Go & Play',
       subtitle='The best combinations of board game categories and mechanics.
       In black, combinations over the global mean rating (6.41).
       In white, under it.',
       caption=caption_title,
       x='', y='') +
  coord_equal() +
  theme_bw() +
  theme(text=element_text(family='Cinzel', color='#e5e5e5'),
        panel.grid=element_line(color='black', size=0.5),
        panel.background=element_rect(fill='#b58225', color='#b58225'),
        plot.background=element_rect(fill='#1c1c1c', color='#1c1c1c'),
        legend.position = 'none',
        plot.margin=margin(1,2,1,0,'cm'),
        plot.title=element_text(size=40, hjust=0.5),
        plot.subtitle=element_text(size=8, hjust=0.5, color='#adb5bd'),
        plot.caption = element_text(size=5, hjust=0.5, color='#adb5bd'),
        axis.title.x = element_text(hjust=1),
        axis.text.x = element_text(angle=45, hjust=1),
        axis.title.y = element_text(angle = 0),
        axis.text=element_text(color='#adb5bd', size=8))

ggsave('Plots/2022_4_Board_Games.png', height = 8, width=8)


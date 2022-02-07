# Get the Data

# Read in with tidytuesdayR package
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

library(tidyverse)
library(ggforce)
library(patchwork)
library(ggtext)
library(showtext)
library(rcartocolor)
font_add_google(name = "Amatic SC", family = "amatic-sc")
showtext_auto()
font_family <- 'amatic-sc'

breed_traits <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-02-01/breed_traits.csv')
trait_description <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-02-01/trait_description.csv')
breed_rank_all <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-02-01/breed_rank.csv')

# Not working!!!
# top_dogs <- breed_rank_all %>%
#  filter(`2020 Rank` <= 10) %>%
#  pull(Breed)

traits <- trait_description$Trait[c(1,4, 10, 11, 13)]

breed_traits[1:10,] %>%
  #filter(Breed %in% top_dogs) %>%
  select(Breed, traits) -> df

colors <- carto_pal(5, 'BurgYl')
bg_color <- '#f7ede2'
text_color <- '#111111'
font_size <- 14

caption_title <- '#TidyTuesday 5 of 2022 | Source: American Kennel Club | Author: Paula LC (@elartedeldato)'

ggplot() +
  # Footprints row 1
  geom_ellipse(aes(x0 = 0, y0 = 33, a = 3, b = 5, angle = 0.5, m1 = 2), fill = colors[pull(df[1,],2)], color=bg_color) +
  geom_ellipse(aes(x0 = 6, y0 = 40, a = 3.5, b = 5, angle = 0, m1 = 2), fill = colors[pull(df[1,],3)], color=bg_color) +
  geom_ellipse(aes(x0 = 14, y0 = 40, a = 3.5, b = 5, angle = 0, m1 = 2), fill = colors[pull(df[1,],4)], color=bg_color)  +
  geom_ellipse(aes(x0 = 21, y0 = 33, a = 3, b = 5, angle = 2.5, m1 = 2), fill = colors[pull(df[1,],5)], color=bg_color) +
  geom_ellipse(aes(x0 = 10, y0 = 26, a = 7, b = 7, angle = 3, m1 = 2), fill = colors[pull(df[1,],6)], color=bg_color) +
  annotate(geom='text', label=df$Breed[1], x=10, y=16, color=text_color, family=font_family, size=font_size) +

  geom_ellipse(aes(x0 = 0+40, y0 = 33, a = 3, b = 5, angle = 0.5, m1 = 2), fill = colors[pull(df[2,],2)], color=bg_color) +
  geom_ellipse(aes(x0 = 6+40, y0 = 40, a = 3.5, b = 5, angle = 0, m1 = 2), fill = colors[pull(df[2,],3)], color=bg_color) +
  geom_ellipse(aes(x0 = 14+40, y0 = 40, a = 3.5, b = 5, angle = 0, m1 = 2), fill = colors[pull(df[2,],4)], color=bg_color)  +
  geom_ellipse(aes(x0 = 21+40, y0 = 33, a = 3, b = 5, angle = 2.5, m1 = 2), fill = colors[pull(df[2,],5)], color=bg_color) +
  geom_ellipse(aes(x0 = 10+40, y0 = 26, a = 7, b = 7, angle = 3, m1 = 2), fill = colors[pull(df[2,],6)], color=bg_color) +
  annotate(geom='text', label=df$Breed[2], x=10+40, y=16, color=text_color, family=font_family, size=font_size)  +

  geom_ellipse(aes(x0 = 0+80, y0 = 33, a = 3, b = 5, angle = 0.5, m1 = 2), fill = colors[pull(df[3,],2)], color=bg_color) +
  geom_ellipse(aes(x0 = 6+80, y0 = 40, a = 3.5, b = 5, angle = 0, m1 = 2), fill = colors[pull(df[3,],3)], color=bg_color) +
  geom_ellipse(aes(x0 = 14+80, y0 = 40, a = 3.5, b = 5, angle = 0, m1 = 2), fill = colors[pull(df[3,],4)], color=bg_color)  +
  geom_ellipse(aes(x0 = 21+80, y0 = 33, a = 3, b = 5, angle = 2.5, m1 = 2), fill = colors[pull(df[3,],5)], color=bg_color) +
  geom_ellipse(aes(x0 = 10+80, y0 = 26, a = 7, b = 7, angle = 3, m1 = 2), fill = colors[pull(df[3,],6)], color=bg_color) +
  annotate(geom='text', label=df$Breed[3], x=10+80, y=16, color=text_color, family=font_family, size=font_size)  +

  geom_ellipse(aes(x0 = 0+120, y0 = 33, a = 3, b = 5, angle = 0.5, m1 = 2), fill = colors[pull(df[4,],2)], color=bg_color) +
  geom_ellipse(aes(x0 = 6+120, y0 = 40, a = 3.5, b = 5, angle = 0, m1 = 2), fill = colors[pull(df[4,],3)], color=bg_color) +
  geom_ellipse(aes(x0 = 14+120, y0 = 40, a = 3.5, b = 5, angle = 0, m1 = 2), fill = colors[pull(df[4,],4)], color=bg_color)  +
  geom_ellipse(aes(x0 = 21+120, y0 = 33, a = 3, b = 5, angle = 2.5, m1 = 2), fill = colors[pull(df[4,],5)], color=bg_color) +
  geom_ellipse(aes(x0 = 10+120, y0 = 26, a = 7, b = 7, angle = 3, m1 = 2), fill = colors[pull(df[4,],6)], color=bg_color) +
  annotate(geom='text', label=df$Breed[4], x=10+120, y=16, color=text_color, family=font_family, size=font_size)  +

  # Footprints Row 2
  geom_ellipse(aes(x0 = 0, y0 = 0, a = 3, b = 5, angle = 0.5, m1 = 2), fill = colors[pull(df[5,],2)], color=bg_color) +
  geom_ellipse(aes(x0 = 6, y0 = 7, a = 3.5, b = 5, angle = 0, m1 = 2), fill = colors[pull(df[5,],3)], color=bg_color) +
  geom_ellipse(aes(x0 = 14, y0 = 7, a = 3.5, b = 5, angle = 0, m1 = 2), fill = colors[pull(df[5,],4)], color=bg_color)  +
  geom_ellipse(aes(x0 = 21, y0 = 0, a = 3, b = 5, angle = 2.5, m1 = 2), fill = colors[pull(df[5,],5)], color=bg_color) +
  geom_ellipse(aes(x0 = 10, y0 = -7, a = 7, b = 7, angle = 3, m1 = 2), fill = colors[pull(df[5,],6)], color=bg_color) +
  annotate(geom='text', label=df$Breed[5], x=10, y=-17, color=text_color, family=font_family, size=font_size)  +

  geom_ellipse(aes(x0 = 0+40, y0 = 0, a = 3, b = 5, angle = 0.5, m1 = 2), fill = colors[pull(df[6,],2)], color=bg_color) +
  geom_ellipse(aes(x0 = 6+40, y0 = 7, a = 3.5, b = 5, angle = 0, m1 = 2), fill = colors[pull(df[6,],3)], color=bg_color) +
  geom_ellipse(aes(x0 = 14+40, y0 = 7, a = 3.5, b = 5, angle = 0, m1 = 2), fill = colors[pull(df[6,],4)], color=bg_color)  +
  geom_ellipse(aes(x0 = 21+40, y0 = 0, a = 3, b = 5, angle = 2.5, m1 = 2), fill = colors[pull(df[6,],5)], color=bg_color) +
  geom_ellipse(aes(x0 = 10+40, y0 = -7, a = 7, b = 7, angle = 3, m1 = 2), fill = colors[pull(df[6,],6)], color=bg_color) +
  annotate(geom='text', label=df$Breed[6], x=10+40, y=-17, color=text_color, family=font_family, size=font_size)  +

  geom_ellipse(aes(x0 = 0+80, y0 = 0, a = 3, b = 5, angle = 0.5, m1 = 2), fill = colors[pull(df[7,],2)], color=bg_color) +
  geom_ellipse(aes(x0 = 6+80, y0 = 7, a = 3.5, b = 5, angle = 0, m1 = 2), fill = colors[pull(df[7,],3)], color=bg_color) +
  geom_ellipse(aes(x0 = 14+80, y0 = 7, a = 3.5, b = 5, angle = 0, m1 = 2), fill = colors[pull(df[7,],4)], color=bg_color)  +
  geom_ellipse(aes(x0 = 21+80, y0 = 0, a = 3, b = 5, angle = 2.5, m1 = 2), fill = colors[pull(df[7,],5)], color=bg_color) +
  geom_ellipse(aes(x0 = 10+80, y0 = -7, a = 7, b = 7, angle = 3, m1 = 2), fill = colors[pull(df[7,],6)], color=bg_color) +
  annotate(geom='text', label=df$Breed[7], x=10+80, y=-17, color=text_color, family=font_family, size=font_size)  +

  geom_ellipse(aes(x0 = 0+120, y0 = 0, a = 3, b = 5, angle = 0.5, m1 = 2), fill = colors[pull(df[8,],2)], color=bg_color) +
  geom_ellipse(aes(x0 = 6+120, y0 = 7, a = 3.5, b = 5, angle = 0, m1 = 2), fill = colors[pull(df[8,],3)], color=bg_color) +
  geom_ellipse(aes(x0 = 14+120, y0 = 7, a = 3.5, b = 5, angle = 0, m1 = 2), fill = colors[pull(df[8,],4)], color=bg_color)  +
  geom_ellipse(aes(x0 = 21+120, y0 = 0, a = 3, b = 5, angle = 2.5, m1 = 2), fill = colors[pull(df[8,],5)], color=bg_color) +
  geom_ellipse(aes(x0 = 10+120, y0 = -7, a = 7, b = 7, angle = 3, m1 = 2), fill = colors[pull(df[8,],6)], color=bg_color) +
  annotate(geom='text', label=df$Breed[8], x=10+120, y=-17, color=text_color, family=font_family, size=font_size) +

  # Legend Footprint
  geom_ellipse(aes(x0 = 2+120, y0 = 73, a = 2, b = 4, angle = 0.5, m1 = 2), fill = '#84a59d', color= '#84a59d') +
  annotate(geom='text', label="Affective", x=2+120, y=70, size=12, hjust=1.2, family=font_family, color= '#84a59d') +
  geom_ellipse(aes(x0 = 6+120, y0 = 80, a = 2.5, b = 4, angle = 0, m1 = 2), fill = '#84a59d', color= '#84a59d') +
  annotate(geom='text', label="Hair Shedding", x=6+120, y=80, size=12, hjust=1.3, family=font_family, color= '#84a59d') +
  geom_ellipse(aes(x0 = 14+120, y0 = 80, a = 2.5, b = 4, angle = 0, m1 = 2), fill = '#84a59d', color= '#84a59d')  +
  annotate(geom='text', label="Playfulness", x=14+120, y=80, size=12, hjust=-0.3, family=font_family, color= '#84a59d') +
  geom_ellipse(aes(x0 = 19+120, y0 = 73, a =2, b = 4, angle = 2.5, m1 = 2), fill = '#84a59d', color= '#84a59d') +
  annotate(geom='text', label="Protectiveness", x=19+120, y=70, size=12,  hjust=-0.1, family=font_family, color= '#84a59d') +
  geom_ellipse(aes(x0 = 10+120, y0 = 69, a = 5, b = 5, angle = 3, m1 = 2), fill = '#84a59d', color= '#84a59d') +
  annotate(geom='text', label="Trainability", x=10+120, y=70, size=12, vjust=3, family=font_family, color= '#84a59d') +
  coord_equal() +
  theme_void() +
  annotate(geom='text', label='Dog Breed Profiles', x=-10, y=80, size=50, hjust=0, family=font_family, color=text_color) +
  annotate(geom='text', label='The graph shows main dog traits for the top 8 dog breeds.',size=15, x=-10, y=65, hjust=0, family=font_family, color=text_color) +
  annotate(geom='text', label='Intesity of the color means higher score of this characteristic.', size=15, x=-10, y=60, hjust=0, family=font_family, color=text_color) +
  labs(caption=caption_title) +
  theme(plot.background = element_rect(fill=bg_color, color=bg_color),
        plot.margin=margin(1,1,1,1,'cm'),
        plot.caption=element_text(family=font_family, size=20, margin=margin(10,1,1,1)))

ggsave('Plots/2022_5_Breeds.png', height=6, width=7)


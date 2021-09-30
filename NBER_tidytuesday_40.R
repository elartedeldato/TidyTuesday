library(tidyverse)
library(rcartocolor)
library(showtext)
library(ggtext)
showtext_auto()
font_add_google('Lato', regular.wt = 300)
font_add_google('Bebas Neue')
font_family_title <- 'Bebas Neue'
font_family <- 'Lato'
papers <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-28/papers.csv')
programs <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-28/programs.csv')
paper_programs <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-28/paper_programs.csv')

df <- papers %>%
  left_join(paper_programs, by='paper') %>%
  left_join(programs, by='program') %>%
  filter(!is.na(program), year >= 2000)

df %>% 
  count(year, month, program_desc) %>%
  mutate(month=lubridate::month(month,label=T),
         program_desc=purrr::pmap_chr(list(program_desc), function(x) paste(strwrap(x, width=30), collapse=" \n"))) -> df_plot

df_plot %>%
  group_by(program_desc) %>% 
  summarise(n_total:=sum(n)) %>%
  arrange(-n_total) %>%
  pull(program_desc) -> program_desc_levels

df_plot %>%
  mutate(program_desc=factor(program_desc, levels=program_desc_levels)) -> df_plot

ggplot(df_plot) +
  geom_tile(aes(month, year, fill=n)) +
  coord_polar() +
  facet_wrap(~program_desc, ncol = 6) +
  scale_fill_carto_c(palette = "Burg", guide = "bins") +
  scale_y_continuous(breaks=c(2000, 2021)) +
  guides(fill = guide_legend(direction = "horizontal")) +
  theme_minimal() +
  theme(text=element_text(color='black',
                          family=font_family),
        strip.text = element_text(family=font_family_title),
        panel.grid = element_blank(),
        axis.title = element_blank(),
        axis.text = element_text(size=7),
        legend.position = c(0.9, 1.1),
        legend.key.height = unit(0.35, 'pt'),
        legend.title = element_text(size=7),
        legend.text = element_text(size=7),
        panel.spacing = unit(1, 'pt'),
        plot.title = element_text(size=20, family=font_family_title),
        plot.subtitle = element_text(size=8),
        plot.caption = element_text(size=7, hjust=0.5)) +
  labs(title="NBER Working Papers",
       subtitle= 'Monthly evolution of the total of NBER working papers classified by program.',
       caption = "Paula L. Casado (@elartedeldato) | Data: National Bureau of Economic Research | #TidyTuesday | Week 40") -> p

ggsave('plot.png', p, width = 10, height = 7.5)


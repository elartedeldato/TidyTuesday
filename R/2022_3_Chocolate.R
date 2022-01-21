# Get the Data

# Read in with tidytuesdayR package
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

library(tidyverse)
library(waffle)
library(ggtext)

tuesdata <- tidytuesdayR::tt_load('2022-01-18')
tuesdata <- tidytuesdayR::tt_load(2022, week = 3)

chocolate <- tuesdata$chocolate

chocolate$pct_group <- cut(as.numeric(str_replace(chocolate$cocoa_percent, '%', '')), c(0, 50, 75, 90, 100))

colfunc <- colorRampPalette(c("#f9c37a", "#4c281a"))
choco_colors <- colfunc(4)

countries <- c('Canada', 'France',  'Spain', 'Belgium', 'Venezuela',  'Colombia')

chocolate %>%
  count(company_location, pct_group) %>%
  filter(company_location %in% countries) %>%
  ggplot(aes(values=n, fill=pct_group)) +
  geom_waffle(n_rows = 6, flip = T, make_proportional = F, color='#351d13', size=0.1, radius = unit(0.07, 'cm')) +
  facet_wrap(~factor(company_location, levels=countries), nrow = 1, strip.position = 'bottom') +
  theme_void() +
  labs(title='% Cocoa in choco bars',
       subtitle='<span style="color:#F9C37A">less than 50%, </span>
       <span style="color: #BF8F5A">50%-75%,</span>
       <span style="color: #855B3A">75%-90%,</span>
       <span style="color: #4C281A">more than 90%.</span><br><br>1 square = 1 choco bar',
       caption='#TidyTuesday 3 of 2022 | Source: Flavorsofcacao.com | Author: Paula LC (@elartedeldato)') +
  scale_fill_manual(values=choco_colors) +
  theme(text=element_text(family='Bebas Neue', color=choco_colors[3]),
        strip.text = element_text(size=20),
        strip.switch.pad.wrap = unit(50, 'cm'),
        plot.background=element_rect(fill='#351d13'),
        plot.margin=margin(2,2,2,2,'cm'),
        plot.title=element_text(size=65, hjust=0.5),
        plot.subtitle=element_markdown(family='Bebas Neue', size=14, margin=margin(15,0,15,0),  hjust=0.5),
        plot.caption=element_text(margin=margin(40,0,0,0),  hjust=0.5),
        legend.position='none')

ggsave('Plots/2022_3_Chocolate.png', width=8, height=7)

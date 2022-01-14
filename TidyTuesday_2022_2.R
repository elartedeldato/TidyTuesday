# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

library(tidyverse)
library(sysfonts)

tuesdata <- tidytuesdayR::tt_load('2022-01-11')
tuesdata <- tidytuesdayR::tt_load(2022, week = 2)

colony <- tuesdata$colony

font_add_google('Twinkle Star')
font_family <- 'Twinkle Star'

colony %>%
  filter(state != 'United States') -> df

ggplot(df, aes(x=colony_reno_pct, y=colony_lost_pct, label=paste(state,'\n',year))) + 
  geom_hex(size=0.2, color='white') +
  # Arrange axis
  scale_x_continuous(limits=c(-2,80), labels=function(x)paste(x, '%')) +
  scale_y_continuous(limits=c(0,80), labels=function(x)paste(x, '%')) +
  coord_equal(ratio=80/80) +
  # Add labels
  geom_text(data=subset(df, colony_lost_pct > 40 | colony_reno_pct > 60), size=2, family='Twinkle Star') +
  # Change colors
  scale_fill_stepsn(colors=c('#FFCE45', '#D4AC2B', '#B05E27', '#7E370C')) +
  # Change theme
  theme_minimal() +
  # Titles
  annotate('text', x=50, y=80, hjust=0.5, label='Bye Bye, Bee', family=font_family, size=15) +
  annotate('text', x=50, y=65, hjust=0.5, label='Density of Colony Renovation Vs Colony Lost\nsince 2015 to 2021 in the different \nyear seasons and states of US.', family=font_family, size=4) +
  # Caption
  labs(caption='#TidyTuesday 2 of 2022 | Source: USDA | Author: Paula LC (@elartedeldato)',
       x='Colony Renovation %', y='Colony Lost %') +
  # Modify theme
  theme(text=element_text(family=font_family),
        plot.caption=element_text(family=font_family, hjust=0.5, margin=margin(25,0,0,0)),
        plot.background = element_rect(fill='#ffe9ab', color='#ffe9ab'),
        plot.margin = margin(2,2,2,2,'cm'),
        legend.position = 'none',
        panel.grid = element_blank())

ggsave('TidyTuesday_2.png',width=8, height=8)

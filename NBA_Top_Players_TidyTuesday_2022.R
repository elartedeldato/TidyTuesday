library(ggplot2)
library(dplyr)
library(ggrepel)

df <- read.csv('gamelog_NBA.csv')

df %>% 
  filter(yearSeason==2022) -> df_2022

ggplot(df_2022) + 
  geom_point(aes(as.Date(dateGame), pts), alpha=0.1, color='#80FFDB') +
  geom_text_repel(data=subset(df_2022, pts>=45), aes(as.Date(dateGame), pts, label=namePlayer), color='#80FFDB', family='Bebas Neue', size=3, box.padding = 0.4) +
  geom_line(data=subset(df_2022, namePlayer=='Kevin Durant'), aes(as.Date(dateGame), pts), color='#80FFDB', size=0.5) +
  geom_line(data=subset(df_2022, namePlayer=='Giannis Antetokounmpo'), aes(as.Date(dateGame), pts), color='#80FFDB', size=0.1) +
  scale_x_date(date_breaks = '10 days', date_labels = '%b %d') +
  scale_y_continuous(n.breaks=10) +
  theme_minimal() +
  theme(plot.background = element_rect(fill='#252525'),
        text = element_text(family='Bebas Neue', color='white'),
        panel.grid.major.x  = element_blank(),
        panel.grid.minor.x  = element_blank(),
        panel.grid.minor.y  = element_blank(),
        panel.grid.major.y  = element_line(size=0.01),
        axis.title = element_text(color='#4D4D4D', hjust=0.85),
        plot.title = element_text(size=50, hjust=0.5),
        plot.subtitle = element_text(size=20, hjust=0.5),
        plot.caption = element_text(color='#4D4D4D'),
        plot.margin=margin(1,2,1,2, 'cm')) +
  labs(x='', y='Points per game', title='Top NBA Players', subtitle='2021-2022 Season',
       caption='Source: NBA Data')



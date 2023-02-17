# Thailand Analysis 2023-02-14 (Matthew Henderson)
setwd("~/dev/hugo/gypsy_lulu/analysis/r/")

library(tidyverse)
source("r-utils/ggplot2/ggthemeify.R")
source("r-utils/ggplot2/my_ggplots.R")

## Parameters

### data
DATAREPO <- "../repository/"
DATAREPO_OWD <- "ourworldindata/"
PLOTREPO <- "../../site/static/plots/"

### theme
mytheme_colors <- c(
  `skyblue`     = "#0487D9",
  `greenlight`  = "#97BF04",
  `orange`      = "#F2913D",
  `darkbrown`   = "#8C6C5A",
  `bluelagoon`  = "#04AAB8",
  `darkorange`  = "#F2622E",
  `pink`        = "#BF9595",
  `greendark`   = "#4F7302",
  `bluesea`     = "#0388A6",
  `duskyblue`   = "#6C7D8C",
  `brown`       = "#D98452")

main <- c("skyblue", "greenlight", "orange", "darkbrown", "bluelagoon", 
          "darkorange", "pink", "greendark", "bluesea")
highlight <- c("darkbrown", "pink")
myggtheme <- ggthemeify(mytheme_colors, main, highlight)
scales::show_col(myggtheme$mytheme_palette("main"))

theme_font <- ""
theme <- theme_bw() +
  theme(
    aspect.ratio = 9 / 16,
    legend.position = "top",
    text=element_text(family="sans", size=16),
    axis.ticks = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.major.y = element_line(linetype="dashed"),
    panel.grid.minor.y = element_blank(),
    panel.border = element_blank(),
    plot.subtitle=element_text(size=12, face="italic", color="gray")
  )


## Script

### read
tousrist_arrivals_raw <- read_csv(str_c(DATAREPO, DATAREPO_OWD, "international-tourist-arrivals.csv"))

### pipeline
lookup <- c(entity = "Entity", code = "Code", year = "Year", n_arrivals = "International tourism, number of arrivals")
lookup_rev <- setNames(names(lookup), lookup)
tousrist_arrivals <- tousrist_arrivals_raw %>% 
  rename(all_of(lookup))

### plots

title <- "International Tourist Arrivals in South East Asia"
subtitle = str_wrap("Thailand has seen increasing numbers of tourists since 1995 and has become the second biggest tourist 
                    hub in SEA surpassed only by China", 80)
(g1 <- tousrist_arrivals %>% 
  filter(code %in% c("JPN", "IDN", "VNM", "IND", "MYS", "THA") & year <= 2019) %>% 
  rename(all_of(lookup_rev)) %>% 
  ggplot(aes(`Year`, `International tourism, number of arrivals`, colour=`Entity`)) +
  geom_line(data = (tousrist_arrivals %>% filter(code == "THA")), aes(year, n_arrivals), colour="yellow", size=5, alpha=0.5) +
  geom_line(size=1.1) +
  geom_point(colour="black", alpha=0.8) +
  labs(title = title, subtitle = subtitle, colour = NULL) +
  scale_x_continuous(breaks = seq(1995, 2019, 4)) +
  scale_y_continuous(labels=scales::comma_format()) +
  myggtheme$scale_colour_mytheme() +
  theme)

ggsave(str_c(PLOTREPO, "internation-tourist-arrivals.png"), device = "png", width = 8, height = 6, units="in")

library(dplyr)
library(ggplot2)
library(magick)
library(ragg)
library(tigris)

base_size <- 12
font1 <- "Cardo"
background_colour <- "#203312"
text_colour <- "#e8ede6"
line_colour <- "#e8ede6"

options(tigris_use_cache = TRUE)

madison_ky_roads <- roads("KY", "Madison")

ky_landmarks <- landmarks("KY")

berea <- ky_landmarks %>% filter(FULLNAME == "Berea")
richmond <- ky_landmarks %>% filter(FULLNAME == "Richmond")
boonesborough <- ky_landmarks %>% filter(FULLNAME == "Boonesborough")
kirksville <- ky_landmarks %>% filter(FULLNAME == "Kirksville")
waco <- ky_landmarks %>% filter(FULLNAME == "Waco")

ky_towns <- bind_rows(
  berea, richmond, boonesborough, kirksville, waco
)

p <- madison_ky_roads %>%
  ggplot() +
    geom_sf(size = .1, colour = line_colour, alpha = .5) +
    geom_sf(data = ky_towns, colour = line_colour) +
    geom_sf_text(data = berea, aes(label = FULLNAME), colour = text_colour, size = 7, family = font1, nudge_x = -.037, nudge_y = .013) +
    geom_sf_text(data = richmond, aes(label = FULLNAME), colour = text_colour, size = 7, family = font1, nudge_x = -.065, nudge_y = .01) +
    geom_sf_text(data = boonesborough, aes(label = FULLNAME), colour = text_colour, size = 7, family = font1, nudge_x = -.065, nudge_y = .02) +
    geom_sf_text(data = kirksville, aes(label = FULLNAME), colour = text_colour, size = 7, family = font1, nudge_x = -.035, nudge_y = .015) +
    geom_sf_text(data = waco, aes(label = FULLNAME), colour = text_colour, size = 7, family = font1, nudge_x = -.035, nudge_y = .015) +
    theme_void() +
    labs(
      title = "Madison County, Ky."
    ) +
    theme(
      plot.margin       = margin(t = 20, r = 15, b = 20, l = 15, unit = "pt"),
      panel.background  = element_rect(fill = background_colour, colour = NA),
      plot.background   = element_rect(fill = background_colour, colour = NA),
      legend.background = element_rect(colour = background_colour, fill = background_colour),
      strip.background  = element_rect(colour = background_colour, fill = background_colour),
      plot.title        = element_text(colour = text_colour, size = 26, hjust = 1, family = font1, margin = margin(5, 0, 20, 0)),
      plot.subtitle     = element_text(colour = text_colour, size = base_size, hjust = 1, family = font1, margin = margin(5, 0, 10, 0)),
      plot.caption      = element_text(colour = text_colour, size = 10, hjust = 0, family = font1),
      legend.title      = element_blank(),
      legend.text       = element_text(family = font1),
      legend.justification = "right",
      legend.margin     = margin(0, 0, 0, 0),
      legend.box.margin = margin(t = 15, r = 15, b = 0, l = 0, unit = "pt"),
      strip.text        = element_blank(),
      legend.position   = "bottom",
      legend.key.width  = unit(1, 'cm'),
      axis.title.x      = element_blank(),
      axis.title.y      = element_blank(),
      axis.text.x       = element_blank(),
      axis.text.y       = element_blank(),
      axis.ticks.x      = element_blank(),
      axis.ticks.y      = element_blank(),
      panel.grid.major  = element_blank(),
      panel.grid.minor  = element_blank(),
    )

image_path <- here::here("madison-county.png")
agg_png(image_path, res = 300, height = 7, width = 5.35, units = "in")
print(p)
dev.off()

madison_county <- image_read(image_path)
madison_county <- image_trim(madison_county)
image_write(madison_county, path = image_path)


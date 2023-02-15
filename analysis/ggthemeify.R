library(tidyverse)

ggthemeify <- function(mytheme_colors, main, highlight) {
  #' Create ggplot colour palette using input hex codes
  #' @input mytheme_colors vector of named hex codes
  #' @input main vector of names of colours to be considered main
  #' @input highlight vector of colours to be considered highlight
  #' @output ggtheme class containing colour palettes for ggplot
  
  mytheme_colors <- mytheme_colors
  main <- main
  highlight <- highlight
  
  ## define colours
  mytheme_color <- function(...) {
    
    cols <- c(...)
    
    if (is.null(cols))
      return (mytheme_colors)
    
    mytheme_colors[cols]
  }
  
  ## define palette
  mytheme_palette <- function(palette = "main", ...) {
    
    mytheme_palettes <- list(
      `main` = mytheme_color(main),
      
      `highlight` = mytheme_color(highlight)
    )
    
    mytheme_palettes[[palette]]
    
  }
  
  ## 
  
  palette_gen <- function(palette = "main", direction = 1) {
    
    function(n) {
      
      if (n > length(mytheme_palette(palette)))
        warning("Not enough colors in this palette!")
      
      else {
        
        all_colors <- mytheme_palette(palette)
        
        all_colors <- unname(unlist(all_colors))
        
        all_colors <- if (direction >= 0) all_colors else rev(all_colors)
        
        color_list <- all_colors[1:n]
        
      }
    }
  }
  
  palette_gen_c <- function(palette = "main", direction = 1, ...) {
    
    pal <- mytheme_palette(palette)
    
    pal <- if (direction >= 0) pal else rev(pal)
    
    colorRampPalette(pal, ...)
    
  }
  
  scale_fill_mytheme <- function(palette = "main", direction = 1, ...) {
    
    ggplot2::discrete_scale(
      "fill", "mytheme",
      palette_gen(palette, direction),
      ...
    )
  }
  
  scale_colour_mytheme <- function(palette = "main", direction = 1, ...) {
    
    ggplot2::discrete_scale(
      "colour", "mytheme",
      palette_gen(palette, direction),
      ...
    )
  }
  
  scale_color_mytheme <- scale_colour_mytheme
  
  scale_color_mytheme_c <- function(palette = "main", direction = 1, ...) {
    
    pal <- palette_gen_c(palette = palette, direction = direction)
    
    scale_color_gradientn(colors = pal(256), ...)
    
  }  
  
  value = list(
    mytheme_color = mytheme_color,
    mytheme_palette = mytheme_palette,
    scale_fill_mytheme = scale_fill_mytheme,
    scale_colour_mytheme = scale_colour_mytheme,
    scale_color_mytheme_c = scale_color_mytheme_c
  )
  attr(value, 'class') <- 'ggtheme'
  value
  
}







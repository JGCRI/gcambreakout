library(rmap); library(dplyr)


# http://vrl.cs.brown.edu/color # Color palettes
rmap::mapGCAMReg32
rmap::map(rmap::mapGCAMReg32%>%dplyr::mutate(subRegion=subRegionAlt),folder=paste0(getwd(),"/vignettes/vignetteFigs"),
          labels=T, palette=c("#4f8c9d", "#c1f274", "#b54164", "#8de4d3", "#8d5e63", "#72ff72", "#6146ca", "#7bac31", "#b8b2f0", "#b94414", "#24ffcd", "#f82387", "#0ba47e", "#eb957f", "#4b5aa0", "#fae277", "#e26df8", "#1c5f1e", "#ffff11", "#8601ee", "#02b72e", "#fe2b27", "#f79302", "#866609"))


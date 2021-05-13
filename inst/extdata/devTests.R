# library(devtools)
# install_github("JGCRI/gcambreakout")
library(gcambreakout)

gcamdataFolderx <- "C:/Z/models/GCAMVersions/gcam-core_stash/input/gcamdata"

breakoutRegion(gcamdataFolder = gcamdataFolderx,
         regionNew = "Thailand",
         countriesNew = c("Thailand"))

# gcamdataFolder = gcamdataFolderx
# regionNew = "Thailand"
# countriesNew = c("Thailand")

breakoutCity(gcamdataFolder = gcamdataFolderx,
             region = "Thailand",
             city = "Bangkok",
             popProjection = gcambreakout::template_popProjection,
             pcgdpProjection = gcambreakout::template_pcgdpProjection)

# gcamdataFolder = gcamdataFolderx
# region = "Thailand"
# city = "Bangkok"

restore(gcamdataFolder = gcamdataFolderx)


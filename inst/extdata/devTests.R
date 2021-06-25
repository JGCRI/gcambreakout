# library(devtools)
# install_github("JGCRI/gcambreakout")
library(gcambreakout)

gcamdataFolderx <- "C:/Z/models/GCAMVersions/gcam-core_v5p3_sha_feature_southeast-asia/input/gcamdata"

breakoutRegion(gcamdataFolder = gcamdataFolderx,
         regionNew = "Malaysia",
         countriesNew = c("Malaysia"))

# gcamdataFolder = gcamdataFolderx
# regionNew = "Thailand"
# countriesNew = c("Thailand")

breakoutCity(gcamdataFolder = gcamdataFolderx,
             region = "Thailand",
             city = "Bangkok",
             popProjection = gcambreakout::template_popProjection,
             pcgdpProjection = gcambreakout::template_pcgdpProjection)

breakoutCity(gcamdataFolder = gcamdataFolderx,
             region = "Malaysia",
             city = "KualaLumpur",
             popProjection = "C:/Z/projects/current/00_SMART/kualalumpur/template_popProjection_kl.csv",
             pcgdpProjection = "C:/Z/projects/current/00_SMART/kualalumpur/template_pcgdpProjection_kl.csv")

# gcamdataFolder = gcamdataFolderx
# region = "Thailand"
# city = "Bangkok"

restore(gcamdataFolder = gcamdataFolderx)


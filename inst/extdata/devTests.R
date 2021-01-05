library(rgcambreakout)
library(dplyr)
library(magrittr)

breakout(gcamdataFolder = "C:/Z/models/GCAMVersions/gcam-core_v5p3_sha_feature_southeast-asia-breakout-thailand/input/gcamdata",
         regionNew = "Thailand Laos",
         countriesNew = c("Thailand","Lao Peoples Democratic Republic"))

restore(gcamdataFolder = "C:/Z/models/GCAMVersions/gcam-core_v5p3_sha_feature_southeast-asia-breakout-thailand/input/gcamdata")

gcamdataFolder = "C:/Z/models/GCAMVersions/gcam-core_v5p3_sha_feature_southeast-asia-breakout-thailand/input/gcamdata"
regionNew = "Thailand Laos"
countriesNew = c("Thailand","Lao Peoples Democratic Republic")


# dev tests
gcamdataFolder = "C:/Z/models/rgcambreakout/tests/testthat/gcamdata_test"
regionNew = "Thailand Laos"
countriesNew = c("Thailand","Lao Peoples Democratic Republic")
rgcambreakout::breakout(gcamdataFolder,regionNew,countriesNew)
rgcambreakout::restore(gcamdataFolder)

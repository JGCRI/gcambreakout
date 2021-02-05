library(gcambreakout)
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
gcamdataFolder = "C:/Z/models/gcambreakout/tests/testthat/gcamdata_test"
regionNew = "Thailand Laos"
countriesNew = c("Thailand","Lao Peoples Democratic Republic")
gcambreakout::breakout(gcamdataFolder,regionNew,countriesNew)
gcambreakout::restore(gcamdataFolder)

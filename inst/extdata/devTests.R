# library(devtools)
# install_github("JGCRI/gcambreakout")
library(gcambreakout)

breakout(gcamdataFolder = "C:/Z/models/GCAMVersions/gcam-core_tag_v5.3/input/gcamdata",
         regionNew = "Thailand Laos",
         countriesNew = c("Thailand","Lao Peoples Democratic Republic"),
         breakoutCountriesNew = T,
         breakoutCountriesNew_elec = T,
         IEA_EnergyBalances_FileName = "IEA_EnergyBalances_2019.csv.gz")

restore(gcamdataFolder = "C:/Z/models/GCAMVersions/gcam-core_tag_v5.3/input/gcamdata")


gcamdataFolder = "C:/Z/models/GCAMVersions/gcam-core_tag_v5.3/input/gcamdata"
regionNew = "Thailand Laos"
countriesNew = c("Thailand","Lao Peoples Democratic Republic")
breakoutCountriesNew = T
breakoutCountriesNew_elec = T
IEA_EnergyBalances_FileName = "IEA_EnergyBalances_2019.csv.gz"


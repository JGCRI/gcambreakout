# library(devtools)
# install_github("JGCRI/gcambreakout")
library(gcambreakout)

gcamdataFolderx <- "C:/Z/models/GCAMVersions/gcam-core_stash/input/gcamdata"

breakoutRegion(gcamdataFolder = gcamdataFolderx,
         regionNew = "NEWRegion",
         countriesNew = c("Spain","Germany"))

breakoutCity(gcamdataFolder = gcamdataFolderx,
             region = "Spain",
             city = "Madrid")

restore(gcamdataFolder = gcamdataFolderx)


gcamdataFolder = gcamdataFolderx
regionNew = "Thailand Laos"
countriesNew = c("Thailand","Lao Peoples Democratic Republic")
breakoutCountriesNew = T
breakoutCountriesNew_elec = T
IEA_EnergyBalances_FileName = "IEA_EnergyBalances_2019.csv.gz"


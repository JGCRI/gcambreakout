
library(tibble);library(dplyr);library(devtools); library(readr)

#-------------------
# Templates
#-------------------

dataFileFolder = "C:/Z/models/gcambreakout/inst/extdata/templates"

# Scoioeconomic R Template
template_zchunk_X201.socioeconomic_APPEND <- readr::read_lines(paste0(dataFileFolder,"/zchunk_X201.socioeconomic_APPEND.R"))
use_data(template_zchunk_X201.socioeconomic_APPEND, overwrite=T)

# Socioeconomics Batch Template
template_zchunk_Xbatch_socioeconomics_APPEND <- readr::read_lines(paste0(dataFileFolder,"/zchunk_Xbatch_socioeconomics_APPEND.R"))
use_data(template_zchunk_Xbatch_socioeconomics_APPEND, overwrite=T)

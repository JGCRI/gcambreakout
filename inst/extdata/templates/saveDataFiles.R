
library(tibble);library(dplyr);library(devtools)

#-------------------
# Templates
#-------------------

dataFileFolder = "C:/Z/models/gcambreakout/inst/extdata/templates"

# IEA_memo_ctry
template_IEA_memo_ctry_comments <- ((utils::read.csv(file=paste(dataFileFolder,"/IEA_memo_ctry.csv",sep=""), header = F))[,1])%>%
  as.data.frame();
names(template_IEA_memo_ctry_comments)<-"Col1"
template_IEA_memo_ctry_comments <- template_IEA_memo_ctry_comments %>%
  dplyr::filter(grepl("#",Col1)); template_IEA_memo_ctry_comments
use_data(template_IEA_memo_ctry_comments, overwrite=T)


# IEA_EnergyBalances Countries
file_IEA_EnergyBalances <- "C:/Z/models/GCAMVersions/gcam-core_tag_v5.3/input/gcamdata/inst/extdata/energy/IEA_EnergyBalances_2019.csv.gz"
IEA_EnergyBalances = utils::read.csv(file_IEA_EnergyBalances, sep = ",",comment.char="#") %>% tibble::as_tibble(); IEA_EnergyBalances
IEA_EnergyBalances_Countries_2019 <- unique(IEA_EnergyBalances$COUNTRY)%>%sort(); IEA_EnergyBalances_Countries_2019
use_data(IEA_EnergyBalances_Countries_2019, overwrite=T)


library(tibble);library(dplyr);library(usethis)

# Check to see if this is true
dataFileFolder <- paste0(getwd(),"/inst/extras")


#-------------------
# Mapping files
#-------------------

# mapping of modules in gcamdata system which give errors for certain countries.
mapping_modules <- tibble::tribble(
~"module", ~"countryNew", ~"error",
"zchunk_L203.water_td_breakout.R", "Iran, Islamic Republic of", "Error in left_join_error_no_match(., data_aggregated, by = c('region', : left_join_no_match: NA values in new data columns",
"zchunk_L133.water_demand_livestock_breakout.R", "Iran, Islamic Republic of","NaN values in L133.water_demand_livestock_R_B_W_km3 for Pork coefficient",
"zchunk_LB120.LC_GIS_R_LTgis_Yh_GLU_breakout.R", "Angola","Error in left_join_error_no_match(., L123.LC_bm2_R_Past_Y_GLU, by = c('GCAM_region_ID',  : left_join_no_match: NA values in new data columns",
"zchunk_LB123.LC_R_MgdPastFor_Yh_GLU_breakout.R", "Angola","Error in left_join_error_no_match(., L123.LC_bm2_R_Past_Y_GLU, by = c('GCAM_region_ID',  : left_join_no_match: NA values in new data columns",
"zchunk_LA100.IEA_downscale_ctry_breakout.R", "Angola","Angola has zero entries in electricity consumption of the commercial sector ('COMMPUB' product in the IEA Energy Balances)",
"zchunk_LB120.LC_GIS_R_LTgis_Yh_GLU_breakout.R", "Australia","Error in left_join_error_no_match(., L123.LC_bm2_R_Past_Y_GLU, by = c('GCAM_region_ID',  : left_join_no_match: NA values in new data columns",
"zchunk_LB123.LC_R_MgdPastFor_Yh_GLU_breakout.R", "Australia","Error in left_join_error_no_match(., L123.LC_bm2_R_Past_Y_GLU, by = c('GCAM_region_ID',  : left_join_no_match: NA values in new data columns",
"zchunk_LB120.LC_GIS_R_LTgis_Yh_GLU_breakout.R", "Ghana","Error in left_join_error_no_match(., L123.LC_bm2_R_Past_Y_GLU, by = c('GCAM_region_ID',  : left_join_no_match: NA values in new data columns",
"zchunk_LB123.LC_R_MgdPastFor_Yh_GLU_breakout.R", "Ghana","Error in left_join_error_no_match(., L123.LC_bm2_R_Past_Y_GLU, by = c('GCAM_region_ID',  : left_join_no_match: NA values in new data columns",
"zchunk_L171.desalination_breakout.R", "Gabon","Error in left_join_error_no_match(., L123.LC_bm2_R_Past_Y_GLU, by = c('GCAM_region_ID',  : left_join_no_match: NA values in new data columns",
"zchunk_LB120.LC_GIS_R_LTgis_Yh_GLU_breakout.R", "Gabon","Error in left_join_error_no_match(., L123.LC_bm2_R_Past_Y_GLU, by = c('GCAM_region_ID',  : left_join_no_match: NA values in new data columns",
"zchunk_LB123.LC_R_MgdPastFor_Yh_GLU_breakout.R", "Gabon","Error in left_join_error_no_match(., L123.LC_bm2_R_Past_Y_GLU, by = c('GCAM_region_ID',  : left_join_no_match: NA values in new data columns",
"zchunk_L2231.wind_update_breakout.R", "Gabon","Error in module_water_L171.desalination('MAKE', list(`common/iso_GCAM_regID` = list( : No energy from which to deduct desalination-related energy in region"
) %>%
  dplyr::arrange(module)

usethis::use_data(mapping_modules, version=3, overwrite=T)

#-------------------
# Replace gcamdatasystem module templates
#-------------------

# template_zchunk_L203.water_td_breakout
template_zchunk_L203.water_td_breakout <- readr::read_lines(paste0(dataFileFolder,"/zchunk_L203.water_td_breakout.R"))
use_data(template_zchunk_L203.water_td_breakout,version=3, overwrite=T)

# template_zchunk_L203.water_td_breakout
template_zchunk_L133.water_demand_livestock_breakout <- readr::read_lines(paste0(dataFileFolder,"/zchunk_L133.water_demand_livestock_breakout.R"))
use_data(template_zchunk_L133.water_demand_livestock_breakout,version=3, overwrite=T)

# template_zchunk_LB123.LC_R_MgdPastFor_Yh_GLU_breakout
template_zchunk_LB123.LC_R_MgdPastFor_Yh_GLU_breakout <- readr::read_lines(paste0(dataFileFolder,"/zchunk_LB123.LC_R_MgdPastFor_Yh_GLU_breakout.R"))
use_data(template_zchunk_LB123.LC_R_MgdPastFor_Yh_GLU_breakout,version=3, overwrite=T)

# template_zchunk_LB120.LC_GIS_R_LTgis_Yh_GLU_breakout
template_zchunk_LB120.LC_GIS_R_LTgis_Yh_GLU_breakout <- readr::read_lines(paste0(dataFileFolder,"/zchunk_LB120.LC_GIS_R_LTgis_Yh_GLU_breakout.R"))
use_data(template_zchunk_LB120.LC_GIS_R_LTgis_Yh_GLU_breakout,version=3, overwrite=T)

# template_zchunk_LA100.IEA_downscale_ctry_breakout
template_zchunk_LA100.IEA_downscale_ctry_breakout <- readr::read_lines(paste0(dataFileFolder,"/zchunk_LA100.IEA_downscale_ctry_breakout.R"))
use_data(template_zchunk_LA100.IEA_downscale_ctry_breakout,version=3, overwrite=T)

# template_zchunk_L2231.wind_update_breakout
template_zchunk_L2231.wind_update_breakout <- readr::read_lines(paste0(dataFileFolder,"/zchunk_L2231.wind_update_breakout.R"))
use_data(template_zchunk_L2231.wind_update_breakout,version=3, overwrite=T)

# template_zchunk_L171.desalination_breakout
template_zchunk_L171.desalination_breakout <- readr::read_lines(paste0(dataFileFolder,"/zchunk_L171.desalination_breakout.R"))
use_data(template_zchunk_L171.desalination_breakout,version=3, overwrite=T)


#-------------------
# City breakout Templates
#-------------------

dataFileFolder = paste0(getwd(),"/inst/extdata/templates"); dataFileFolder

# breakout helpers
template_breakout_helpers <- readr::read_lines(paste0(dataFileFolder,"/breakout_helpers.R"))
use_data(template_breakout_helpers,version=3, overwrite=T)

# Scoioeconomic R Template
template_zchunk_X201.socioeconomic_APPEND <- readr::read_lines(paste0(dataFileFolder,"/zchunk_X201.socioeconomic_APPEND.R"))
use_data(template_zchunk_X201.socioeconomic_APPEND,version=3, overwrite=T)

# Socioeconomics Batch Template
template_zchunk_Xbatch_socioeconomics_xml_APPEND <- readr::read_lines(paste0(dataFileFolder,"/zchunk_Xbatch_socioeconomics_xml_APPEND.R"))
use_data(template_zchunk_Xbatch_socioeconomics_xml_APPEND,version=3, overwrite=T)

# popProjection Template
template_popProjection <- data.table::fread(paste0(dataFileFolder,"/template_popProjection.csv")) %>% tibble::as_tibble()
use_data(template_popProjection,version=3, overwrite=T)

# pcgdpProjection Template
template_pcgdpProjection <- data.table::fread(paste0(dataFileFolder,"/template_pcgdpProjection.csv")) %>% tibble::as_tibble()
use_data(template_pcgdpProjection,version=3, overwrite=T)

# Building R Template
template_zchunk_X244.building_APPEND <- readr::read_lines(paste0(dataFileFolder,"/zchunk_X244.building_APPEND.R"))
use_data(template_zchunk_X244.building_APPEND,version=3, overwrite=T)

# Building Batch Template
template_zchunk_Xbatch_building_xml_APPEND <- readr::read_lines(paste0(dataFileFolder,"/zchunk_Xbatch_building_xml_APPEND.R"))
use_data(template_zchunk_Xbatch_building_xml_APPEND,version=3, overwrite=T)

# Industry R Template
template_zchunk_X232.industry_APPEND <- readr::read_lines(paste0(dataFileFolder,"/zchunk_X232.industry_APPEND.R"))
use_data(template_zchunk_X232.industry_APPEND,version=3, overwrite=T)

# Industry Batch Template
template_zchunk_Xbatch_industry_xml_APPEND <- readr::read_lines(paste0(dataFileFolder,"/zchunk_Xbatch_industry_xml_APPEND.R"))
use_data(template_zchunk_Xbatch_industry_xml_APPEND,version=3, overwrite=T)

# Transport R Template
template_zchunk_X254.transportation_APPEND <- readr::read_lines(paste0(dataFileFolder,"/zchunk_X254.transportation_APPEND.R"))
use_data(template_zchunk_X254.transportation_APPEND,version=3, overwrite=T)

# Transport Batch Template
template_zchunk_Xbatch_transportation_xml_APPEND <- readr::read_lines(paste0(dataFileFolder,"/zchunk_Xbatch_transportation_xml_APPEND.R"))
use_data(template_zchunk_Xbatch_transportation_xml_APPEND,version=3, overwrite=T)

# Industry Batch Template
template_zchunk_Xbatch_liquids_limits_xml_APPEND <- readr::read_lines(paste0(dataFileFolder,"/zchunk_Xbatch_liquids_limits_xml_APPEND.R"))
use_data(template_zchunk_Xbatch_liquids_limits_xml_APPEND,version=3, overwrite=T)



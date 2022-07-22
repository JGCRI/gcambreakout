
library(tibble);library(dplyr);library(usethis)

# Check to see if this is true
dataFileFolder <- paste0(getwd(),"/inst/extras")


#-------------------
# Mapping files
#-------------------

# mapping of modules in gcamdata system which give errors for certain countries.
mapping_modules <- tibble::tribble(
~"module", ~"gcam_version", ~"error",
# GCAM Version 5.4
"zchunk_L203.water_td_breakout_gcamv54.R", "5.4" ,"Error in left_join_error_no_match(., data_aggregated, by = c('region', : left_join_no_match: NA values in new data columns",
"zchunk_L133.water_demand_livestock_breakout_gcamv54.R", "5.4", "NaN values in L133.water_demand_livestock_R_B_W_km3 for Pork coefficient",
"zchunk_LB120.LC_GIS_R_LTgis_Yh_GLU_breakout_gcamv54.R", "5.4", "Error in left_join_error_no_match(., L123.LC_bm2_R_Past_Y_GLU, by = c('GCAM_region_ID',  : left_join_no_match: NA values in new data columns",
"zchunk_LB123.LC_R_MgdPastFor_Yh_GLU_breakout_gcamv54.R", "5.4","Error in left_join_error_no_match(., L123.LC_bm2_R_Past_Y_GLU, by = c('GCAM_region_ID',  : left_join_no_match: NA values in new data columns",
"zchunk_LA100.IEA_downscale_ctry_breakout_gcamv54.R", "5.4","Zero entries in electricity consumption of the commercial sector ('COMMPUB' product in the IEA Energy Balances)",
"zchunk_L171.desalination_breakout_gcamv54.R", "5.4","Error in left_join_error_no_match(., L123.LC_bm2_R_Past_Y_GLU, by = c('GCAM_region_ID',  : left_join_no_match: NA values in new data columns",
"zchunk_L223.electricity_breakout_gcamv54.R", "5.4", "Error FILL IN HERE",
"zchunk_L2231.wind_update_breakout_gcamv54.R", "5.4","Error in module_water_L171.desalination('MAKE', list(`common/iso_GCAM_regID` = list( : No energy from which to deduct desalination-related energy in region",
"zchunk_LA120.offshore_wind_breakout_gcamv54.R", "5.4","Error in left_join_error_no_match(., L120.grid.cost %>% select(region, : left_join_no_match: NA values in new data columns",
"zchunk_LB142.ag_Fert_IO_R_C_Y_GLU_breakout_gcamv54.R", "5.4",'Error in module_aglu_LB142.ag_Fert_IO_R_C_Y_GLU("MAKE", list(`common/iso_GCAM_regID` = list( : Fertilizer input-output coefficients need to be specified in all historical years',
"zchunk_LA1012.en_bal_EFW_breakout_gcamv54.R", "5.4",'Error in left_join_error_no_match(., L120.mid.price, by = c("GCAM_region_ID")) : left_join_no_match: NA values in new data columns',
"zchunk_LB1321.regional_ag_prices_breakout_gcamv54.R", "5.4","NAs in xml en_supply.xml",
"zchunk_LA1321.cement_breakout_gcamv54.R", "5.4","NAs in xml cement.xml",
"zchunk_LA100.0_LDS_preprocessing_breakout_gcamv54.R", "5.4","calibration issues related to lack of forest data",
# GCAM Version 6.0
"zchunk_batch_ag_For_Past_bio_base_IRR_MGMT_xml_breakout_gcamv6p0.R","6.0","gcamdata: GLU GCAM_region_ID",
"zchunk_batch_bio_externality_cost_xml_breakout_gcamv6p0.R","6.0","gcamdata: GLU GCAM_region_ID",
"zchunk_batch_land_input_4_IRR_MGMT_xml_breakout_gcamv6p0.R","6.0","gcamdata: GLU GCAM_region_ID",
"zchunk_batch_land_input_5_IRR_MGMT_xml_breakout_gcamv6p0.R","6.0","gcamdata: GLU GCAM_region_ID",
"zchunk_L2042.resbio_input_irr_mgmt_breakout_gcamv6p0.R","6.0","gcamdata: GLU GCAM_region_ID",
"zchunk_L2052.ag_prodchange_cost_irr_mgmt_breakout_gcamv6p0.R","6.0","gcamdata: GLU GCAM_region_ID",
"zchunk_L2062.ag_Fert_irr_mgmt_breakout_gcamv6p0.R","6.0","gcamdata: GLU GCAM_region_ID",
"zchunk_L2072.ag_water_irr_mgmt_breakout_gcamv6p0.R","6.0","gcamdata: GLU GCAM_region_ID",
"zchunk_L2112.ag_nonco2_IRR_MGMT_breakout_gcamv6p0.R","6.0","gcamdata: GLU GCAM_region_ID",
"zchunk_L2231.wind_update_breakout_gcamv6p0.R","6.0","gcamdata: GLU GCAM_region_ID",
"zchunk_L242.ssp34_pasture_breakout_gcamv6p0.R","6.0","gcamdata: GLU GCAM_region_ID",
"zchunk_L252.MACC_breakout_gcamv6p0.R","6.0","gcamdata: GLU GCAM_region_ID",
"zchunk_LA101.ag_FAO_R_C_Y_breakout_gcamv6p0.R","6.0","gcamdata: GLU GCAM_region_ID",
"zchunk_LB120.LC_GIS_R_LTgis_Yh_GLU_breakout_gcamv6p0.R","6.0","gcamdata: GLU GCAM_region_ID",
"zchunk_LB122.LC_R_Cropland_Yh_GLU_breakout_gcamv6p0.R","6.0","gcamdata: GLU GCAM_region_ID",
"zchunk_LB171.LC_R_Cropland_Yh_GLU_irr_breakout_gcamv6p0.R","6.0","gcamdata: GLU GCAM_region_ID"
)%>%
  dplyr::arrange(module)

usethis::use_data(mapping_modules, version=3, overwrite=T)

#-------------------
# Replace gcamdatasystem module templates
#-------------------

#............................................
# GCAM v 6.0
#............................................

# template_zchunk_LB120.LC_GIS_R_LTgis_Yh_GLU_breakout_gcamv6p0
template_zchunk_LB120.LC_GIS_R_LTgis_Yh_GLU_breakout_gcamv6p0 <- readr::read_lines(paste0(dataFileFolder,"/zchunk_LB120.LC_GIS_R_LTgis_Yh_GLU_breakout_gcamv6p0.R"))
use_data(template_zchunk_LB120.LC_GIS_R_LTgis_Yh_GLU_breakout_gcamv6p0,version=3, overwrite=T)

template_zchunk_L2231.wind_update_breakout_gcamv6p0 <- readr::read_lines(paste0(dataFileFolder,"/zchunk_L2231.wind_update_breakout_gcamv6p0.R"))
use_data(template_zchunk_L2231.wind_update_breakout_gcamv6p0,version=3, overwrite=T)

template_zchunk_batch_ag_For_Past_bio_base_IRR_MGMT_xml_breakout_gcamv6p0 <- readr::read_lines(paste0(dataFileFolder,"/zchunk_batch_ag_For_Past_bio_base_IRR_MGMT_xml_breakout_gcamv6p0.R"))
use_data(template_zchunk_batch_ag_For_Past_bio_base_IRR_MGMT_xml_breakout_gcamv6p0,version=3, overwrite=T)

template_zchunk_batch_bio_externality_cost_xml_breakout_gcamv6p0 <- readr::read_lines(paste0(dataFileFolder,"/zchunk_batch_bio_externality_cost_xml_breakout_gcamv6p0.R"))
use_data(template_zchunk_batch_bio_externality_cost_xml_breakout_gcamv6p0,version=3, overwrite=T)

template_zchunk_batch_land_input_4_IRR_MGMT_xml_breakout_gcamv6p0 <- readr::read_lines(paste0(dataFileFolder,"/zchunk_batch_land_input_4_IRR_MGMT_xml_breakout_gcamv6p0.R"))
use_data(template_zchunk_batch_land_input_4_IRR_MGMT_xml_breakout_gcamv6p0,version=3, overwrite=T)

template_zchunk_batch_land_input_5_IRR_MGMT_xml_breakout_gcamv6p0 <- readr::read_lines(paste0(dataFileFolder,"/zchunk_batch_land_input_5_IRR_MGMT_xml_breakout_gcamv6p0.R"))
use_data(template_zchunk_batch_land_input_5_IRR_MGMT_xml_breakout_gcamv6p0,version=3, overwrite=T)

template_zchunk_L2042.resbio_input_irr_mgmt_breakout_gcamv6p0 <- readr::read_lines(paste0(dataFileFolder,"/zchunk_L2042.resbio_input_irr_mgmt_breakout_gcamv6p0.R"))
use_data(template_zchunk_L2042.resbio_input_irr_mgmt_breakout_gcamv6p0, version=3, overwrite=T)

template_zchunk_L2052.ag_prodchange_cost_irr_mgmt_breakout_gcamv6p0 <- readr::read_lines(paste0(dataFileFolder,"/zchunk_L2052.ag_prodchange_cost_irr_mgmt_breakout_gcamv6p0.R"))
use_data(template_zchunk_L2052.ag_prodchange_cost_irr_mgmt_breakout_gcamv6p0,version=3, overwrite=T)

template_zchunk_L2062.ag_Fert_irr_mgmt_breakout_gcamv6p0 <- readr::read_lines(paste0(dataFileFolder,"/zchunk_L2062.ag_Fert_irr_mgmt_breakout_gcamv6p0.R"))
use_data(template_zchunk_L2062.ag_Fert_irr_mgmt_breakout_gcamv6p0,version=3, overwrite=T)

template_zchunk_L2072.ag_water_irr_mgmt_breakout_gcamv6p0 <- readr::read_lines(paste0(dataFileFolder,"/zchunk_L2072.ag_water_irr_mgmt_breakout_gcamv6p0.R"))
use_data(template_zchunk_L2072.ag_water_irr_mgmt_breakout_gcamv6p0,version=3, overwrite=T)

template_zchunk_L2112.ag_nonco2_IRR_MGMT_breakout_gcamv6p0 <- readr::read_lines(paste0(dataFileFolder,"/zchunk_L2112.ag_nonco2_IRR_MGMT_breakout_gcamv6p0.R"))
use_data(template_zchunk_L2112.ag_nonco2_IRR_MGMT_breakout_gcamv6p0,version=3, overwrite=T)

template_zchunk_L2231.wind_update_breakout_gcamv6p0 <- readr::read_lines(paste0(dataFileFolder,"/zchunk_L2231.wind_update_breakout_gcamv6p0.R"))
use_data(template_zchunk_L2231.wind_update_breakout_gcamv6p0,version=3, overwrite=T)

template_zchunk_L242.ssp34_pasture_breakout_gcamv6p0 <- readr::read_lines(paste0(dataFileFolder,"/zchunk_L242.ssp34_pasture_breakout_gcamv6p0.R"))
use_data(template_zchunk_L242.ssp34_pasture_breakout_gcamv6p0,version=3, overwrite=T)

template_zchunk_L252.MACC_breakout_gcamv6p0 <- readr::read_lines(paste0(dataFileFolder,"/zchunk_L252.MACC_breakout_gcamv6p0.R"))
use_data(template_zchunk_L252.MACC_breakout_gcamv6p0,version=3, overwrite=T)

template_zchunk_LA101.ag_FAO_R_C_Y_breakout_gcamv6p0 <- readr::read_lines(paste0(dataFileFolder,"/zchunk_LA101.ag_FAO_R_C_Y_breakout_gcamv6p0.R"))
use_data(template_zchunk_LA101.ag_FAO_R_C_Y_breakout_gcamv6p0,version=3, overwrite=T)

template_zchunk_LB120.LC_GIS_R_LTgis_Yh_GLU_breakout_gcamv6p0 <- readr::read_lines(paste0(dataFileFolder,"/zchunk_LB120.LC_GIS_R_LTgis_Yh_GLU_breakout_gcamv6p0.R"))
use_data(template_zchunk_LB120.LC_GIS_R_LTgis_Yh_GLU_breakout_gcamv6p0,version=3, overwrite=T)

template_zchunk_LB122.LC_R_Cropland_Yh_GLU_breakout_gcamv6p0 <- readr::read_lines(paste0(dataFileFolder,"/zchunk_LB122.LC_R_Cropland_Yh_GLU_breakout_gcamv6p0.R"))
use_data(template_zchunk_LB122.LC_R_Cropland_Yh_GLU_breakout_gcamv6p0,version=3, overwrite=T)

template_zchunk_LB171.LC_R_Cropland_Yh_GLU_irr_breakout_gcamv6p0 <- readr::read_lines(paste0(dataFileFolder,"/zchunk_LB171.LC_R_Cropland_Yh_GLU_irr_breakout_gcamv6p0.R"))
use_data(template_zchunk_LB171.LC_R_Cropland_Yh_GLU_irr_breakout_gcamv6p0,version=3, overwrite=T)

#.............................................
# GCAM v 5.4
#............................................

# template_zchunk_LB142.ag_Fert_IO_R_C_Y_GLU_breakout_gcamv54
template_zchunk_LB142.ag_Fert_IO_R_C_Y_GLU_breakout_gcamv54 <- readr::read_lines(paste0(dataFileFolder,"/zchunk_LB142.ag_Fert_IO_R_C_Y_GLU_breakout_gcamv54.R"))
use_data(template_zchunk_LB142.ag_Fert_IO_R_C_Y_GLU_breakout_gcamv54,version=3, overwrite=T)

# template_zchunk_LA1012.en_bal_EFW_breakout_gcamv54
template_zchunk_LA1012.en_bal_EFW_breakout_gcamv54 <- readr::read_lines(paste0(dataFileFolder,"/zchunk_LA1012.en_bal_EFW_breakout_gcamv54.R"))
use_data(template_zchunk_LA1012.en_bal_EFW_breakout_gcamv54,version=3, overwrite=T)

# template_zchunk_LB1321.regional_ag_prices_breakout_gcamv54
template_zchunk_LB1321.regional_ag_prices_breakout_gcamv54 <- readr::read_lines(paste0(dataFileFolder,"/zchunk_LB1321.regional_ag_prices_breakout_gcamv54.R"))
use_data(template_zchunk_LB1321.regional_ag_prices_breakout_gcamv54,version=3, overwrite=T)

# template_zchunk_LA1321.cement_breakout_gcamv54
template_zchunk_LA1321.cement_breakout_gcamv54 <- readr::read_lines(paste0(dataFileFolder,"/zchunk_LA1321.cement_breakout_gcamv54.R"))
use_data(template_zchunk_LA1321.cement_breakout_gcamv54,version=3, overwrite=T)

# template_zchunk_LA100.0_LDS_preprocessing_breakout_gcamv54
template_zchunk_LA100.0_LDS_preprocessing_breakout_gcamv54 <- readr::read_lines(paste0(dataFileFolder,"/zchunk_LA100.0_LDS_preprocessing_breakout_gcamv54.R"))
use_data(template_zchunk_LA100.0_LDS_preprocessing_breakout_gcamv54,version=3, overwrite=T)

# template_zchunk_L223.electricity_breakout_gcamv54
template_zchunk_L223.electricity_breakout_gcamv54 <- readr::read_lines(paste0(dataFileFolder,"/zchunk_L223.electricity_breakout_gcamv54.R"))
use_data(template_zchunk_L223.electricity_breakout_gcamv54,version=3, overwrite=T)

# template_zchunk_LA120.offshore_wind_breakout_gcamv54
template_zchunk_LA120.offshore_wind_breakout_gcamv54 <- readr::read_lines(paste0(dataFileFolder,"/zchunk_LA120.offshore_wind_breakout_gcamv54.R"))
use_data(template_zchunk_LA120.offshore_wind_breakout_gcamv54,version=3, overwrite=T)

# template_zchunk_L203.water_td_breakout_gcamv54
template_zchunk_L203.water_td_breakout_gcamv54 <- readr::read_lines(paste0(dataFileFolder,"/zchunk_L203.water_td_breakout_gcamv54.R"))
use_data(template_zchunk_L203.water_td_breakout_gcamv54,version=3, overwrite=T)

# template_zchunk_L133.water_demand_livestock_breakout_gcamv54
template_zchunk_L133.water_demand_livestock_breakout_gcamv54 <- readr::read_lines(paste0(dataFileFolder,"/zchunk_L133.water_demand_livestock_breakout_gcamv54.R"))
use_data(template_zchunk_L133.water_demand_livestock_breakout_gcamv54,version=3, overwrite=T)

# template_zchunk_LB123.LC_R_MgdPastFor_Yh_GLU_breakout_gcamv54
template_zchunk_LB123.LC_R_MgdPastFor_Yh_GLU_breakout_gcamv54 <- readr::read_lines(paste0(dataFileFolder,"/zchunk_LB123.LC_R_MgdPastFor_Yh_GLU_breakout_gcamv54.R"))
use_data(template_zchunk_LB123.LC_R_MgdPastFor_Yh_GLU_breakout_gcamv54,version=3, overwrite=T)

# template_zchunk_LB120.LC_GIS_R_LTgis_Yh_GLU_breakout_gcamv54
template_zchunk_LB120.LC_GIS_R_LTgis_Yh_GLU_breakout_gcamv54 <- readr::read_lines(paste0(dataFileFolder,"/zchunk_LB120.LC_GIS_R_LTgis_Yh_GLU_breakout_gcamv54.R"))
use_data(template_zchunk_LB120.LC_GIS_R_LTgis_Yh_GLU_breakout_gcamv54,version=3, overwrite=T)

# template_zchunk_LA100.IEA_downscale_ctry_breakout_gcamv54
template_zchunk_LA100.IEA_downscale_ctry_breakout_gcamv54 <- readr::read_lines(paste0(dataFileFolder,"/zchunk_LA100.IEA_downscale_ctry_breakout_gcamv54.R"))
use_data(template_zchunk_LA100.IEA_downscale_ctry_breakout_gcamv54,version=3, overwrite=T)

# template_zchunk_L2231.wind_update_breakout_gcamv54
template_zchunk_L2231.wind_update_breakout_gcamv54 <- readr::read_lines(paste0(dataFileFolder,"/zchunk_L2231.wind_update_breakout_gcamv54.R"))
use_data(template_zchunk_L2231.wind_update_breakout_gcamv54,version=3, overwrite=T)

# template_zchunk_L171.desalination_breakout_gcamv54
template_zchunk_L171.desalination_breakout_gcamv54 <- readr::read_lines(paste0(dataFileFolder,"/zchunk_L171.desalination_breakout_gcamv54.R"))
use_data(template_zchunk_L171.desalination_breakout_gcamv54,version=3, overwrite=T)


#-------------------
# City breakout Templates
#-------------------

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
template_pop_projection <- data.table::fread(paste0(dataFileFolder,"/template_popProjection.csv")) %>% tibble::as_tibble()
use_data(template_pop_projection,version=3, overwrite=T)

# pcgdpProjection Template
template_pcgdp_projection <- data.table::fread(paste0(dataFileFolder,"/template_pcgdpProjection.csv")) %>% tibble::as_tibble()
use_data(template_pcgdp_projection,version=3, overwrite=T)

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



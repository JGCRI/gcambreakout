# Copyright 2019 Battelle Memorial Institute; see the LICENSE file.

#' module_aglu_batch_ag_For_Past_bio_base_IRR_MGMT_xml
#'
#' Construct XML data structure for \code{ag_For_Past_bio_base_IRR_MGMT.xml}.
#'
#' @param command API command to execute
#' @param ... other optional parameters, depending on command
#' @return Depends on \code{command}: either a vector of required inputs,
#' a vector of output names, or (if \code{command} is "MAKE") all
#' the generated outputs: \code{ag_For_Past_bio_base_IRR_MGMT.xml}. The corresponding file in the
#' original data system was \code{batch_ag_For_Past_bio_base_IRR_MGMT.xml.R} (aglu XML).
module_aglu_batch_ag_For_Past_bio_base_IRR_MGMT_xml <- function(command, ...) {
  if(command == driver.DECLARE_INPUTS) {
    return(c(FILE = "common/iso_GCAM_regID",
             FILE = "common/GCAM_region_names",
             FILE = "water/basin_to_country_mapping",
             "L2012.AgSupplySector",
             "L2012.AgSupplySubsector",
             "L2012.AgProduction_ag_irr_mgmt",
             "L2012.AgProduction_For",
             "L2012.AgProduction_Past",
             "L2012.AgHAtoCL_irr_mgmt",
             "L2012.AgYield_bio_ref",
             "L2012.AgTechYr_Past"))
  } else if(command == driver.DECLARE_OUTPUTS) {
    return(c(XML = "ag_For_Past_bio_base_IRR_MGMT.xml"))
  } else if(command == driver.MAKE) {

    all_data <- list(...)[[1]]

    # Load required inputs
    L2012.AgSupplySector <- get_data(all_data, "L2012.AgSupplySector")
    L2012.AgSupplySubsector <- get_data(all_data, "L2012.AgSupplySubsector")
    L2012.AgProduction_ag_irr_mgmt <- get_data(all_data, "L2012.AgProduction_ag_irr_mgmt")
    L2012.AgProduction_For <- get_data(all_data, "L2012.AgProduction_For")
    L2012.AgProduction_Past <- get_data(all_data, "L2012.AgProduction_Past")
    L2012.AgHAtoCL_irr_mgmt <- get_data(all_data, "L2012.AgHAtoCL_irr_mgmt")
    L2012.AgYield_bio_ref <- get_data(all_data, "L2012.AgYield_bio_ref")
    L2012.AgTechYr_Past <- get_data(all_data, "L2012.AgTechYr_Past")

    #........................
    # gcambreakout 17 July 2022
    # Temporary fix until circular dependency on
    # L123.LC_bm2_R_MgdFor_Yh_GLU_beforeadjust is fixed.
    #........................

    iso_GCAM_regID <- get_data(all_data, "common/iso_GCAM_regID")
    basin_to_country_mapping <- get_data(all_data, "water/basin_to_country_mapping")
    GCAM_region_names <- get_data(all_data, "common/GCAM_region_names")

    # Valid GLU Region combos
    glu_gcam <- basin_to_country_mapping %>%
      dplyr::select(iso=ISO, GLU=GLU_code, GLU_name) %>%
      dplyr::mutate(iso = tolower(iso)) %>%
      dplyr::left_join(iso_GCAM_regID, by=c("iso")) %>%
      dplyr::select(GLU, GCAM_region_ID, GLU_name) %>%
      dplyr::filter(GCAM_region_ID > 32) %>%
      unique() %>%
      dplyr::left_join(GCAM_region_names); glu_gcam

    remove_glu <- glu_gcam$GLU_name %>% unique(); remove_glu
    regions_check <- GCAM_region_names$region[!GCAM_region_names$region %in% glu_gcam$region];  regions_check

    L2012.AgSupplySubsector %>%
      dplyr::mutate(remove = dplyr::if_else(((gsub(".*_","",AgSupplySubsector) %in% remove_glu) & (region %in% regions_check)),1,0)) %>%
      dplyr::filter(remove==0) %>%
      dplyr::select(-remove) ->
      L2012.AgSupplySubsector

    L2012.AgProduction_ag_irr_mgmt  %>%
      dplyr::mutate(remove = dplyr::if_else(((gsub(".*_","",AgSupplySubsector) %in% remove_glu) & (region %in% regions_check)),1,0)) %>%
      dplyr::filter(remove==0) %>%
      dplyr::select(-remove) ->
      L2012.AgProduction_ag_irr_mgmt

    L2012.AgProduction_For  %>%
      dplyr::mutate(remove = dplyr::if_else(((gsub(".*_","",AgSupplySubsector) %in% remove_glu) & (region %in% regions_check)),1,0)) %>%
      dplyr::filter(remove==0) %>%
      dplyr::select(-remove) ->
      L2012.AgProduction_For

    L2012.AgProduction_Past  %>%
      dplyr::mutate(remove = dplyr::if_else(((gsub(".*_","",AgSupplySubsector) %in% remove_glu) & (region %in% regions_check)),1,0)) %>%
      dplyr::filter(remove==0) %>%
      dplyr::select(-remove) ->
      L2012.AgProduction_Past

    L2012.AgHAtoCL_irr_mgmt  %>%
      dplyr::mutate(remove = dplyr::if_else(((gsub(".*_","",AgSupplySubsector) %in% remove_glu) & (region %in% regions_check)),1,0)) %>%
      dplyr::filter(remove==0) %>%
      dplyr::select(-remove) ->
      L2012.AgHAtoCL_irr_mgmt

    L2012.AgYield_bio_ref  %>%
      dplyr::mutate(remove = dplyr::if_else(((gsub(".*_","",AgSupplySubsector) %in% remove_glu) & (region %in% regions_check)),1,0)) %>%
      dplyr::filter(remove==0) %>%
      dplyr::select(-remove) ->
      L2012.AgYield_bio_ref

    L2012.AgTechYr_Past %>%
      dplyr::mutate(remove = dplyr::if_else(((gsub(".*_","",AgSupplySubsector) %in% remove_glu) & (region %in% regions_check)),1,0)) %>%
      dplyr::filter(remove==0) %>%
      dplyr::select(-remove) ->
      L2012.AgTechYr_Past

    #............breakout close edits

    # ===================================================

    # Produce outputs
    create_xml("ag_For_Past_bio_base_IRR_MGMT.xml") %>%
      add_logit_tables_xml(L2012.AgSupplySector, "AgSupplySector") %>%
      add_logit_tables_xml(L2012.AgSupplySubsector, "AgSupplySubsector") %>%
      add_xml_data(L2012.AgProduction_ag_irr_mgmt, "AgProduction") %>%
      add_xml_data(L2012.AgProduction_For, "AgProduction") %>%
      add_xml_data(L2012.AgProduction_Past, "AgProduction") %>%
      add_xml_data(L2012.AgHAtoCL_irr_mgmt, "AgHAtoCL") %>%
      add_xml_data(L2012.AgYield_bio_ref, "AgYield") %>%
      add_xml_data(L2012.AgTechYr_Past, "AgTechYr") %>%
      add_precursors("L2012.AgSupplySubsector", "L2012.AgProduction_ag_irr_mgmt",
                     "L2012.AgProduction_For", "L2012.AgProduction_Past", "L2012.AgHAtoCL_irr_mgmt",
                     "L2012.AgYield_bio_ref", "L2012.AgSupplySector", "L2012.AgTechYr_Past",
                     "common/iso_GCAM_regID",
                     "water/basin_to_country_mapping",
                     "common/GCAM_region_names") ->
      ag_For_Past_bio_base_IRR_MGMT.xml

    return_data(ag_For_Past_bio_base_IRR_MGMT.xml)
  } else {
    stop("Unknown command")
  }
}

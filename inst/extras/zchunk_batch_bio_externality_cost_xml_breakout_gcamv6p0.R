# Copyright 2019 Battelle Memorial Institute; see the LICENSE file.

#' module_energy_batch_bio_externality_xml
#'
#' Construct XML data structure for \code{bio_externality.xml}.
#'
#' @param command API command to execute
#' @param ... other optional parameters, depending on command
#' @return Depends on \code{command}: either a vector of required inputs,
#' a vector of output names, or (if \code{command} is "MAKE") all
#' the generated outputs: \code{bio_externality.xml}. The corresponding file in the
#' original data system was \code{L270.limits.R} (energy XML).
module_energy_batch_bio_externality_xml <- function(command, ...) {
  if(command == driver.DECLARE_INPUTS) {
    return(c(FILE = "common/iso_GCAM_regID",
             FILE = "common/GCAM_region_names",
             FILE = "water/basin_to_country_mapping",
             "L270.RenewRsrc",
             "L270.RenewRsrcPrice",
             "L270.GrdRenewRsrcCurves",
             "L270.GrdRenewRsrcMax",
             "L270.ResTechShrwt",
             "L270.AgCoef_bioext"))
  } else if(command == driver.DECLARE_OUTPUTS) {
    return(c(XML = "bio_externality.xml"))
  } else if(command == driver.MAKE) {

    all_data <- list(...)[[1]]

    # Load required inputs
    L270.RenewRsrc <- get_data(all_data, "L270.RenewRsrc")
    L270.RenewRsrcPrice <- get_data(all_data, "L270.RenewRsrcPrice")
    L270.GrdRenewRsrcCurves <- get_data(all_data, "L270.GrdRenewRsrcCurves")
    L270.GrdRenewRsrcMax <- get_data(all_data, "L270.GrdRenewRsrcMax")
    L270.ResTechShrwt <- get_data(all_data, "L270.ResTechShrwt")
    L270.AgCoef_bioext <- get_data(all_data, "L270.AgCoef_bioext")

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

    L270.AgCoef_bioext %>%
      dplyr::mutate(remove = dplyr::if_else(((gsub(".*_","",AgSupplySubsector) %in% remove_glu) & (region %in% regions_check)),1,0)) %>%
      dplyr::filter(remove==0) %>%
      dplyr::select(-remove) ->
      L270.AgCoef_bioext

    #............breakout close edits

    # ===================================================

    # Produce outputs
    create_xml("bio_externality.xml") %>%
      add_xml_data(L270.RenewRsrc, "RenewRsrc") %>%
      add_xml_data(L270.RenewRsrcPrice, "RenewRsrcPrice") %>%
      add_xml_data(L270.GrdRenewRsrcCurves, "GrdRenewRsrcCurves") %>%
      add_xml_data(L270.GrdRenewRsrcMax, "GrdRenewRsrcMax") %>%
      add_node_equiv_xml("resource") %>%
      add_node_equiv_xml("subresource") %>%
      add_xml_data(L270.ResTechShrwt, "ResTechShrwt") %>%
      add_xml_data(L270.AgCoef_bioext, "AgCoef") %>%
      add_precursors("L270.RenewRsrc",
                     "L270.RenewRsrcPrice",
                     "L270.GrdRenewRsrcCurves",
                     "L270.GrdRenewRsrcMax",
                     "L270.ResTechShrwt",
                     "L270.AgCoef_bioext",
                     "common/iso_GCAM_regID",
                     "water/basin_to_country_mapping",
                     "common/GCAM_region_names") ->
      bio_externality.xml

    return_data(bio_externality.xml)
  } else {
    stop("Unknown command")
  }
}

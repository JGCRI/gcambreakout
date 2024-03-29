# Copyright 2019 Battelle Memorial Institute; see the LICENSE file.

#' module_energy_X232.industry_APPEND
#'
#' Creates level2 data for the industry sector.
#'
#' @param command API command to execute
#' @param ... other optional parameters, depending on command
#' @return Depends on \code{command}: either a vector of required inputs,
#' a vector of output names, or (if \code{command} is "MAKE") all
#' the generated outputs: check them out.
#' @details Creates level2 data for the industry sector.
#' @importFrom assertthat assert_that
#' @importFrom dplyr bind_rows distinct filter if_else group_by left_join mutate select semi_join summarise
#' @importFrom tidyr complete gather nesting unite
#' @author ZK 4 June 2021

module_energy_X232.industry_APPEND <- function(command, ...) {
  if(command == driver.DECLARE_INPUTS) {
    return(c(FILE = "common/GCAM_region_names",
             "X201.Pop_APPEND",
             "X201.GDP_APPEND",
             "L232.Supplysector_ind",
             "L232.SubsectorLogit_ind",
             "L232.FinalEnergyKeyword_ind",
             "L232.SubsectorInterp_ind",
             "L232.StubTech_ind",
             "L232.StubTechInterp_ind",
             "L232.StubTechCalInput_indenergy",
             "L232.StubTechCalInput_indfeed",
             "L232.StubTechProd_industry",
             "L232.StubTechCoef_industry",
             "L232.FuelPrefElast_indenergy",
             "L232.PerCapitaBased_ind",
             "L232.IncomeElasticity_ind_gssp2",
             "L232.PriceElasticity_ind",
             "L232.BaseService_ind",
             "L232.SubsectorShrwtFllt_ind",
             "L232.GlobalTechEff_ind",
             "L232.GlobalTechSecOut_ind",
             "L231.UnlimitRsrc",
             "L231.UnlimitRsrcPrice",
             "L231.Supplysector_urb_ind",
             "L231.SubsectorLogit_urb_ind",
             "L231.SubsectorShrwtFllt_urb_ind",
             "L231.SubsectorInterp_urb_ind",
             "L231.StubTech_urb_ind",
             "L231.IndCoef",
             "L252.MAC_prc",
             "L241.fgas_all_units",
             "L201.nonghg_max_reduction",
             "L201.nonghg_steepness",
             "L241.hfc_future",
             "L241.hfc_all",
             "L241.pfc_all",
             "L252.MAC_higwp",
             "L201.en_pol_emissions",
             "L201.en_ghg_emissions",
             "L232.nonco2_prc",
             "L232.nonco2_max_reduction",
             "L232.nonco2_steepness"))
  } else if(command == driver.DECLARE_OUTPUTS) {
    return(c("X232.DeleteFinalDemand_ind_APPEND",
             "X232.DeleteSupplysector_ind_APPEND",
             "X232.Supplysector_ind_APPEND",
             "X232.FinalEnergyKeyword_ind_APPEND",
             "X232.SubsectorLogit_ind_APPEND",
             "X232.SubsectorShrwtFllt_ind_APPEND",
             "X232.SubsectorInterp_ind_APPEND",
             "X232.FuelPrefElast_indenergy_APPEND",
             "X232.StubTech_ind_APPEND",
             "X232.StubTechInterp_ind_APPEND",
             "X232.StubTechCalInput_indenergy_APPEND",
             "X232.StubTechCalInput_indfeed_APPEND",
             "X232.StubTechProd_industry_APPEND",
             "X232.StubTechCoef_industry_APPEND",
             "X232.PerCapitaBased_ind_APPEND",
             "X232.IncomeElasticity_ind_gssp2_APPEND",
             "X232.PriceElasticity_ind_APPEND",
             "X232.BaseService_ind_APPEND",
             "X232.UnlimitRsrc_APPEND",
             "X232.UnlimitRsrcPrice_APPEND",
             "X232.Supplysector_urb_indproc_APPEND",
             "X232.SubsectorLogit_urb_ind_APPEND",
             "X232.SubsectorShrwtFllt_urb_ind_APPEND",
             "X232.SubsectorInterp_urb_ind_APPEND",
             "X232.StubTech_urb_ind_APPEND",
             "X232.StubTechCoef_indproc_APPEND",
             "X232.MAC_indproc_APPEND",
             "X232.fgas_all_units_ind_APPEND",
             "X232.nonghg_max_reduction_ind_APPEND",
             "X232.nonghg_steepness_ind_APPEND",
             "X232.hfc_future_ind_APPEND",
             "X232.MAC_higwp_ind_APPEND",
             "X232.nonco2_max_reduction_indproc_APPEND",
             "X232.nonco2_steepness_indproc_APPEND",
             "X232.pol_emissions_ind_APPEND",
             "X232.ghg_emissions_ind_APPEND",
             "X232.StubTechMarket_ind_APPEND",
             "X232.StubTechSecMarket_ind_APPEND",
             "X232.nonco2_indproc_APPEND",
             "X232.hfc_all_indproc_APPEND",
             "X232.pfc_all_indproc_APPEND"))
  } else if(command == driver.MAKE) {

    # Silence package checks
    year <- NULL

    all_data <- list(...)[[1]]

    # Load required inputs
    GCAM_region_names <- get_data(all_data, "common/GCAM_region_names")
    X201.Pop_APPEND <- get_data(all_data, "X201.Pop_APPEND")
    X201.GDP_APPEND <- get_data(all_data, "X201.GDP_APPEND")
    L232.Supplysector_ind <- get_data(all_data, "L232.Supplysector_ind", strip_attributes = TRUE)
    L232.SubsectorLogit_ind <- get_data(all_data, "L232.SubsectorLogit_ind", strip_attributes = TRUE)
    L232.FinalEnergyKeyword_ind <- get_data(all_data, "L232.FinalEnergyKeyword_ind", strip_attributes = TRUE)
    L232.SubsectorInterp_ind <- get_data(all_data, "L232.SubsectorInterp_ind", strip_attributes = TRUE)
    L232.StubTech_ind <- get_data(all_data, "L232.StubTech_ind", strip_attributes = TRUE)
    L232.StubTechInterp_ind <- get_data(all_data, "L232.StubTechInterp_ind", strip_attributes = TRUE)
    L232.StubTechCalInput_indenergy <- get_data(all_data, "L232.StubTechCalInput_indenergy", strip_attributes = TRUE)
    L232.StubTechCalInput_indfeed <- get_data(all_data, "L232.StubTechCalInput_indfeed", strip_attributes = TRUE)
    L232.StubTechProd_industry <- get_data(all_data, "L232.StubTechProd_industry", strip_attributes = TRUE)
    L232.StubTechCoef_industry <- get_data(all_data, "L232.StubTechCoef_industry", strip_attributes = TRUE)
    L232.FuelPrefElast_indenergy <- get_data(all_data, "L232.FuelPrefElast_indenergy", strip_attributes = TRUE)
    L232.PerCapitaBased_ind <- get_data(all_data, "L232.PerCapitaBased_ind", strip_attributes = TRUE)
    L232.IncomeElasticity_ind_gssp2 <- get_data(all_data, "L232.IncomeElasticity_ind_gssp2", strip_attributes = TRUE)
    L232.PriceElasticity_ind <- get_data(all_data, "L232.PriceElasticity_ind", strip_attributes = TRUE)
    L232.BaseService_ind <- get_data(all_data, "L232.BaseService_ind", strip_attributes = TRUE)
    L232.SubsectorShrwtFllt_ind <- get_data(all_data, "L232.SubsectorShrwtFllt_ind", strip_attributes = TRUE)
    L232.GlobalTechEff_ind <- get_data(all_data, "L232.GlobalTechEff_ind", strip_attributes = TRUE)
    L232.GlobalTechSecOut_ind <- get_data(all_data, "L232.GlobalTechSecOut_ind", strip_attributes = TRUE)

    L231.UnlimitRsrc <- get_data(all_data, "L231.UnlimitRsrc", strip_attributes = TRUE)
    L231.UnlimitRsrcPrice <- get_data(all_data, "L231.UnlimitRsrcPrice", strip_attributes = TRUE)
    L231.Supplysector_urb_ind <- get_data(all_data, "L231.Supplysector_urb_ind", strip_attributes = TRUE)
    L231.SubsectorLogit_urb_ind <- get_data(all_data, "L231.SubsectorLogit_urb_ind", strip_attributes = TRUE)
    L231.SubsectorShrwtFllt_urb_ind <- get_data(all_data, "L231.SubsectorShrwtFllt_urb_ind", strip_attributes = TRUE)
    L231.SubsectorInterp_urb_ind <- get_data(all_data, "L231.SubsectorInterp_urb_ind", strip_attributes = TRUE)
    L231.StubTech_urb_ind <- get_data(all_data, "L231.StubTech_urb_ind", strip_attributes = TRUE)
    L231.IndCoef <- get_data(all_data, "L231.IndCoef", strip_attributes = TRUE)
    L252.MAC_prc <- get_data(all_data, "L252.MAC_prc", strip_attributes = TRUE)

    L241.fgas_all_units <- get_data(all_data, "L241.fgas_all_units", strip_attributes = TRUE)
    L201.nonghg_max_reduction <- get_data(all_data, "L201.nonghg_max_reduction", strip_attributes = TRUE)
    L201.nonghg_steepness <- get_data(all_data, "L201.nonghg_steepness", strip_attributes = TRUE)
    L241.hfc_future <- get_data(all_data, "L241.hfc_future", strip_attributes = TRUE)
    L241.hfc_all <- get_data(all_data, "L241.hfc_all", strip_attributes = TRUE)
    L241.pfc_all <- get_data(all_data, "L241.pfc_all", strip_attributes = TRUE)
    L252.MAC_higwp <- get_data(all_data, "L252.MAC_higwp", strip_attributes = TRUE)
    L201.en_pol_emissions <- get_data(all_data, "L201.en_pol_emissions", strip_attributes = TRUE)
    L201.en_ghg_emissions <- get_data(all_data, "L201.en_ghg_emissions", strip_attributes = TRUE)
    L232.nonco2_prc <- get_data(all_data, "L232.nonco2_prc", strip_attributes = TRUE)
    L232.nonco2_max_reduction <- get_data(all_data, "L232.nonco2_max_reduction", strip_attributes = TRUE)
    L232.nonco2_steepness <- get_data(all_data, "L232.nonco2_steepness", strip_attributes = TRUE)

    # ===================================================

    Industry_sectors <- c(unique(L232.Supplysector_ind$supplysector),
                          unique(L231.Supplysector_urb_ind$supplysector[grepl("industr", L231.Supplysector_urb_ind$supplysector)]))

    X232.DeleteFinalDemand_ind_APPEND <- tibble(region = "APPEND_REGION",
                                                  energy.final.demand = unique(L232.PerCapitaBased_ind$energy.final.demand))
    X232.DeleteSupplysector_ind_APPEND <- tibble(region = "APPEND_REGION",
                                             supplysector = Industry_sectors)

    # These tables should be split into 2 lists: one for tables with generic info that gets written to Subregions
    # and rest-of-APPEND_REGION equivalently, and another that will apply shares to the data (e.g., energy consumption,
    # floorspace, etc) to parse the APPEND_REGION total to the 2 disaggregated regions

    # First, subset the nonco2 tables to only industry technologies
    L231.Supplysector_urb_ind <- filter(L231.Supplysector_urb_ind, supplysector %in% Industry_sectors)
    L231.SubsectorLogit_urb_ind <- filter(L231.SubsectorLogit_urb_ind, supplysector %in% Industry_sectors)
    L231.SubsectorShrwtFllt_urb_ind <- filter(L231.SubsectorShrwtFllt_urb_ind, supplysector %in% Industry_sectors)
    L231.SubsectorInterp_urb_ind <- filter(L231.SubsectorInterp_urb_ind, supplysector %in% Industry_sectors)
    L231.StubTech_urb_ind <- filter(L231.StubTech_urb_ind, supplysector %in% Industry_sectors)
    L231.IndCoef <- filter(L231.IndCoef, supplysector %in% Industry_sectors)
    L252.MAC_prc <- filter(L252.MAC_prc, supplysector %in% Industry_sectors)

    L241.fgas_all_units <- filter(L241.fgas_all_units, supplysector %in% Industry_sectors)
    L201.nonghg_max_reduction <- filter(L201.nonghg_max_reduction, supplysector %in% Industry_sectors)
    L201.nonghg_steepness <- filter(L201.nonghg_steepness, supplysector %in% Industry_sectors)
    L241.hfc_future <- filter(L241.hfc_future, supplysector %in% Industry_sectors)
    L241.hfc_all <- filter(L241.hfc_all, supplysector %in% Industry_sectors)
    L241.pfc_all <- filter(L241.pfc_all, supplysector %in% Industry_sectors)
    L252.MAC_higwp <- filter(L252.MAC_higwp, supplysector %in% Industry_sectors)
    L232.nonco2_max_reduction <- filter(L232.nonco2_max_reduction, supplysector %in% Industry_sectors)
    L232.nonco2_steepness <- filter(L232.nonco2_steepness, supplysector %in% Industry_sectors)

    #..................................
    # Adding in missing countries and regions

    #L241.hfc_all
    L241.hfc_all_missing_gcam_regions <-
      unique(GCAM_region_names$region)[!unique(GCAM_region_names$region) %in%
                                         unique(L241.hfc_all$region)]

    if(length(L241.hfc_all_missing_gcam_regions)>0){
      missing_regions_df <- L241.hfc_all %>%
        dplyr::select(-region) %>%
        dplyr::mutate(input.emissions=0) %>%
        unique() %>%
        merge(data.frame(region=L241.hfc_all_missing_gcam_regions))

      L241.hfc_all %>%
        bind_rows(missing_regions_df) %>%
        replace_na(list(input.emissions = 0)) %>%
        unique()->
        L241.hfc_all
    }

    # L241.pfc_all
    L241.pfc_all_missing_gcam_regions <-
      unique(GCAM_region_names$region)[!unique(GCAM_region_names$region) %in%
                                         unique(L241.pfc_all$region)]

    if(length(L241.pfc_all_missing_gcam_regions)>0){
      missing_regions_df <- L241.pfc_all %>%
        dplyr::select(-region) %>%
        dplyr::mutate(input.emissions=0) %>%
        unique() %>%
        merge(data.frame(region=L241.pfc_all_missing_gcam_regions))

      L241.pfc_all %>%
        bind_rows(missing_regions_df) %>%
        replace_na(list(input.emissions = 0)) %>%
        unique()->
        L241.pfc_all
    }

    # L241.hfc_future
    L241.hfc_future_missing_gcam_regions <-
      unique(GCAM_region_names$region)[!unique(GCAM_region_names$region) %in%
                                         unique(L241.hfc_future$region)]

    if(length(L241.hfc_future_missing_gcam_regions)>0){
      missing_regions_df <- L241.hfc_future %>%
        dplyr::select(-region) %>%
        dplyr::mutate(emiss.coeff=0) %>%
        unique() %>%
        merge(data.frame(region=L241.hfc_future_missing_gcam_regions))

      L241.hfc_future %>%
        bind_rows(missing_regions_df) %>%
        replace_na(list(emiss.coeff = 0)) %>%
        unique()->
        L241.hfc_future}

    # L241.fgas_all_units
    L241.fgas_all_units_missing_gcam_regions <-
      unique(GCAM_region_names$region)[!unique(GCAM_region_names$region) %in%
                                         unique(L241.fgas_all_units$region)]

    if(length(L241.fgas_all_units_missing_gcam_regions)>0){
      missing_regions_df <- L241.fgas_all_units %>%
        dplyr::select(-region) %>%
        unique() %>%
        merge(data.frame(region=L241.fgas_all_units_missing_gcam_regions))


      L241.fgas_all_units %>%
        bind_rows(missing_regions_df) %>%
        unique()->
        L241.fgas_all_units
    }
    #......................................

    X232.list_nochange_data_APPEND <- list(
      L232.Supplysector_ind = L232.Supplysector_ind,
      L232.FinalEnergyKeyword_ind = L232.FinalEnergyKeyword_ind,
      L232.SubsectorLogit_ind = L232.SubsectorLogit_ind,
      L232.SubsectorInterp_ind = L232.SubsectorInterp_ind,
      L232.SubsectorShrwtFllt_ind = L232.SubsectorShrwtFllt_ind,
      L232.StubTech_ind = L232.StubTech_ind,
      L232.StubTechInterp_ind = L232.StubTechInterp_ind,
      L232.FuelPrefElast_indenergy = L232.FuelPrefElast_indenergy,
      L232.StubTechCoef_industry = L232.StubTechCoef_industry,
      L232.PerCapitaBased_ind = L232.PerCapitaBased_ind,
      L232.IncomeElasticity_ind_gssp2 = L232.IncomeElasticity_ind_gssp2,
      L232.PriceElasticity_ind = L232.PriceElasticity_ind,
      L231.UnlimitRsrc = L231.UnlimitRsrc,
      L231.UnlimitRsrcPrice = L231.UnlimitRsrcPrice,
      L231.Supplysector_urb_ind = L231.Supplysector_urb_ind,
      L231.SubsectorLogit_urb_ind = L231.SubsectorLogit_urb_ind,
      L231.SubsectorShrwtFllt_urb_ind = L231.SubsectorShrwtFllt_urb_ind,
      L231.SubsectorInterp_urb_ind = L231.SubsectorInterp_urb_ind,
      L231.StubTech_urb_ind = L231.StubTech_urb_ind,
      L231.IndCoef = L231.IndCoef,
      L252.MAC_prc = L252.MAC_prc,
      L241.fgas_all_units = L241.fgas_all_units,
      L201.nonghg_max_reduction = L201.nonghg_max_reduction,
      L201.nonghg_steepness = L201.nonghg_steepness,
      L241.hfc_future = L241.hfc_future,
      L252.MAC_higwp = L252.MAC_higwp,
      L232.nonco2_max_reduction = L232.nonco2_max_reduction,
      L232.nonco2_steepness = L232.nonco2_steepness
      )

    subregions <- unique(X201.Pop_APPEND$region)
    subregions <- subregions[!subregions %in% c("APPEND_REGION")]

    X232.list_nochange_data_APPEND <- lapply(X232.list_nochange_data_APPEND,
                                      FUN = write_to_breakout_regions,
                                      composite_region = "APPEND_REGION",
                                      disag_regions = c(subregions))

    # Re-set the market names appropriately. Fuel commodity market names will pull from APPEND_REGION (the parent region),
    # whereas inputs that are other sectors in the industrial sector (industrial energy use, industrial feedstocks)
    # come from the disaggregated region
    X232.list_nochange_data_APPEND[["L232.StubTechCoef_industry"]]$market.name <-
      X232.list_nochange_data_APPEND[["L232.StubTechCoef_industry"]]$region

    # Industrial process emissions, unlike the fuels, are in local (Subregions, Rest of APPEND_REGION) markets
    X232.list_nochange_data_APPEND[["L231.IndCoef"]] <- X232.list_nochange_data_APPEND[["L231.IndCoef"]] %>%
      rename(stub.technology = technology) %>%
      mutate(market.name = region)

    X232.pop_gdp_share_APPEND <- X201.Pop_APPEND %>%
      left_join_error_no_match(X201.GDP_APPEND, by = c("region", "year")) %>%
      group_by(year) %>%
      dplyr::filter(region!="APPEND_REGION") %>%
      mutate(popshare = totalPop / sum(totalPop),
             gdpshare = GDP / sum(GDP)) %>%
      ungroup() %>%
      select(region, year, popshare, gdpshare)

    X232.StubTechCalInput_indenergy_APPEND <- L232.StubTechCalInput_indenergy %>%
      downscale_to_breakout_regions(data = .,
                                    composite_region = "APPEND_REGION",
                                    disag_regions = c(subregions),
                                    share_data = X232.pop_gdp_share_APPEND, value.column = "calibrated.value", share.column = "gdpshare")

    X232.StubTechCalInput_indfeed_APPEND <- L232.StubTechCalInput_indfeed %>%
      downscale_to_breakout_regions(data = .,
                                    composite_region = "APPEND_REGION",
                                    disag_regions = c(subregions),
                                    share_data = X232.pop_gdp_share_APPEND, value.column = "calibrated.value", share.column = "gdpshare")

    X232.StubTechProd_industry_APPEND <- L232.StubTechProd_industry %>%
      downscale_to_breakout_regions(data = .,
                                    composite_region = "APPEND_REGION",
                                    disag_regions = c(subregions),
                                    share_data = X232.pop_gdp_share_APPEND, value.column = "calOutputValue", share.column = "gdpshare")

    X232.BaseService_ind_APPEND <- L232.BaseService_ind %>%
      downscale_to_breakout_regions(data = .,
                                    composite_region = "APPEND_REGION",
                                    disag_regions = c(subregions),
                                    share_data = X232.pop_gdp_share_APPEND, value.column = "base.service", share.column = "gdpshare")

    X232.pol_emissions_ind_APPEND <- L201.en_pol_emissions %>%
      filter(supplysector %in% Industry_sectors) %>%
      downscale_to_breakout_regions(data = .,
                                    composite_region = "APPEND_REGION",
                                    disag_regions = c(subregions),
                                    share_data = X232.pop_gdp_share_APPEND, value.column = "input.emissions", share.column = "gdpshare")

    X232.ghg_emissions_ind_APPEND <- L201.en_ghg_emissions %>%
      filter(supplysector %in% Industry_sectors) %>%
      downscale_to_breakout_regions(data = .,
                                    composite_region = "APPEND_REGION",
                                    disag_regions = c(subregions),
                                    share_data = X232.pop_gdp_share_APPEND, value.column = "input.emissions", share.column = "gdpshare")

    X232.nonco2_indproc_APPEND <- L232.nonco2_prc %>%
      filter(supplysector %in% Industry_sectors) %>%
      downscale_to_breakout_regions(data = .,
                                    composite_region = "APPEND_REGION",
                                    disag_regions = c(subregions),
                                    share_data = X232.pop_gdp_share_APPEND, value.column = "input.emissions", share.column = "gdpshare")

    X232.hfc_all_indproc_APPEND <- L241.hfc_all %>%
      downscale_to_breakout_regions(data = .,
                                    composite_region = "APPEND_REGION",
                                    disag_regions = c(subregions),
                                    share_data = X232.pop_gdp_share_APPEND, value.column = "input.emissions", share.column = "gdpshare")

    X232.pfc_all_indproc_APPEND <- L241.pfc_all %>%
      downscale_to_breakout_regions(data = .,
                                    composite_region = "APPEND_REGION",
                                    disag_regions = c(subregions),
                                    share_data = X232.pop_gdp_share_APPEND, value.column = "input.emissions", share.column = "gdpshare")

    # Finally, re-set the market name of the fuel commodities from the default (region where the technology lives) to the
    # "parent" region (APPEND_REGION)
    X232.StubTechMarket_ind_APPEND <- L232.GlobalTechEff_ind %>%
      rename(supplysector = sector.name,
             subsector = subsector.name,
             stub.technology = technology) %>%
      # remove district heat from the available technologies as this is not represented in this region
      filter(subsector != "district heat") %>%
      repeat_add_columns(tibble(region = c(subregions))) %>%
      mutate(market.name = "APPEND_REGION") %>%
      select(LEVEL2_DATA_NAMES[["StubTechMarket"]])

    X232.StubTechSecMarket_ind_APPEND <- L232.GlobalTechSecOut_ind %>%
      rename(supplysector = sector.name,
             subsector = subsector.name,
             stub.technology = technology) %>%
      repeat_add_columns(tibble(region = c(subregions))) %>%
      mutate(market.name = "APPEND_REGION") %>%
      select(LEVEL2_DATA_NAMES[["StubTechSecMarket"]])


    # ===================================================
    # Produce outputs

    X232.DeleteFinalDemand_ind_APPEND %>%
      add_title("Delete energy-final-demand objects for industry sector in APPEND_REGION") %>%
      add_units("Unitless") %>%
      add_comments("APPEND_REGION region name hard-wired") %>%
      add_precursors("L232.PerCapitaBased_ind") ->
      X232.DeleteFinalDemand_ind_APPEND

    X232.DeleteSupplysector_ind_APPEND %>%
      add_title("Delete supplysector objects for industry sector in APPEND_REGION") %>%
      add_units("Unitless") %>%
      add_comments("APPEND_REGION region name hard-wired") %>%
      add_precursors("L232.Supplysector_ind") ->
      X232.DeleteSupplysector_ind_APPEND

    X232.list_nochange_data_APPEND[["L232.Supplysector_ind"]] %>%
      add_title("Supplysector info for industry") %>%
      add_units("NA") %>%
      add_comments("A44.sector written to all regions") %>%
      add_precursors("L232.Supplysector_ind") ->
      X232.Supplysector_ind_APPEND

    X232.list_nochange_data_APPEND[["L232.FinalEnergyKeyword_ind"]] %>%
      add_title("Supply sector keywords for detailed industry sector") %>%
      add_units("NA") %>%
      add_comments("A32.sector written to all regions") %>%
      add_precursors("L232.FinalEnergyKeyword_ind") ->
      X232.FinalEnergyKeyword_ind_APPEND

    X232.list_nochange_data_APPEND[["L232.SubsectorLogit_ind"]] %>%
      add_title("Subsector logit exponents of industry sector") %>%
      add_units("Unitless") %>%
      add_comments("A32.subsector_logit written to all regions") %>%
      add_precursors("L232.SubsectorLogit_ind") ->
      X232.SubsectorLogit_ind_APPEND

    X232.list_nochange_data_APPEND[["L232.SubsectorShrwtFllt_ind"]] %>%
      add_title("Subsector shareweight interpolation for industry sector") %>%
      add_units("NA") %>%
      add_comments("from A32.subsector_shrwt") %>%
      add_precursors("L232.SubsectorShrwtFllt_ind") ->
      X232.SubsectorShrwtFllt_ind_APPEND

    X232.list_nochange_data_APPEND[["L232.SubsectorInterp_ind"]] %>%
        add_title("Subsector shareweight interpolation for industry sector") %>%
        add_units("NA") %>%
        add_comments("A32.subsector_interp written to all regions") %>%
        add_precursors("L232.SubsectorInterp_ind") ->
      X232.SubsectorInterp_ind_APPEND

    X232.list_nochange_data_APPEND[["L232.StubTech_ind"]] %>%
      add_title("Identification of stub technologies for industry") %>%
      add_units("NA") %>%
      add_comments("Technologies from L144.end_use_eff") %>%
      add_precursors("L232.StubTech_ind") ->
      X232.StubTech_ind_APPEND

    X232.list_nochange_data_APPEND[["L232.StubTechInterp_ind"]] %>%
      add_title("Identification of stub technologies for industry") %>%
      add_units("NA") %>%
      add_comments("Technologies from A32.globaltech_interp") %>%
      add_precursors("L232.StubTechInterp_ind") ->
      X232.StubTechInterp_ind_APPEND

    X232.list_nochange_data_APPEND[["L232.FuelPrefElast_indenergy"]] %>%
      add_title("Fuel preference elasticities for industry") %>%
      add_units("Unitless") %>%
      add_comments("based on A32.fuelprefElasticity") %>%
      add_precursors("L232.FuelPrefElast_indenergy") ->
      X232.FuelPrefElast_indenergy_APPEND

    X232.list_nochange_data_APPEND[["L232.StubTechCoef_industry"]] %>%
      add_title("Input-output coefficients (energy vs feedstocks) of industry technology") %>%
      add_units("Unitless efficiency") %>%
      add_comments("Efficiencies taken from L144.end_use_eff") %>%
      add_precursors("L232.StubTechCoef_industry") ->
      X232.StubTechCoef_industry_APPEND

    X232.StubTechCalInput_indenergy_APPEND %>%
      add_title("Calibrated energy consumption by industry technologies") %>%
      add_units("calibrated.value: EJ; shareweights: Unitless") %>%
      add_comments("Calibrated values directly from L144.in_EJ_R_ind_serv_F_Yh") %>%
      add_comments("Shareweights are 1 if subsector/technology total is non-zero, 0 otherwise") %>%
      add_precursors("L232.StubTechCalInput_indenergy", "X201.Pop_APPEND", "X201.GDP_APPEND") ->
      X232.StubTechCalInput_indenergy_APPEND

    X232.StubTechCalInput_indfeed_APPEND %>%
      add_title("Calibrated feedstock consumption by industry technologies") %>%
      add_units("calibrated.value: EJ; shareweights: Unitless") %>%
      add_comments("Shareweights are 1 if subsector/technology total is non-zero, 0 otherwise") %>%
      add_precursors("L232.StubTechCalInput_indfeed", "X201.Pop_APPEND", "X201.GDP_APPEND") ->
      X232.StubTechCalInput_indfeed_APPEND

    X232.StubTechProd_industry_APPEND %>%
      add_title("Calibrated output by industry technologies") %>%
      add_units("calibrated.value: EJ; shareweights: Unitless") %>%
      add_comments("Shareweights are 1 if subsector/technology total is non-zero, 0 otherwise") %>%
      add_precursors("L232.StubTechProd_industry", "X201.Pop_APPEND", "X201.GDP_APPEND") ->
      X232.StubTechProd_industry_APPEND

    X232.list_nochange_data_APPEND[["L232.PerCapitaBased_ind"]] %>%
      add_title("Specification of per-capita based demand formulation") %>%
      add_units("Unitless output ratio") %>%
      add_comments("carried from A32.demand") %>%
      add_precursors("L232.PerCapitaBased_ind") ->
      X232.PerCapitaBased_ind_APPEND


    X232.list_nochange_data_APPEND[["L232.IncomeElasticity_ind_gssp2"]] %>%
      add_title("Industrial sector income elasticity") %>%
      add_units("unitless") %>%
      add_comments("computed from per-capita GDP for thailand; passed equally to each region therein") %>%
      add_precursors("L232.IncomeElasticity_ind_gssp2") ->
      X232.IncomeElasticity_ind_gssp2_APPEND

    X232.list_nochange_data_APPEND[["L232.PriceElasticity_ind"]] %>%
      add_title("Industrial sector price elasticity") %>%
      add_units("unitless") %>%
      add_comments("generic assumption from A32.demand") %>%
      add_precursors("L232.PriceElasticity_ind") ->
      X232.PriceElasticity_ind_APPEND

    X232.BaseService_ind_APPEND %>%
      add_title("Industrial sector base service") %>%
      add_units("EJ/yr of energy service") %>%
      add_comments("Downscaled from APPEND_REGION based on GDP") %>%
      add_precursors("L232.BaseService_ind") ->
      X232.BaseService_ind_APPEND

    X232.list_nochange_data_APPEND[["L231.UnlimitRsrc"]] %>%
      add_title("unlimited resource for misc emissions sources") %>%
      add_units("units not meaningful") %>%
      add_comments("Copied") %>%
      add_precursors("L231.UnlimitRsrc") ->
      X232.UnlimitRsrc_APPEND

    X232.list_nochange_data_APPEND[["L231.UnlimitRsrcPrice"]] %>%
      add_title("unlimited resource prices for misc emissions sources") %>%
      add_units("units not meaningful") %>%
      add_comments("Copied") %>%
      add_precursors("L231.UnlimitRsrcPrice") ->
      X232.UnlimitRsrcPrice_APPEND

    X232.list_nochange_data_APPEND[["L231.Supplysector_urb_ind"]] %>%
      add_title("supplysector info for industrial processes") %>%
      add_units("none") %>%
      add_comments("Copied") %>%
      add_precursors("L231.Supplysector_urb_ind") ->
      X232.Supplysector_urb_indproc_APPEND

    X232.list_nochange_data_APPEND[["L231.SubsectorLogit_urb_ind"]] %>%
      add_title("subsector logit for industrial processes") %>%
      add_units("None") %>%
      add_comments("Copied") %>%
      add_precursors("L231.SubsectorLogit_urb_ind") ->
      X232.SubsectorLogit_urb_ind_APPEND

    X232.list_nochange_data_APPEND[["L231.SubsectorShrwtFllt_urb_ind"]] %>%
      add_title("industrial processes subsector share-weights") %>%
      add_units("Unitless") %>%
      add_comments("Copied") %>%
      add_precursors("L231.SubsectorShrwtFllt_urb_ind") ->
      X232.SubsectorShrwtFllt_urb_ind_APPEND

    X232.list_nochange_data_APPEND[["L231.SubsectorInterp_urb_ind"]] %>%
      add_title("industrial processes subsector share-weight interpolation") %>%
      add_units("unitless") %>%
      add_comments("Copied") %>%
      add_precursors("L231.SubsectorInterp_urb_ind") ->
      X232.SubsectorInterp_urb_ind_APPEND

    X232.list_nochange_data_APPEND[["L231.StubTech_urb_ind"]] %>%
      add_title("stub technologies of industrial processes") %>%
      add_units("unitless") %>%
      add_comments("Copied") %>%
      add_precursors("L231.StubTech_urb_ind") ->
      X232.StubTech_urb_ind_APPEND

    X232.list_nochange_data_APPEND[["L231.IndCoef"]] %>%
      add_title("stub tech coefficients of industrial processes") %>%
      add_units("not meaningful") %>%
      add_comments("Copied") %>%
      add_precursors("L231.IndCoef") ->
      X232.StubTechCoef_indproc_APPEND

    X232.list_nochange_data_APPEND[["L252.MAC_prc"]] %>%
      add_title("MAC curves for industrial processes") %>%
      add_units("1990$/tC") %>%
      add_comments("Copied") %>%
      add_precursors("L252.MAC_prc") ->
      X232.MAC_indproc_APPEND

    X232.list_nochange_data_APPEND[["L241.fgas_all_units"]] %>%
      add_title("Units of f-gas emissions from industry in APPEND") %>%
      add_units("Specified in table") %>%
      add_comments("Copied") %>%
      add_precursors("common/GCAM_region_names","L241.fgas_all_units") ->
      X232.fgas_all_units_ind_APPEND

    X232.list_nochange_data_APPEND[["L201.nonghg_max_reduction"]] %>%
      add_title("max-reduction of pollutant emissions from industry in APPEND") %>%
      add_units("Percent") %>%
      add_comments("Copied") %>%
      add_precursors("L201.nonghg_max_reduction") ->
      X232.nonghg_max_reduction_ind_APPEND

    X232.list_nochange_data_APPEND[["L201.nonghg_steepness"]] %>%
      add_title("steepness of pollutant emissions from industry in APPEND") %>%
      add_units("Unitless") %>%
      add_comments("Copied") %>%
      add_precursors("L201.nonghg_steepness") ->
      X232.nonghg_steepness_ind_APPEND

    X232.list_nochange_data_APPEND[["L241.hfc_future"]] %>%
      add_title("emissions coefficients of f-gases from industry in APPEND") %>%
      add_units("g f-gas per GJ of building energy service") %>%
      add_comments("Copied") %>%
      add_precursors("common/GCAM_region_names","L241.hfc_future") ->
      X232.hfc_future_ind_APPEND

    X232.list_nochange_data_APPEND[["L252.MAC_higwp"]] %>%
      add_title("MAC curves of f-gases from industry in APPEND") %>%
      add_units("portion of emissions reduced as a fn of the carbon price") %>%
      add_comments("Copied") %>%
      add_precursors("L252.MAC_higwp") ->
      X232.MAC_higwp_ind_APPEND

    X232.list_nochange_data_APPEND[["L232.nonco2_max_reduction"]] %>%
      add_title("max reduction of industrial process emissions") %>%
      add_units("unitless portion") %>%
      add_comments("Copied") %>%
      add_precursors("L232.nonco2_max_reduction") ->
      X232.nonco2_max_reduction_indproc_APPEND

    X232.list_nochange_data_APPEND[["L232.nonco2_steepness"]] %>%
      add_title("steepness parameter for industrial process emissions") %>%
      add_units("unitless shape parameter") %>%
      add_comments("Copied") %>%
      add_precursors("L232.nonco2_steepness") ->
      X232.nonco2_steepness_indproc_APPEND

    X232.pol_emissions_ind_APPEND %>%
      add_title("pollutant emissions from APPEND industry") %>%
      add_units("Tg/yr") %>%
      add_comments("downscaled from APPEND_REGION using GDP shares") %>%
      add_precursors("L201.en_pol_emissions") ->
      X232.pol_emissions_ind_APPEND

    X232.ghg_emissions_ind_APPEND %>%
      add_title("greenhouse gas emissions from APPEND industry") %>%
      add_units("Tg/yr") %>%
      add_comments("downscaled from APPEND_REGION using GDP shares") %>%
      add_precursors("L201.en_ghg_emissions") ->
      X232.ghg_emissions_ind_APPEND

    X232.StubTechMarket_ind_APPEND %>%
      add_title("market for fuel commodities in disaggregated regions") %>%
      add_units("unitless") %>%
      add_comments("points to markets in parent region") %>%
      add_precursors("L232.GlobalTechEff_ind") ->
      X232.StubTechMarket_ind_APPEND

    X232.StubTechSecMarket_ind_APPEND %>%
      add_title("market for secondary output electricity disaggregated regions") %>%
      add_units("unitless") %>%
      add_comments("points to markets in parent region") %>%
      add_precursors("L232.GlobalTechSecOut_ind") ->
      X232.StubTechSecMarket_ind_APPEND

    X232.nonco2_indproc_APPEND %>%
      add_title("industrial process emissions") %>%
      add_units("Tg/yr") %>%
      add_comments("downscaled from parent region") %>%
      add_precursors("L232.nonco2_prc") ->
      X232.nonco2_indproc_APPEND

    X232.hfc_all_indproc_APPEND %>%
      add_title("industrial process emissions of HFCs") %>%
      add_units("Gg/yr") %>%
      add_comments("downscaled from parent region") %>%
      add_precursors("common/GCAM_region_names","L241.hfc_all") ->
      X232.hfc_all_indproc_APPEND

    X232.pfc_all_indproc_APPEND %>%
      add_title("industrial process emissions of PFCs") %>%
      add_units("Gg/yr") %>%
      add_comments("downscaled from parent region") %>%
      add_precursors("common/GCAM_region_names","L241.pfc_all") ->
      X232.pfc_all_indproc_APPEND


    return_data(X232.DeleteFinalDemand_ind_APPEND,
                X232.DeleteSupplysector_ind_APPEND,
                X232.Supplysector_ind_APPEND,
                X232.FinalEnergyKeyword_ind_APPEND,
                X232.SubsectorLogit_ind_APPEND,
                X232.SubsectorShrwtFllt_ind_APPEND,
                X232.SubsectorInterp_ind_APPEND,
                X232.FuelPrefElast_indenergy_APPEND,
                X232.StubTech_ind_APPEND,
                X232.StubTechInterp_ind_APPEND,
                X232.StubTechCalInput_indenergy_APPEND,
                X232.StubTechCalInput_indfeed_APPEND,
                X232.StubTechProd_industry_APPEND,
                X232.StubTechCoef_industry_APPEND,
                X232.PerCapitaBased_ind_APPEND,
                X232.IncomeElasticity_ind_gssp2_APPEND,
                X232.PriceElasticity_ind_APPEND,
                X232.BaseService_ind_APPEND,
                X232.UnlimitRsrc_APPEND,
                X232.UnlimitRsrcPrice_APPEND,
                X232.Supplysector_urb_indproc_APPEND,
                X232.SubsectorLogit_urb_ind_APPEND,
                X232.SubsectorShrwtFllt_urb_ind_APPEND,
                X232.SubsectorInterp_urb_ind_APPEND,
                X232.StubTech_urb_ind_APPEND,
                X232.StubTechCoef_indproc_APPEND,
                X232.MAC_indproc_APPEND,
                X232.fgas_all_units_ind_APPEND,
                X232.nonghg_max_reduction_ind_APPEND,
                X232.nonghg_steepness_ind_APPEND,
                X232.hfc_future_ind_APPEND,
                X232.MAC_higwp_ind_APPEND,
                X232.nonco2_max_reduction_indproc_APPEND,
                X232.nonco2_steepness_indproc_APPEND,
                X232.pol_emissions_ind_APPEND,
                X232.ghg_emissions_ind_APPEND,
                X232.StubTechMarket_ind_APPEND,
                X232.StubTechSecMarket_ind_APPEND,
                X232.nonco2_indproc_APPEND,
                X232.hfc_all_indproc_APPEND,
                X232.pfc_all_indproc_APPEND)
  } else {
    stop("Unknown command")
  }
}

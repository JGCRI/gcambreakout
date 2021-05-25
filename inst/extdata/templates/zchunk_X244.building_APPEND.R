# Copyright 2019 Battelle Memorial Institute; see the LICENSE file.

#' module_energy_X244.building_APPEND
#'
#' Creates level2 data for the building sector.
#'
#' @param command API command to execute
#' @param ... other optional parameters, depending on command
#' @return Depends on \code{command}: either a vector of required inputs,
#' a vector of output names, or (if \code{command} is "MAKE") all
#' the generated outputs: \code{L244.SubregionalShares}, \code{L244.PriceExp_IntGains}, \code{L244.Floorspace}, \code{L244.DemandFunction_serv},
#' \code{L244.DemandFunction_flsp}, \code{L244.Satiation_flsp}, \code{L244.SatiationAdder}, \code{L244.ThermalBaseService}, \code{L244.GenericBaseService},
#'\code{L244.ThermalServiceSatiation}, \code{L244.GenericServiceSatiation}, \code{L244.Intgains_scalar}, \code{L244.ShellConductance_bld},
#' \code{L244.Supplysector_bld}, \code{L244.FinalEnergyKeyword_bld}, \code{L244.SubsectorShrwt_bld}, \code{L244.SubsectorShrwtFllt_bld}, \code{L244.SubsectorInterp_bld},
#' \code{L244.SubsectorInterpTo_bld}, \code{L244.SubsectorLogit_bld}, \code{L244.FuelPrefElast_bld}, \code{L244.StubTech_bld}, \code{L244.StubTechEff_bld},
#' \code{L244.StubTechCalInput_bld}, \code{L244.StubTechIntGainOutputRatio}, \code{L244.GlobalTechShrwt_bld}, \code{L244.GlobalTechCost_bld},
#' \code{L244.DeleteGenericService}, \code{L244.Satiation_flsp_SSP1}, \code{L244.SatiationAdder_SSP1}, \code{L244.GenericServiceSatiation_SSP1},
#' \code{L244.Satiation_flsp_SSP2}, \code{L244.SatiationAdder_SSP2}, \code{L244.GenericServiceSatiation_SSP2}, \code{L244.Satiation_flsp_SSP3},
#' \code{L244.SatiationAdder_SSP3}, \code{L244.GenericServiceSatiation_SSP3}, \code{L244.FuelPrefElast_bld_SSP3}, \code{L244.Satiation_flsp_SSP4},
#' \code{L244.SatiationAdder_SSP4}, \code{L244.GenericServiceSatiation_SSP4}, \code{L244.FuelPrefElast_bld_SSP4}, \code{L244.Satiation_flsp_SSP5},
#' \code{L244.SatiationAdder_SSP5}, \code{L244.GenericServiceSatiation_SSP5}, \code{L244.FuelPrefElast_bld_SSP15}, \code{L244.DeleteThermalService},
#' \code{L244.HDDCDD_A2_CCSM3x}, \code{L244.HDDCDD_A2_HadCM3}, \code{L244.HDDCDD_B1_CCSM3x}, \code{L244.HDDCDD_B1_HadCM3} and \code{L244.HDDCDD_constdd_no_GCM}.
#' The corresponding file in the original data system was \code{L244.building_det.R} (energy level2).
#' @details Creates level2 data for the building sector.
#' @importFrom assertthat assert_that
#' @importFrom dplyr bind_rows distinct filter if_else group_by left_join mutate select semi_join summarise
#' @importFrom tidyr complete gather nesting unite
#' @author RLH September 2017

module_energy_X244.building_APPEND <- function(command, ...) {
  if(command == driver.DECLARE_INPUTS) {
    return(c("L201.Pop_APPEND",
             "L201.GDP_APPEND",
             "L244.SubregionalShares",
             "L244.PriceExp_IntGains",
             "L244.Floorspace",
             "L244.DemandFunction_serv",
             "L244.DemandFunction_flsp",
             "L244.Satiation_flsp",
             "L244.SatiationAdder",
             "L244.ThermalBaseService",
             "L244.GenericBaseService",
             "L244.ThermalServiceSatiation",
             "L244.GenericServiceSatiation",
             "L244.Intgains_scalar",
             "L244.ShellConductance_bld",
             "L244.Supplysector_bld",
             "L244.FinalEnergyKeyword_bld",
             "L244.SubsectorShrwtFllt_bld",
             "L244.SubsectorInterp_bld",
             "L244.SubsectorLogit_bld",
             "L244.FuelPrefElast_bld",
             "L244.StubTech_bld",
             "L244.StubTechEff_bld",
             "L244.StubTechCalInput_bld",
             "L244.StubTechIntGainOutputRatio",
             "L244.HDDCDD_constdd_no_GCM",
             "L241.fgas_all_units",
             "L201.nonghg_max_reduction",
             "L201.nonghg_steepness",
             "L241.hfc_future",
             "L201.en_pol_emissions",
             "L201.en_ghg_emissions",
             FILE = "energy/A44.gcam_consumer",
             FILE = "common/GCAM_region_names"
             ))
  } else if(command == driver.DECLARE_OUTPUTS) {
    return(c("S244.DeleteConsumer_APPENDbld",
             "S244.DeleteSupplysector_APPENDbld",
             "S244.SubregionalShares",
                "S244.PriceExp_IntGains",
                "S244.Floorspace",
                "S244.DemandFunction_serv",
                "S244.DemandFunction_flsp",
                "S244.Satiation_flsp",
                "S244.SatiationAdder",
                "S244.ThermalBaseService",
                "S244.GenericBaseService",
                "S244.ThermalServiceSatiation",
                "S244.GenericServiceSatiation",
                "S244.Intgains_scalar",
                "S244.ShellConductance_bld",
                "S244.Supplysector_bld",
                "S244.FinalEnergyKeyword_bld",
                "S244.SubsectorShrwtFllt_bld",
                "S244.SubsectorInterp_bld",
                "S244.FuelPrefElast_bld",
                "S244.StubTech_bld",
                "S244.StubTechEff_bld",
                "S244.StubTechCalInput_bld",
                "S244.SubsectorLogit_bld",
                "S244.StubTechIntGainOutputRatio",
                "S244.HDDCDD_constdd_no_GCM",
             "S244.fgas_all_units_bld_APPEND",
             "S244.nonghg_max_reduction_bld_APPEND",
             "S244.nonghg_steepness_bld_APPEND",
             "S244.hfc_future_bld_APPEND",
             "S244.pol_emissions_bld_APPEND",
             "S244.ghg_emissions_bld_APPEND"))
  } else if(command == driver.MAKE) {

    # Silence package checks
    building.service.input <- calibrated.value <-  comm <- degree.days <- floorspace_bm2 <- gcam.consumer <-
      internal.gains.market.name <- internal.gains.output.ratio <- multiplier <- nodeInput <- pcFlsp_mm2 <-
      pcFlsp_mm2_fby <- pcGDP_thous90USD <- pop_thous <- region <- region.class <- resid <- satiation.adder <-
      satiation.level <- scalar_mult <- sector <- service <- service.per.flsp <- share.weight <- shell.conductance <-
      subs.share.weight <- subsector <- supplysector <- technology <- thermal.building.service.input <- to.value <-
      value <- year <- year.fillout <- GCM <- NEcostPerService <- NULL

    all_data <- list(...)[[1]]

    # Load required inputs
    L201.Pop_APPEND <- get_data(all_data, "L201.Pop_APPEND", strip_attributes = TRUE)
    L201.GDP_APPEND <- get_data(all_data, "L201.GDP_APPEND", strip_attributes = TRUE)
    L244.SubregionalShares <- get_data(all_data, "L244.SubregionalShares", strip_attributes = TRUE)
    L244.PriceExp_IntGains <- get_data(all_data, "L244.PriceExp_IntGains", strip_attributes = TRUE)
    L244.Floorspace <- get_data(all_data, "L244.Floorspace", strip_attributes = TRUE)
    L244.DemandFunction_serv <- get_data(all_data, "L244.DemandFunction_serv", strip_attributes = TRUE)
    L244.DemandFunction_flsp <- get_data(all_data, "L244.DemandFunction_flsp", strip_attributes = TRUE)
    L244.Satiation_flsp <- get_data(all_data, "L244.Satiation_flsp", strip_attributes = TRUE)
    L244.SatiationAdder <- get_data(all_data, "L244.SatiationAdder", strip_attributes = TRUE)
    L244.ThermalBaseService <- get_data(all_data, "L244.ThermalBaseService", strip_attributes = TRUE)
    L244.GenericBaseService <- get_data(all_data, "L244.GenericBaseService", strip_attributes = TRUE)
    L244.ThermalServiceSatiation <- get_data(all_data, "L244.ThermalServiceSatiation", strip_attributes = TRUE)
    L244.GenericServiceSatiation <- get_data(all_data, "L244.GenericServiceSatiation", strip_attributes = TRUE)
    L244.Intgains_scalar <- get_data(all_data, "L244.Intgains_scalar", strip_attributes = TRUE)
    L244.ShellConductance_bld <- get_data(all_data, "L244.ShellConductance_bld", strip_attributes = TRUE)
    L244.Supplysector_bld <- get_data(all_data, "L244.Supplysector_bld", strip_attributes = TRUE)
    L244.FinalEnergyKeyword_bld <- get_data(all_data, "L244.FinalEnergyKeyword_bld", strip_attributes = TRUE)
    L244.SubsectorShrwtFllt_bld <- get_data(all_data, "L244.SubsectorShrwtFllt_bld", strip_attributes = TRUE)
    L244.SubsectorInterp_bld <- get_data(all_data, "L244.SubsectorInterp_bld", strip_attributes = TRUE)
    L244.SubsectorLogit_bld <- get_data(all_data, "L244.SubsectorLogit_bld", strip_attributes = TRUE)
    L244.FuelPrefElast_bld <- get_data(all_data, "L244.FuelPrefElast_bld", strip_attributes = TRUE)
    L244.StubTech_bld <- get_data(all_data, "L244.StubTech_bld", strip_attributes = TRUE)
    L244.StubTechEff_bld <- get_data(all_data, "L244.StubTechEff_bld", strip_attributes = TRUE)
    L244.StubTechCalInput_bld <- get_data(all_data, "L244.StubTechCalInput_bld", strip_attributes = TRUE)
    L244.StubTechIntGainOutputRatio <- get_data(all_data, "L244.StubTechIntGainOutputRatio", strip_attributes = TRUE)
    L244.HDDCDD_constdd_no_GCM <- get_data(all_data, "L244.HDDCDD_constdd_no_GCM", strip_attributes = TRUE)

    L241.fgas_all_units <- get_data(all_data, "L241.fgas_all_units", strip_attributes = TRUE)
    L201.nonghg_max_reduction <- get_data(all_data, "L201.nonghg_max_reduction", strip_attributes = TRUE)
    L201.nonghg_steepness <- get_data(all_data, "L201.nonghg_steepness", strip_attributes = TRUE)
    L241.hfc_future <- get_data(all_data, "L241.hfc_future", strip_attributes = TRUE)
    L201.en_pol_emissions <- get_data(all_data, "L201.en_pol_emissions", strip_attributes = TRUE)
    L201.en_ghg_emissions <- get_data(all_data, "L201.en_ghg_emissions", strip_attributes = TRUE)

    # ===================================================


    S244.DeleteConsumer_APPENDbld <- tibble(region = "APPEND_REGION", gcam.consumer = unique(L244.SubregionalShares$gcam.consumer))
    S244.DeleteSupplysector_APPENDbld <- tibble(region = "APPEND_REGION", supplysector = unique(L244.Supplysector_bld$supplysector))

    # These tables should be split into 2 lists: one for tables with generic info that gets written to APPEND_CITY
    # and rest-of-APPEND_REGION equivalently, and another that will apply shares to the data (e.g., energy consumption,
    # floorspace, etc) to parse the APPEND_REGION total to the 2 disaggregated regions

    # First, subset the nonco2 tables to only buildings technologies
    L241.fgas_all_units <- filter(L241.fgas_all_units, supplysector %in% L244.Supplysector_bld$supplysector)
    L201.nonghg_max_reduction <- filter(L201.nonghg_max_reduction, supplysector %in% L244.Supplysector_bld$supplysector)
    L201.nonghg_steepness <- filter(L201.nonghg_steepness, supplysector %in% L244.Supplysector_bld$supplysector)
    L241.hfc_future <- filter(L241.hfc_future, supplysector %in% L244.Supplysector_bld$supplysector)

    S244.list_nochange_data <- list(
      L244.SubregionalShares = L244.SubregionalShares,
      L244.PriceExp_IntGains = L244.PriceExp_IntGains,
      L244.DemandFunction_serv = L244.DemandFunction_serv,
      L244.DemandFunction_flsp = L244.DemandFunction_flsp,
      L244.Satiation_flsp = L244.Satiation_flsp,
      L244.SatiationAdder = L244.SatiationAdder,
      L244.ThermalServiceSatiation = L244.ThermalServiceSatiation,
      L244.GenericServiceSatiation = L244.GenericServiceSatiation,
      L244.Intgains_scalar = L244.Intgains_scalar,
      L244.ShellConductance_bld = L244.ShellConductance_bld,
      L244.Supplysector_bld = L244.Supplysector_bld,
      L244.FinalEnergyKeyword_bld = L244.FinalEnergyKeyword_bld,
      L244.SubsectorShrwtFllt_bld = L244.SubsectorShrwtFllt_bld,
      L244.SubsectorInterp_bld = L244.SubsectorInterp_bld,
      L244.FuelPrefElast_bld = L244.FuelPrefElast_bld,
      L244.StubTech_bld = L244.StubTech_bld,
      L244.StubTechEff_bld = L244.StubTechEff_bld,
      L244.SubsectorLogit_bld = L244.SubsectorLogit_bld,
      L244.StubTechIntGainOutputRatio = L244.StubTechIntGainOutputRatio,
      L244.HDDCDD_constdd_no_GCM = L244.HDDCDD_constdd_no_GCM,
      L241.fgas_all_units = L241.fgas_all_units,
      L201.nonghg_max_reduction = L201.nonghg_max_reduction,
      L201.nonghg_steepness = L201.nonghg_steepness,
      L241.hfc_future = L241.hfc_future
      )

    write_to_APPEND_CITY_RoT <- function(data){
      data_new <- subset(data, region == "APPEND_REGION") %>%
        repeat_add_columns(tibble(new_region = c("APPEND_CITY", "Rest of APPEND_REGION"))) %>%
        mutate(region = new_region) %>%
        select(-new_region)
      return(data_new)
    }

    S244.list_nochange_data <- lapply(S244.list_nochange_data, FUN = write_to_APPEND_CITY_RoT)

    S244.pop_gdp_share <- L201.Pop_APPEND %>%
      left_join_error_no_match(L201.GDP_APPEND, by = c("region", "year")) %>%
      group_by(year) %>%
      mutate(popshare = totalPop / sum(totalPop),
             gdpshare = GDP / sum(GDP)) %>%
      ungroup() %>%
      select(region, year, popshare, gdpshare)

    downscale_to_APPEND_CITY_RoT <- function(data, share_data, value.column = "value", share.column = "popshare"){
      data_new <- subset(data, region == "APPEND_REGION") %>%
        repeat_add_columns(tibble(new_region = c("APPEND_CITY", "Rest of APPEND_REGION"))) %>%
        mutate(region = new_region) %>%
        select(-new_region) %>%
        left_join_error_no_match(share_data, by = c("region", "year"))
      data_new[[value.column]] = data_new[[value.column]] * data_new[[share.column]]
      data_new <- data_new[names(data)]
      return(data_new)
    }

    S244.Floorspace <- L244.Floorspace %>%
      downscale_to_APPEND_CITY_RoT(share_data = S244.pop_gdp_share, value.column = "base.building.size", share.column = "popshare")

    S244.ThermalBaseService <- L244.ThermalBaseService %>%
      downscale_to_APPEND_CITY_RoT(share_data = S244.pop_gdp_share, value.column = "base.service", share.column = "gdpshare")

    S244.GenericBaseService <- L244.GenericBaseService %>%
      downscale_to_APPEND_CITY_RoT(share_data = S244.pop_gdp_share, value.column = "base.service", share.column = "gdpshare")

    S244.StubTechCalInput_bld <- L244.StubTechCalInput_bld %>%
      downscale_to_APPEND_CITY_RoT(share_data = S244.pop_gdp_share, value.column = "calibrated.value", share.column = "gdpshare")

    S244.pol_emissions_bld_APPEND <- L201.en_pol_emissions %>%
      filter(supplysector %in% L244.Supplysector_bld$supplysector) %>%
      downscale_to_APPEND_CITY_RoT(share_data = S244.pop_gdp_share, value.column = "input.emissions", share.column = "gdpshare")

    S244.ghg_emissions_bld_APPEND <- L201.en_ghg_emissions %>%
      filter(supplysector %in% L244.Supplysector_bld$supplysector) %>%
      downscale_to_APPEND_CITY_RoT(share_data = S244.pop_gdp_share, value.column = "input.emissions", share.column = "gdpshare")

    # Re-compute satiation demand levels in cases where the base-service may now exceed the original assumption of satiation demand limits
    S244.ThermalBaseService %>%
      left_join(S244.Floorspace, by = c("region", "year", "gcam.consumer", "nodeInput", "building.node.input")) %>%
      mutate(service.per.flsp = base.service / base.building.size) %>%
      filter(year == max(MODEL_BASE_YEARS)) %>%
      select(region, gcam.consumer, nodeInput, building.node.input, thermal.building.service.input, year, service.per.flsp) ->
      S244.ThermalBaseServicePerFloorspace

    S244.GenericBaseService %>%
      left_join(S244.Floorspace, by = c("region", "year", "gcam.consumer", "nodeInput", "building.node.input")) %>%
      mutate(service.per.flsp = base.service / base.building.size) %>%
      filter(year == max(MODEL_BASE_YEARS)) %>%
      select(region, gcam.consumer, nodeInput, building.node.input, building.service.input, year, service.per.flsp) ->
      S244.GenericBaseServicePerFloorspace

    S244.list_nochange_data[["L244.ThermalServiceSatiation"]] %>%
      left_join_error_no_match(S244.ThermalBaseServicePerFloorspace,
                               by = c("region", "gcam.consumer", "nodeInput", "building.node.input", "thermal.building.service.input")) %>%
      mutate(satiation.level = if_else(satiation.level < service.per.flsp, service.per.flsp * 1.001, satiation.level)) ->
      S244.list_nochange_data[["L244.ThermalServiceSatiation"]]

    S244.list_nochange_data[["L244.GenericServiceSatiation"]] %>%
      left_join_error_no_match(S244.GenericBaseServicePerFloorspace,
                               by = c("region", "gcam.consumer", "nodeInput", "building.node.input", "building.service.input")) %>%
      mutate(satiation.level = if_else(satiation.level < service.per.flsp, service.per.flsp * 1.001, satiation.level)) ->
      S244.list_nochange_data[["L244.GenericServiceSatiation"]]

    # ===================================================
    # Produce outputs

    S244.DeleteConsumer_APPENDbld %>%
      add_title("Delete gcam-consumer objects for buildings sector in APPEND_REGION", overwrite=TRUE) %>%
      add_units("Unitless") %>%
      add_comments("APPEND_REGION region name hard-wired") %>%
      add_precursors("L244.SubregionalShares") ->
      S244.DeleteConsumer_APPENDbld

    S244.DeleteSupplysector_APPENDbld %>%
      add_title("Delete supplysector objects for buildings sector in APPEND_REGION", overwrite=TRUE) %>%
      add_units("Unitless") %>%
      add_comments("APPEND_REGION region name hard-wired") %>%
      add_precursors("L244.Supplysector_bld") ->
      S244.DeleteSupplysector_APPENDbld

    S244.list_nochange_data[["L244.SubregionalShares"]] %>%
      add_title("Subregional population and income shares", overwrite=TRUE) %>%
      add_units("Unitless") %>%
      add_comments("A44.gcam_consumer written to all regions") %>%
      add_comments("subregional.population.share and subregional.income.share set to 1") %>%
      add_precursors("L244.SubregionalShares") ->
      S244.SubregionalShares

    S244.list_nochange_data[["L244.PriceExp_IntGains"]] %>%
      add_title("Price exponent on floorspace and naming of internal gains trial markets", overwrite=TRUE) %>%
      add_units("Unitless") %>%
      add_comments("A44.gcam_consumer written to all regions") %>%
      add_precursors("L244.PriceExp_IntGains") ->
      S244.PriceExp_IntGains

    S244.Floorspace %>%
      add_title("Base year floorspace", overwrite=TRUE) %>%
      add_units("billion m2") %>%
      add_comments("Downscaled") %>%
      add_precursors("L244.Floorspace", "L201.Pop_APPEND", "L201.GDP_APPEND") ->
      S244.Floorspace

      S244.list_nochange_data[["L244.DemandFunction_serv"]] %>%
      add_title("Demand function for building service", overwrite=TRUE) %>%
      add_units("NA") %>%
      add_comments("A44.demandFn_serv written to all regions") %>%
      add_comments("can be multiple lines") %>%
      add_precursors("L244.DemandFunction_serv") ->
      S244.DemandFunction_serv

    S244.list_nochange_data[["L244.DemandFunction_flsp"]] %>%
      add_title("Demand function for building floorspace", overwrite=TRUE) %>%
      add_units("NA") %>%
      add_comments("A44.demandFn_flsp written to all regions") %>%
      add_comments("can be multiple lines") %>%
      add_precursors("L244.DemandFunction_flsp") ->
      S244.DemandFunction_flsp

    S244.list_nochange_data[["L244.Satiation_flsp"]] %>%
      add_title("Floorspace demand satiation", overwrite=TRUE) %>%
      add_units("Million squared meters per capita") %>%
      add_comments("Values from A44.satiation_flsp added to A44.gcam_consumer written to all regions") %>%
      add_precursors("L244.Satiation_flsp") ->
      S244.Satiation_flsp

    S244.list_nochange_data[["L244.SatiationAdder"]] %>%
      add_title("Satiation adders in floorspace demand function", overwrite=TRUE) %>%
      add_units("Unitless") %>%
      add_comments("Satiation adder compute using satiation level, per-capita GDP and per-capita floorsapce") %>%
      add_precursors("L244.SatiationAdder") ->
      S244.SatiationAdder

    S244.ThermalBaseService %>%
      add_title("Historical building heating and cooling energy output", overwrite=TRUE) %>%
      add_units("EJ/yr") %>%
      add_comments("L144.base_service_EJ_serv rounded and renamed") %>%
      add_precursors("L244.ThermalBaseService", "L201.Pop_APPEND", "L201.GDP_APPEND") ->
      S244.ThermalBaseService

    S244.GenericBaseService %>%
      add_title("Historical building `other` energy output", overwrite=TRUE) %>%
      add_units("EJ/yr") %>%
      add_comments("L144.base_service_EJ_serv rounded and renamed") %>%
      add_precursors("L244.GenericBaseService", "L201.Pop_APPEND", "L201.GDP_APPEND") ->
      S244.GenericBaseService

    S244.list_nochange_data[["L244.ThermalServiceSatiation"]] %>%
      add_title("Satiation levels for thermal building services", overwrite=TRUE) %>%
      add_units("EJ/billion m2 floorspace") %>%
      add_comments("For USA, calculate satiation level as base year service / base year floorspace times multiplier") %>%
      add_comments("USA values written to all regions, which are multiplied by ratio of degree days in each region to degree days in USA") %>%
      add_comments("then we make sure that no satiation level is below base year service per floorspace") %>%
      add_precursors("L244.ThermalServiceSatiation") ->
      S244.ThermalServiceSatiation

    S244.list_nochange_data[["L244.GenericServiceSatiation"]] %>%
      add_title("Satiation levels for non-thermal building services", overwrite=TRUE) %>%
      add_units("EJ/billion m2 floorspace") %>%
      add_comments("For USA, calculate satiation level as base year service / base year floorspace times multiplier") %>%
      add_comments("USA values written to all regions, then we make sure that no satiation level is below base year service per floorspace") %>%
      add_precursors("L244.GenericServiceSatiation") ->
      S244.GenericServiceSatiation

    S244.list_nochange_data[["L244.Intgains_scalar"]] %>%
      add_title("Scalers relating internal gain energy to increased/reduced cooling/heating demands", overwrite=TRUE) %>%
      add_units("Unitless") %>%
      add_comments("USA base scalar assumption multiplied by ratio of degree days to USA degree days") %>%
      add_precursors("L244.Intgains_scalar") ->
      S244.Intgains_scalar

      S244.list_nochange_data[["L244.ShellConductance_bld"]] %>%
      add_title("Shell conductance (inverse of shell efficiency)", overwrite=TRUE) %>%
      add_units("Unitless") %>%
      add_comments("Shell conductance from L144.shell_eff_R_Y") %>%
      add_precursors("L244.ShellConductance_bld") ->
      S244.ShellConductance_bld

    S244.list_nochange_data[["L244.Supplysector_bld"]] %>%
      add_title("Supplysector info for buildings", overwrite=TRUE) %>%
      add_units("NA") %>%
      add_comments("A44.sector written to all regions") %>%
      add_precursors("L244.Supplysector_bld") ->
      S244.Supplysector_bld

    S244.list_nochange_data[["L244.FinalEnergyKeyword_bld"]] %>%
      add_title("Supply sector keywords for detailed building sector", overwrite=TRUE) %>%
      add_units("NA") %>%
      add_comments("A44.sector written to all regions") %>%
      add_precursors("L244.FinalEnergyKeyword_bld") ->
      S244.FinalEnergyKeyword_bld

    S244.list_nochange_data[["L244.SubsectorShrwtFllt_bld"]] %>%
        add_title("Subsector shareweights for building sector", overwrite=TRUE) %>%
        add_units("Unitless") %>%
        add_comments("A44.subsector_shrwt written to all regions") %>%
        add_precursors("L244.SubsectorShrwtFllt_bld") ->
        S244.SubsectorShrwtFllt_bld

    S244.list_nochange_data[["L244.SubsectorInterp_bld"]] %>%
        add_title("Subsector shareweight interpolation for building sector", overwrite=TRUE) %>%
        add_units("NA") %>%
        add_comments("A44.subsector_interp written to all regions") %>%
        add_precursors("L244.SubsectorInterp_bld") ->
        S244.SubsectorInterp_bld

    S244.list_nochange_data[["L244.SubsectorLogit_bld"]] %>%
      add_title("Subsector logit exponents of building sector", overwrite=TRUE) %>%
      add_units("Unitless") %>%
      add_comments("A44.subsector_logit written to all regions") %>%
      add_precursors("L244.SubsectorLogit_bld") ->
      S244.SubsectorLogit_bld

    S244.list_nochange_data[["L244.FuelPrefElast_bld"]] %>%
      add_title("Fuel preference elasticities for buildings", overwrite=TRUE) %>%
      add_units("Unitless") %>%
      add_comments("A44.fuelprefElasticity written to all regions") %>%
      add_precursors("L244.FuelPrefElast_bld") ->
      S244.FuelPrefElast_bld

    S244.list_nochange_data[["L244.StubTech_bld"]] %>%
      add_title("Identification of stub technologies for buildings", overwrite=TRUE) %>%
      add_units("NA") %>%
      add_comments("Technologies from L144.end_use_eff") %>%
      add_precursors("L244.StubTech_bld") ->
      S244.StubTech_bld

    S244.list_nochange_data[["L244.StubTechEff_bld"]] %>%
      add_title("Assumed efficiencies of buildings technologies", overwrite=TRUE) %>%
      add_units("Unitless efficiency") %>%
      add_comments("Efficiencies taken from L144.end_use_eff") %>%
      add_precursors("L244.StubTechEff_bld") ->
      S244.StubTechEff_bld

    S244.StubTechCalInput_bld %>%
      add_title("Calibrated energy consumption by buildings technologies", overwrite=TRUE) %>%
      add_units("calibrated.value: EJ; shareweights: Unitless") %>%
      add_comments("Calibrated values directly from L144.in_EJ_R_bld_serv_F_Yh") %>%
      add_comments("Shareweights are 1 if subsector/technology total is non-zero, 0 otherwise") %>%
      add_precursors("L244.StubTechCalInput_bld", "L201.Pop_APPEND", "L201.GDP_APPEND") ->
      S244.StubTechCalInput_bld

    S244.list_nochange_data[["L244.StubTechIntGainOutputRatio"]] %>%
      add_title("Output ratios of internal gain energy from non-thermal building services", overwrite=TRUE) %>%
      add_units("Unitless output ratio") %>%
      add_comments("Values from L144.internal_gains") %>%
      add_precursors("L244.StubTechIntGainOutputRatio") ->
      S244.StubTechIntGainOutputRatio

    S244.list_nochange_data[["L244.HDDCDD_constdd_no_GCM"]] %>%
      add_title("HDD and CDD (constant)", overwrite=TRUE) %>%
      add_units("degree days") %>%
      add_comments("Copied") %>%
      add_precursors("L244.HDDCDD_constdd_no_GCM") ->
      S244.HDDCDD_constdd_no_GCM

    S244.list_nochange_data[["L241.fgas_all_units"]] %>%
      add_title("Units of f-gas emissions from buildings in City and rest-of-Region", overwrite=TRUE) %>%
      add_units("Specified in table") %>%
      add_comments("Copied") %>%
      add_precursors("L241.fgas_all_units") ->
      S244.fgas_all_units_bld_APPEND

    S244.list_nochange_data[["L201.nonghg_max_reduction"]] %>%
      add_title("max-reduction of pollutant emissions from buildings in City and rest-of-Region", overwrite=TRUE) %>%
      add_units("Percent") %>%
      add_comments("Copied") %>%
      add_precursors("L201.nonghg_max_reduction") ->
      S244.nonghg_max_reduction_bld_APPEND

    S244.list_nochange_data[["L201.nonghg_steepness"]] %>%
      add_title("steepness of pollutant emissions from buildings in City and rest-of-Region", overwrite=TRUE) %>%
      add_units("Unitless") %>%
      add_comments("Copied") %>%
      add_precursors("L201.nonghg_steepness") ->
      S244.nonghg_steepness_bld_APPEND

    S244.list_nochange_data[["L241.hfc_future"]] %>%
      add_title("emissions coefficients of f-gases from buildings in City and rest-of-Region", overwrite=TRUE) %>%
      add_units("g f-gas per GJ of building energy service") %>%
      add_comments("Copied") %>%
      add_precursors("L241.hfc_future") ->
      S244.hfc_future_bld_APPEND

    S244.pol_emissions_bld_APPEND %>%
      add_title("pollutant emissions from City and rest-of-Region buildings", overwrite=TRUE) %>%
      add_units("Tg/yr") %>%
      add_comments("downscaled from APPEND_REGION using GDP shares") %>%
      add_precursors("L201.en_pol_emissions") ->
      S244.pol_emissions_bld_APPEND

    S244.ghg_emissions_bld_APPEND %>%
      add_title("greenhouse gas emissions from City and rest-of-Region buildings", overwrite=TRUE) %>%
      add_units("Tg/yr") %>%
      add_comments("downscaled from APPEND_REGION using GDP shares") %>%
      add_precursors("L201.en_ghg_emissions") ->
      S244.ghg_emissions_bld_APPEND

    return_data(S244.DeleteConsumer_APPENDbld,
                S244.DeleteSupplysector_APPENDbld,
                S244.SubregionalShares,
                S244.PriceExp_IntGains,
                S244.Floorspace,
                S244.DemandFunction_serv,
                S244.DemandFunction_flsp,
                S244.Satiation_flsp,
                S244.SatiationAdder,
                S244.ThermalBaseService,
                S244.GenericBaseService,
                S244.ThermalServiceSatiation,
                S244.GenericServiceSatiation,
                S244.Intgains_scalar,
                S244.ShellConductance_bld,
                S244.Supplysector_bld,
                S244.FinalEnergyKeyword_bld,
                S244.SubsectorShrwtFllt_bld,
                S244.SubsectorInterp_bld,
                S244.FuelPrefElast_bld,
                S244.StubTech_bld,
                S244.StubTechEff_bld,
                S244.StubTechCalInput_bld,
                S244.SubsectorLogit_bld,
                S244.StubTechIntGainOutputRatio,
                S244.HDDCDD_constdd_no_GCM,
                S244.fgas_all_units_bld_APPEND,
                S244.nonghg_max_reduction_bld_APPEND,
                S244.nonghg_steepness_bld_APPEND,
                S244.hfc_future_bld_APPEND,
                S244.pol_emissions_bld_APPEND,
                S244.ghg_emissions_bld_APPEND)
  } else {
    stop("Unknown command")
  }
}

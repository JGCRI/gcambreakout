# Copyright 2019 Battelle Memorial Institute; see the LICENSE file.

#' module_emissions_L241.fgas
#'
#' Format fgases emission inputs for GCAM and estimates future emission factors for f gases for the SSP scenarios.
#'
#' @param command API command to execute
#' @param ... other optional parameters, depending on command
#' @return Depends on \code{command}: either a vector of required inputs,
#' a vector of output names, or (if \code{command} is "MAKE") all
#' the generated outputs: \code{L241.hfc_all}, \code{L241.pfc_all}, \code{L241.hfc_future}, \code{L241.fgas_all_units}. The corresponding file in the
#' original data system was \code{L241.fgas.R} (emissions level2).
#' @details Formats hfc and pfc gas emissions for input. Calculates future emission factors for hfc gases based on 2010 region emissions and USA emission factors and emission factors from Guus Velders (http://www.sciencedirect.com/science/article/pii/S135223101530488X) for the  SSP scenarios.
#' @importFrom assertthat assert_that
#' @importFrom dplyr bind_rows filter if_else group_by left_join mutate select
#' @importFrom tidyr gather spread
#' @author KD July 2017
module_emissions_L241.fgas <- function(command, ...) {
  if(command == driver.DECLARE_INPUTS) {
    return(c(FILE = "common/GCAM_region_names",
             FILE = "emissions/A_regions",
             FILE = "emissions/FUT_EMISS_GV",
             "L141.hfc_R_S_T_Yh",
             "L141.hfc_ef_R_cooling_Yh",
             "L142.pfc_R_S_T_Yh"))
  } else if(command == driver.DECLARE_OUTPUTS) {
    return(c("L241.hfc_all",
             "L241.pfc_all",
             "L241.hfc_future",
             "L241.fgas_all_units"))
  } else if(command == driver.MAKE) {

    all_data <- list(...)[[1]]

    # Load required inputs
    GCAM_region_names <- get_data(all_data, "common/GCAM_region_names")
    A_regions         <- get_data(all_data, "emissions/A_regions")
    FUT_EMISS_GV      <- get_data(all_data, "emissions/FUT_EMISS_GV")
    L142.pfc_R_S_T_Yh <- get_data(all_data, "L142.pfc_R_S_T_Yh")
    L141.hfc_R_S_T_Yh <- get_data(all_data, "L141.hfc_R_S_T_Yh")
    L141.hfc_ef_R_cooling_Yh <- get_data(all_data, "L141.hfc_ef_R_cooling_Yh")

    ## silence package check.
    . <- `2010` <- `2020` <- `2030` <- EF <- Emissions <- GCAM_region_ID <- GDP <-
      Non.CO2 <- Ratio_2020 <- Ratio_2030 <- Scenario <- Species <- USA_factor <-
      Year <- curr_table <- emiss.coeff <- input.emissions <- region <-
      stub.technology <- subsector <- supplysector <- value <- year <- NULL

    # ===================================================
    # Format and round emission values for HFC gas emissions for technologies in all regions.
    L141.hfc_R_S_T_Yh %>%
      filter(year %in% MODEL_BASE_YEARS) %>%
      left_join_error_no_match(GCAM_region_names, by = "GCAM_region_ID") %>%
      mutate(input.emissions = round(value, emissions.DIGITS_EMISSIONS)) %>%
      select(-GCAM_region_ID, -value) ->
      L241.hfc_all

    # L241.pfc: F-gas emissions for technologies in all regions.
    #
    # Remove anything that's zero in all base years for any technology, because no future
    # coefs are read in for any techs.
    #
    # Then round future gas emissions and format the data frame.
    L142.pfc_R_S_T_Yh %>%
      group_by(GCAM_region_ID, supplysector, subsector, stub.technology, Non.CO2) %>%
      filter(sum(value) != 0, year %in% MODEL_BASE_YEARS) %>%
      mutate(input.emissions = round(value, emissions.DIGITS_EMISSIONS), year = as.numeric(year)) %>%
      ungroup() %>%
      left_join_error_no_match(GCAM_region_names, by = "GCAM_region_ID") %>%
      select(-GCAM_region_ID, -value) ->
      L241.pfc_all


    # F-gas emissions factors for future years
    #
    # First, create a subset of the cooling emission factors from 2010.
    # (Update 11 Aug 2017: subset the last HFC_MODEL_BASE_YEARS present in data, letting us pass timeshift test.)
    # Eventually these values will be used to estimate future emission factors by scaling with
    # USA emission factors.
    L141.hfc_ef_R_cooling_Yh %>%
      filter(year == max(intersect(year, emissions.HFC_MODEL_BASE_YEARS))) %>%
      left_join_error_no_match(GCAM_region_names, by = "GCAM_region_ID") ->
      L141.hfc_ef_cooling_2010


    # From the 2010 hfc cooling emission factors select USA emission factors, in
    # subsequent steps the USA emission factors will be used to estimate future
    # emission factors.
    L141.hfc_ef_cooling_2010 %>%
      filter(region == gcam.USA_REGION) %>%
      select(USA_factor = value, -region, year, Non.CO2, supplysector) ->
      L141.hfc_ef_cooling_2010_USA


    # Match USA cooling hfc emissions factors from by sector and gas with 2010
    # emission factors for other regions. Eventually the USA factor emissions will
    # be used to interpolate future emission factors for the other regions.
    #
    # But first correct the USA factor emissions for HFC134a by dividing by three
    # since it is less commonly used now in USA.
    L141.hfc_ef_cooling_2010 %>%
      left_join_error_no_match(L141.hfc_ef_cooling_2010_USA, by = c("supplysector", "Non.CO2", "year")) %>%
      mutate(USA_factor = if_else(Non.CO2 == "HFC134a", USA_factor / 3, USA_factor)) ->
      L241.hfc_cool_ef_2010_USfactor


    # Format the data frame of 2010 regional emission factors and 2010 USA emission factors
    # for the next step where future emission factors are calculated.
    #
    # Future emission factors are will not be calculated for regions with 2010 emission factors
    # greater than the 2010 USA emission factor because of the way that the calculated as a
    # fraction of the change between the region and USA 2010 emission factors, negative emission
    # factors would be estimated.
    L241.hfc_cool_ef_2010_USfactor %>%
      filter(USA_factor > value) %>%
      rename(`2010` = value, `2030` = USA_factor) %>%
      select(-year) ->
      L241.hfc_cool_ef_update

    # Linearlly interpolate future regional emission factors from 2010 emission factor and
    # the 2010 USA emission facor.
    L241.hfc_cool_ef_update %>%
      mutate(`2015` = NA, `2020` = NA, `2025` = NA) %>%
      gather_years %>%
      group_by(GCAM_region_ID, supplysector, subsector, stub.technology, Non.CO2) %>%
      mutate(value = approx_fun(as.numeric(year), value)) %>%
      spread(year, value) ->
      L241.hfc_cool_ef_update_all

    # Subset the future emission factors for the hfc model base years.
    #
    # These emission factors will be used in a ratio to compare
    # future emission factors.
    L241.hfc_cool_ef_update_all %>%
      gather_years %>%
      filter(!year %in% emissions.HFC_MODEL_BASE_YEARS) ->
      L241.hfc_cool_ef_update_filtered


    # Estimate future emission for non-cooling emissions.
    #
    # First, subset the hfc emissions for non-cooling emissions.
    L141.hfc_R_S_T_Yh %>%
      filter(!supplysector %in% c("resid cooling", "comm cooling")) %>%
      # EF is 1000 x emissions for non-cooling sectors
      mutate(value = value * 1000) %>%
      filter(year == max(emissions.HFC_MODEL_BASE_YEARS)) %>%
      filter(value > 0) %>%
      left_join_error_no_match(GCAM_region_names, by = "GCAM_region_ID") ->
      L241.hfc_ef_2010

    # Use data from Guus Velders (a f-gas expert) of near future f gas
    # emissions to calculate the future to 2010 emission factor ratios.
    # These emission factor ratios will be used to update the non-cooling
    # emission factors.
    #
    # Format the FUT_EMISS_GV species by removing the "-" so that the species
    # can be used to join the FUT_EMISS_GV emission factors with L241.hfc_ef_2010
    # in the next step.
    FUT_EMISS_GV %>%
      select(-Emissions, -GDP) %>%
      spread(Year, EF) %>%
      select(Species, Scenario, `2010`, `2020`, `2030`) %>%
      mutate(Species = gsub("-", "", Species ),
             Ratio_2020 = `2020` / `2010`,
             Ratio_2030 =  `2030` / `2010`,
             Species = gsub("-", "", Species))->
      L241.FUT_EF_Ratio

    # Use the future emission factor ratios to update/scale the non-cooling
    # emission factors.
    L241.hfc_ef_2010 %>%
      # Since Guus Velders data set contains information on extra gases we can use left_join here because we expect there to be NAs that will latter be removed.
      left_join(L241.FUT_EF_Ratio, by = c("Non.CO2" = "Species")) %>%
      mutate(`2020` = value * Ratio_2020,
             `2030` = value * Ratio_2030) %>%
      select(-Ratio_2020, -Ratio_2030, -Scenario) %>%
      na.omit() ->
      L241.hfc_ef_2010_update

    # Format the updated non-cooling emission factors.
    L241.hfc_ef_2010_update %>%
      select(-year, -value, -`2010`) %>%
      gather_years %>%
      filter(!year %in% emissions.HFC_MODEL_BASE_YEARS) ->
      L241.hfc_ef_2010_update_all

    # Combine the updated cooling and non-cooling hfc gas emission
    # factor data frames together.
    L241.hfc_ef_2010_update_all %>%
      bind_rows(L241.hfc_cool_ef_update_filtered) %>%
      mutate(emiss.coeff = round(value, emissions.DIGITS_EMISSIONS),
             year = as.numeric(year)) %>%
      select(region, supplysector, subsector, stub.technology, year, Non.CO2, emiss.coeff) ->
      L241.hfc_future

    # Now subset only the relevant technologies and gases (i.e., drop ones whose values are zero in all years).
    L241.hfc_all %>%
      group_by(region, supplysector, subsector, stub.technology, Non.CO2) %>%
      filter(sum(input.emissions) != 0, year %in% MODEL_BASE_YEARS) %>%
      mutate(year = as.numeric(year)) %>%
      ungroup ->
      L241.hfc_all

    #..................................
    #### Zarrar Khan Edit: 7 Jan 2022 (zarrar.khan@pnnl.gov)
    # Adding in missing countries and regions

    #L241.hfc_all
    L241.hfc_all_missing_gcam_regions <-
      unique(GCAM_region_names$region)[!unique(GCAM_region_names$region) %in%
                                         unique(L241.hfc_all$region)]

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

    # L241.pfc_all
    L241.pfc_all_missing_gcam_regions <-
      unique(GCAM_region_names$region)[!unique(GCAM_region_names$region) %in%
                                         unique(L241.pfc_all$region)]

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

    # L241.hfc_future
    L241.hfc_future_missing_gcam_regions <-
      unique(GCAM_region_names$region)[!unique(GCAM_region_names$region) %in%
                                         unique(L241.hfc_future$region)]

    missing_regions_df <- L241.hfc_future %>%
      dplyr::select(-region) %>%
      dplyr::mutate(emiss.coeff=0) %>%
      unique() %>%
      merge(data.frame(region=L241.hfc_future_missing_gcam_regions))


    L241.hfc_future %>%
      bind_rows(missing_regions_df) %>%
      replace_na(list(emiss.coeff = 0)) %>%
      unique()->
      L241.hfc_future
    #......................................

    # Set the units string for the hfc and pfc gases.
    L241.pfc_all %>%
      bind_rows(L241.hfc_all) %>%
      bind_rows(L241.hfc_future) %>%
      select(region, supplysector, subsector, stub.technology, year, Non.CO2) %>%
      mutate(emissions.unit = emissions.F_GAS_UNITS) %>%
      unique() ->
      L241.fgas_all_units

    # ===================================================

    L241.hfc_all %>%
      add_title("HFC gas emission input table") %>%
      add_units("Gg") %>%
      add_comments("Emission values from L1 rounded to the appropriate digits.") %>%
      add_legacy_name("L241.hfc_all") %>%
      add_precursors("common/GCAM_region_names", "emissions/A_regions", "emissions/FUT_EMISS_GV",
                     "L141.hfc_R_S_T_Yh", "L142.pfc_R_S_T_Yh",
                     "L141.hfc_ef_R_cooling_Yh") ->
      L241.hfc_all

    L241.pfc_all %>%
      add_title("PFC gas emission input table") %>%
      add_units("Gg") %>%
      add_comments("Emission values from L1 are rounded to the appropriate digits.") %>%
      add_legacy_name("L241.pfc_all") %>%
      add_precursors("common/GCAM_region_names", "emissions/A_regions", "emissions/FUT_EMISS_GV",
                     "L141.hfc_R_S_T_Yh", "L142.pfc_R_S_T_Yh",
                     "L141.hfc_ef_R_cooling_Yh") ->
      L241.pfc_all

    L241.hfc_future %>%
      add_title("Future HFC emission factors") %>%
      add_units("Gg") %>%
      add_comments("Cooling future emission factors are calculated from 2010 USA emission factors.") %>%
      add_comments("Non-cooling future emission factors are calculated from Guus Velders emission factors.") %>%
      add_legacy_name("L241.hfc_future") %>%
      add_precursors("common/GCAM_region_names", "emissions/A_regions", "emissions/FUT_EMISS_GV",
                     "L141.hfc_R_S_T_Yh", "L142.pfc_R_S_T_Yh",
                     "L141.hfc_ef_R_cooling_Yh") ->
      L241.hfc_future

    L241.fgas_all_units %>%
      add_title("Units for f gases.") %>%
      add_units("Gg") %>%
      add_comments("NA") %>%
      add_legacy_name("L241.fgas_all_units") %>%
      add_precursors("common/GCAM_region_names", "emissions/A_regions", "emissions/FUT_EMISS_GV",
                     "L141.hfc_R_S_T_Yh", "L142.pfc_R_S_T_Yh",
                     "L141.hfc_ef_R_cooling_Yh") ->
      L241.fgas_all_units

    return_data(L241.hfc_all, L241.pfc_all, L241.hfc_future, L241.fgas_all_units)

  } else {
    stop("Unknown command")
  }
}

# Copyright 2019 Battelle Memorial Institute; see the LICENSE file.

#' module_breakout_X201.socioeconomics_APPEND
#'
#' Population and GDP of City Chosen and Rest of Region
#'
#' @param command API command to execute
#' @param ... other optional parameters, depending on command
#' @return Depends on \code{command}: either a vector of required inputs,
#' a vector of output names, or (if \code{command} is "MAKE") all
#' the generated outputs: \code{L201.InterestRate}, \code{L201.LaborForceFillout}, \code{L201.PPPConvert}, \code{L201.BaseGDP_Scen}, \code{L201.Pop_gSSP1}, \code{L201.Pop_gSSP2}, \code{L201.Pop_gSSP3}, \code{L201.Pop_gSSP4}, \code{L201.Pop_gSSP5}, \code{L201.Pop_SSP1}, \code{L201.Pop_SSP2}, \code{L201.Pop_SSP3}, \code{L201.Pop_SSP4}, \code{L201.Pop_SSP5}, \code{L201.LaborProductivity_gSSP1}, \code{L201.LaborProductivity_gSSP2}, \code{L201.LaborProductivity_gSSP3}, \code{L201.LaborProductivity_gSSP4}, \code{L201.LaborProductivity_gSSP5}, \code{L201.LaborProductivity_SSP1}, \code{L201.LaborProductivity_SSP2}, \code{L201.LaborProductivity_SSP3}, \code{L201.LaborProductivity_SSP4}, and \code{L201.LaborProductivity_SSP5}. The corresponding file in the
#' original data system was \code{L201.Pop_GDP_scenarios.R} (socioeconomics level2).
#' @details Produces default interest rate by region, historical and future population by region and SSP scenario,
#' and uses per-capita GDP to calculate labor productivity by region and scenario.
#' @importFrom assertthat assert_that
#' @importFrom dplyr bind_rows filter group_by lag mutate order_by select transmute
#' @author PK, ZK & NB April 2021
module_breakout_X201.socioeconomics_APPEND <- function(command, ...) {
  if(command == driver.DECLARE_INPUTS) {
    return(c(FILE = "breakout/APPEND_pop",
             FILE = "breakout/APPEND_pcgdp"))
  } else if(command == driver.DECLARE_OUTPUTS) {
    return(c("X201.Pop_APPEND",
             "X201.BaseGDP_APPEND",
             "X201.LaborForceFillout_APPEND",
             "X201.LaborProductivity_APPEND",
             "X201.GDP_APPEND"))
  } else if(command == driver.MAKE) {

    all_data <- list(...)[[1]]

    totalPop <- population <- year <- NULL  # silence package check notes

    # Load required inputs
    city_pop <- get_data(all_data,"breakout/APPEND_pop", strip_attributes = TRUE)
    city_pcgdp <- get_data(all_data,"breakout/APPEND_pcgdp", strip_attributes = TRUE)

    X201.Pop_APPEND <- city_pop %>%
      complete(nesting(region), year = c(HISTORICAL_YEARS, FUTURE_YEARS)) %>%
      group_by(region) %>%
      mutate(totalPop = round(approx_fun(year, population) * CONV_MIL_THOUS), socioeconomics.POP_DIGITS) %>%
      ungroup() %>%
      filter(year %in% MODEL_YEARS) %>%
      select(LEVEL2_DATA_NAMES[["Pop"]])

    L201.PCGDP_APPEND <- city_pcgdp %>%
      complete(nesting(region), year = c(HISTORICAL_YEARS, FUTURE_YEARS)) %>%
      group_by(region) %>%
      mutate(pcgdp = approx_fun(year, pcgdp) * gdp_deflator(1990, 2005)) %>%
      ungroup() %>%
      filter(year %in% MODEL_YEARS)

    # X201.BaseGDP_APPEND:
    X201.BaseGDP_APPEND <- filter(L201.PCGDP_APPEND, year == min(MODEL_BASE_YEARS)) %>%
      left_join_error_no_match(X201.Pop_APPEND, by = c("region", "year")) %>%
      mutate(baseGDP = round(pcgdp * totalPop, socioeconomics.GDP_DIGITS)) %>%
      select(LEVEL2_DATA_NAMES[["BaseGDP"]])

    X201.LaborForceFillout_APPEND <- X201.BaseGDP_APPEND %>%
      mutate(year.fillout = min(MODEL_BASE_YEARS),
             laborforce = socioeconomics.DEFAULT_LABORFORCE) %>%
      select(LEVEL2_DATA_NAMES[["LaborForceFillout"]])

    X201.LaborProductivity_APPEND <- L201.PCGDP_APPEND %>%
      group_by(region) %>%
      mutate(timestep = year - lag(year),
             pcgdp_ratio = pcgdp / lag(pcgdp),
             laborproductivity = round(pcgdp_ratio ^ (1 / timestep) - 1, socioeconomics.LABOR_PRODUCTIVITY_DIGITS)) %>%
      ungroup() %>%
      drop_na() %>%
      select(LEVEL2_DATA_NAMES[["LaborProductivity"]])

    X201.GDP_APPEND <- left_join_error_no_match(X201.Pop_APPEND, L201.PCGDP_APPEND, by = c("region", "year")) %>%
      mutate(GDP = totalPop * pcgdp) %>%
      select(region, year, GDP)

    # ===================================================

    # Produce outputs
    X201.Pop_APPEND %>%
      add_title("City and rest-of-Region Population") %>%
      add_units("thousand persons") %>%
      add_comments("computed off-line") %>%
      add_precursors("breakout/APPEND_pop") ->
      X201.Pop_APPEND

    X201.BaseGDP_APPEND %>%
      add_title("City and rest-of-Region base GDP") %>%
      add_units("million 1990 USD") %>%
      add_comments("population and GDP of these sub-regions are computed off-line") %>%
      add_precursors("breakout/APPEND_pop","breakout/APPEND_pcgdp") ->
      X201.BaseGDP_APPEND

    X201.LaborForceFillout_APPEND %>%
      add_title("City and rest-of-Region labor force participation rate") %>%
      add_units("unitless") %>%
      add_comments("default value") %>%
      add_precursors("breakout/APPEND_pcgdp") ->
      X201.LaborForceFillout_APPEND

    X201.LaborProductivity_APPEND %>%
      add_title("City and rest-of-Region labor productivity growth rate") %>%
      add_units("unitless") %>%
      add_comments("calculated from per-capita GDP growth rate") %>%
      add_precursors("breakout/APPEND_pop","breakout/APPEND_pcgdp") ->
      X201.LaborProductivity_APPEND

    X201.GDP_APPEND %>%
      add_title("City and rest-of-Region total GDP") %>%
      add_units("million 1990 USD") %>%
      add_comments("calculated from per-capita GDP and population") %>%
      add_precursors("breakout/APPEND_pop", "breakout/APPEND_pcgdp") ->
      X201.GDP_APPEND


    return_data(X201.Pop_APPEND,
                X201.BaseGDP_APPEND,
                X201.LaborForceFillout_APPEND,
                X201.LaborProductivity_APPEND,
                X201.GDP_APPEND)
  } else {
    stop("Unknown command")
  }
}

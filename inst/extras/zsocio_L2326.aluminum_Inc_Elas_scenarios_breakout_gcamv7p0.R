# Copyright 2019 Battelle Memorial Institute; see the LICENSE file.

#' module_socio_L2326.aluminum_Inc_Elas_scenarios
#'
#' Calculates aluminum income elasticity for each GCAM region by linear interpolation of assumption data
#'
#' @param command API command to execute
#' @param ... other optional parameters, depending on command
#' @return Depends on \code{command}: either a vector of required inputs,
#' a vector of output names, or (if \code{command} is "MAKE") all
#' the generated outputs: \code{L2326.aluminum_incelas_gcam3}, \code{object}. The corresponding file in the
#' original data system was \code{L2326.aluminum_Inc_Elas_scenarios.R} (socioeconomics level2).
#' @details Takes per-capita GDP from ssp scenarios in each region.
#' Then calculates aluminum income elasticity for each region by linear interpolation of assumption data.
#' @importFrom assertthat assert_that
#' @importFrom dplyr arrange filter left_join mutate select transmute
#' @importFrom tidyr gather spread
#' @importFrom stats approx
#' @author Yang Liu  Dec 2019
module_socio_L2326.aluminum_Inc_Elas_scenarios <- function(command, ...) {
  if(command == driver.DECLARE_INPUTS) {
    return(c(FILE = "common/GCAM_region_names",
             "L102.pcgdp_thous90USD_Scen_R_Y",
             "L102.pcgdp_thous90USD_GCAM3_R_Y",
             "L101.Pop_thous_Scen_R_Yfut",
             "L101.Pop_thous_R_Yh",
             "L101.Pop_thous_GCAM3_R_Y",
             "L102.gdp_mil90usd_GCAM3_R_Y",
             "L1326.out_Mt_R_aluminum_Yh"))
  } else if(command == driver.DECLARE_OUTPUTS) {
    return(c("L2326.aluminum_incelas_gssp1",
             "L2326.aluminum_incelas_gssp2",
             "L2326.aluminum_incelas_gssp3",
             "L2326.aluminum_incelas_gssp4",
             "L2326.aluminum_incelas_gssp5",
             "L2326.aluminum_incelas_ssp1",
             "L2326.aluminum_incelas_ssp2",
             "L2326.aluminum_incelas_ssp3",
             "L2326.aluminum_incelas_ssp4",
             "L2326.aluminum_incelas_ssp5",
             "L2326.aluminum_incelas_gcam3"))
  } else if(command == driver.MAKE) {

    GCAM_region_ID <- value <- year <- pcgdp_90thousUSD <- scenario <-
      region <- energy.final.demand <- income.elasticity <- . <-
      value.x <- value.y <- sector <- pcgdp_90thousUSD_2015 <- population <-
      a <- b <- m <- per_capita_aluminum <- aluminum_pro <- pcgdp_90thousUSD_before <-
      aluminum_pro_before <- population_before <- aluminum_hist <- inc_elas <- NULL # silence package check.

    all_data <- list(...)[[1]]
    # Load required inputs

    # Load required inputs
    GCAM_region_names <- get_data(all_data, "common/GCAM_region_names")
    L102.pcgdp_thous90USD_Scen_R_Y <- get_data(all_data, "L102.pcgdp_thous90USD_Scen_R_Y", strip_attributes = TRUE) %>%
      ungroup() %>%
      rename(pcgdp_90thousUSD = value) %>%
      mutate(year = as.integer(year)) %>%
      left_join_error_no_match(GCAM_region_names, by = "GCAM_region_ID")

    L102.pcgdp_thous90USD_GCAM3_R_Y <- get_data(all_data, "L102.pcgdp_thous90USD_GCAM3_R_Y", strip_attributes = TRUE) %>%
      ungroup() %>%
      rename(pcgdp_90thousUSD = value) %>%
      mutate(year = as.integer(year)) %>%
      left_join_error_no_match(GCAM_region_names, by = "GCAM_region_ID")

    L101.Pop_thous_R_Yh <- get_data(all_data, "L101.Pop_thous_R_Yh", strip_attributes = TRUE) %>%
      rename(population = value) %>%
      left_join_error_no_match(GCAM_region_names, by = "GCAM_region_ID")

    L101.Pop_thous_Scen_R_Yfut <- get_data(all_data, "L101.Pop_thous_Scen_R_Yfut", strip_attributes = TRUE) %>%
      ungroup() %>%
      rename(population = value) %>%
      mutate(year = as.integer(year)) %>%
      left_join_error_no_match(GCAM_region_names, by = "GCAM_region_ID")

    L101.Pop_thous_GCAM3_R_Y <- get_data(all_data, "L101.Pop_thous_GCAM3_R_Y", strip_attributes = TRUE) %>%
      ungroup() %>%
      rename(population = value) %>%
      mutate(year = as.integer(year)) %>%
      left_join_error_no_match(GCAM_region_names, by = "GCAM_region_ID")

    L102.gdp_mil90usd_GCAM3_R_Y <- get_data(all_data, "L102.gdp_mil90usd_GCAM3_R_Y", strip_attributes = TRUE) %>%
      ungroup() %>%
      rename(pcgdp_90thousUSD = value) %>%
      mutate(year = as.integer(year)) %>%
      left_join_error_no_match(GCAM_region_names, by = "GCAM_region_ID")

    L1326.out_Mt_R_aluminum_Yh <- get_data(all_data, "L1326.out_Mt_R_aluminum_Yh")

    socioeconomics.ALUMINUM_FD_TECH_CHANGE <- 0.005

    # Some functions to calculate the NLIT and some related wrappers to help us fit the
    # A and B parameters by GCAM region to match history.  This will subsequently be used
    # to project demand into the future
    calc_NLIT <- function(GDPpc, a, b, m, t) { a * exp(b/GDPpc)*(1-m)^(t-MODEL_FINAL_BASE_YEAR)}
    # calculate the NLIT at some trial parameter values and generate a scalar error from the
    # observed data which we are trying to minimize
    calc_error_both <- function(par, GDPpc, norm_val, year) { calc = calc_NLIT(GDPpc, par[1], par[2], socioeconomics.ALUMINUM_FD_TECH_CHANGE, year); error = calc - norm_val; return(sum(error * error))}
    # wrap the call to the multi-dimensional optimization solver
    filt_NLIT_nest <- function(data, initial_guess) { out = optim(initial_guess, calc_error_both, NULL, data$pcgdp_90thousUSD, data$norm_val, data$year, method = "BFGS"); return(data %>% mutate(fit_a = out$par[1], fit_b = out$par[2]))}

    # Combine historical consumption, population, and GDP data to fit the NLIT
    L1326.out_Mt_R_aluminum_Yh %>%
      filter(sector == "Aluminum", year %in% HISTORICAL_YEARS) %>%
      rename(consumption = value) %>%
      left_join_error_no_match(L101.Pop_thous_R_Yh, by=c("GCAM_region_ID", "year")) %>%
      left_join_error_no_match(L102.pcgdp_thous90USD_Scen_R_Y %>% filter(scenario == "gSSP2"), by=c("GCAM_region_ID", "year")) %>%
      mutate(cons_pc = consumption / population * CONV_BIL_THOUS) %>%
      group_by(GCAM_region_ID) %>%
      # we will fit normalized values so that we can come up with reasonable initial guess
      # for the parameter values
      mutate(norm_fac = max(cons_pc),
             norm_val = cons_pc / norm_fac) %>%
      ungroup() %>%
      tidyr::nest(data = -GCAM_region_ID) %>%
      mutate(data = lapply(data, filt_NLIT_nest, c(1.1, -5))) %>%
      tidyr::unnest(data) %>%
      # Note: I could probably have summarized / simplified earlier instead of using
      # a distinct as a last step, however it was useful to calculate the NLIT to
      # double check the fits as follows:
      # mutate(nlit = calc_NLIT(pcgdp_90thousUSD, fit_a, fit_b, socioeconomics.ALUMINUM_FD_TECH_CHANGE, year) * norm_fac) %>%
      distinct(GCAM_region_ID, norm_fac, fit_a, fit_b) ->
      NLIT_params_fit

    # ===================================================
    # Create one population dataset to pass timeshift tests
    # This is required because L101.Pop_thous_Scen_R_Yfut uses FUTURE_YEARS,
    # but here we want to create a dataset from MODEL_FUTURE_YEARS, which may start before FUTURE_YEARS
    L101_Pop_hist_and_fut <- L101.Pop_thous_R_Yh %>%
      repeat_add_columns(distinct(L101.Pop_thous_Scen_R_Yfut, scenario)) %>%
      bind_rows(L101.Pop_thous_Scen_R_Yfut)

    #First calculate the per capita aluminum consumption
    L2326.pcgdp_thous90USD_Scen_R_Y  <- L102.pcgdp_thous90USD_Scen_R_Y %>%
      filter(year %in%  c(MODEL_FINAL_BASE_YEAR, MODEL_FUTURE_YEARS)) %>%
      left_join_error_no_match(L101_Pop_hist_and_fut, by = c("scenario", "GCAM_region_ID", "year", "region")) %>%
      # NOTE the left_join, this is because not all regions have aluminum demands!
      # the left join here will be dropping the regions which do not and will never have
      # any aluminum demands.
      left_join(NLIT_params_fit, ., by = c( "GCAM_region_ID")) %>%
      # next calculate the NLIT for each of the socio-economic scenarios
      mutate(per_capita_aluminum = calc_NLIT(pcgdp_90thousUSD, fit_a, fit_b, socioeconomics.ALUMINUM_FD_TECH_CHANGE, year) * norm_fac,
             aluminum_pro = per_capita_aluminum * population/CONV_BIL_THOUS) %>%
      group_by(scenario, GCAM_region_ID, region) %>%
      # convert to relative change in demand per change in perCapita income
      mutate(service_ratio = aluminum_pro / lag(aluminum_pro),
             income_ratio = pcgdp_90thousUSD / lag(pcgdp_90thousUSD),
             pop_ratio = population / lag(population)) %>%
      ungroup() %>%
      filter(year > MODEL_FINAL_BASE_YEAR) %>%
      # and finally back calculate the income elasticity
      mutate(income.elasticity = log(service_ratio / pop_ratio)/log(income_ratio),
             energy.final.demand = "aluminum") %>%
      select(scenario, region, year, energy.final.demand, income.elasticity)

    # Split by scenario and remove scenario column from each tibble
    L2326.pcgdp_thous90USD_Scen_R_Y <- L2326.pcgdp_thous90USD_Scen_R_Y %>%
      split(.$scenario) %>%
      lapply(function(df) {select(df, -scenario) %>%
          add_units("Unitless (% change in service demand / % change in income)") %>%
          add_comments("Uses previously calculated per-capita GDP assumptions for all ssp scenarios") %>%
          add_comments("aluminum income elasticity for each GCAM region generated by linear interpolation of assumption data") %>%
          add_precursors("common/GCAM_region_names", "L102.pcgdp_thous90USD_Scen_R_Y") })

    ####Cal gcam3
    #First calculate the per capita aluminum consumption
    L2326.aluminum_incelas_gcam3  <- L102.gdp_mil90usd_GCAM3_R_Y%>%
      filter(year %in%  c(MODEL_FINAL_BASE_YEAR, MODEL_FUTURE_YEARS)) %>%
      left_join_error_no_match(L101.Pop_thous_GCAM3_R_Y, by = c("GCAM_region_ID", "year", "region")) %>%
      # NOTE the left_join, this is because not all regions have aluminum demands!
      # the left join here will be dropping the regions which do not and will never have
      # any aluminum demands.
      left_join(NLIT_params_fit, ., by = c( "GCAM_region_ID")) %>%
      # next calculate the NLIT for each of the socio-economic scenarios
      mutate(per_capita_aluminum = calc_NLIT(pcgdp_90thousUSD, fit_a, fit_b, socioeconomics.ALUMINUM_FD_TECH_CHANGE, year) * norm_fac,
             aluminum_pro = per_capita_aluminum * population/CONV_BIL_THOUS) %>%
      group_by(GCAM_region_ID, region) %>%
      # convert to relative change in demand per change in perCapita income
      mutate(service_ratio = aluminum_pro / lag(aluminum_pro),
             income_ratio = pcgdp_90thousUSD / lag(pcgdp_90thousUSD),
             pop_ratio = population / lag(population)) %>%
      ungroup() %>%
      filter(year > MODEL_FINAL_BASE_YEAR) %>%
      # and finally back calculate the income elasticity
      mutate(income.elasticity = log(service_ratio / pop_ratio)/log(income_ratio),
             energy.final.demand = "aluminum") %>%
      select(region, year, energy.final.demand, income.elasticity)

    # ===================================================

    # Produce outputs
    L2326.pcgdp_thous90USD_Scen_R_Y[["gSSP1"]] %>%
      add_title("aluminum Income Elasticity: gssp1") %>%
      add_legacy_name("L2326.aluminum_incelas_gssp1")%>%
      add_precursors("L102.pcgdp_thous90USD_Scen_R_Y","L101.Pop_thous_Scen_R_Yfut", "L101.Pop_thous_R_Yh") ->
      L2326.aluminum_incelas_gssp1

    L2326.pcgdp_thous90USD_Scen_R_Y[["gSSP2"]] %>%
      add_title("aluminum Income Elasticity: gssp2") %>%
      add_legacy_name("L2326.aluminum_incelas_gssp2")%>%
      same_precursors_as(L2326.aluminum_incelas_gssp1) ->
      L2326.aluminum_incelas_gssp2

    L2326.pcgdp_thous90USD_Scen_R_Y[["gSSP3"]] %>%
      add_title("aluminum Income Elasticity: gssp3") %>%
      add_legacy_name("L2326.aluminum_incelas_gssp3") ->
      L2326.aluminum_incelas_gssp3

    L2326.pcgdp_thous90USD_Scen_R_Y[["gSSP4"]] %>%
      add_title("aluminum Income Elasticity: gssp4") %>%
      add_legacy_name("L2326.aluminum_incelas_gssp4")%>%
      same_precursors_as(L2326.aluminum_incelas_gssp1) ->
      L2326.aluminum_incelas_gssp4

    L2326.pcgdp_thous90USD_Scen_R_Y[["gSSP5"]] %>%
      add_title("aluminum Income Elasticity: gssp5") %>%
      add_legacy_name("L2326.aluminum_incelas_gssp5")%>%
      same_precursors_as(L2326.aluminum_incelas_gssp1) ->
      L2326.aluminum_incelas_gssp5

    L2326.pcgdp_thous90USD_Scen_R_Y[["SSP1"]] %>%
      add_title("aluminum Income Elasticity: ssp1") %>%
      add_legacy_name("L2326.aluminum_incelas_ssp1")%>%
      same_precursors_as(L2326.aluminum_incelas_gssp1) ->
      L2326.aluminum_incelas_ssp1

    L2326.pcgdp_thous90USD_Scen_R_Y[["SSP2"]] %>%
      add_title("aluminum Income Elasticity: ssp2") %>%
      add_legacy_name("L2326.aluminum_incelas_ssp2")%>%
      same_precursors_as(L2326.aluminum_incelas_gssp1) ->
      L2326.aluminum_incelas_ssp2

    L2326.pcgdp_thous90USD_Scen_R_Y[["SSP3"]] %>%
      add_title("aluminum Income Elasticity: ssp3") %>%
      add_legacy_name("L2326.aluminum_incelas_ssp3")%>%
      same_precursors_as(L2326.aluminum_incelas_gssp1) ->
      L2326.aluminum_incelas_ssp3

    L2326.pcgdp_thous90USD_Scen_R_Y[["SSP4"]] %>%
      add_title("aluminum Income Elasticity: ssp4") %>%
      add_legacy_name("L2326.aluminum_incelas_ssp4")%>%
      same_precursors_as(L2326.aluminum_incelas_gssp1) ->
      L2326.aluminum_incelas_ssp4

    L2326.pcgdp_thous90USD_Scen_R_Y[["SSP5"]] %>%
      add_title("aluminum Income Elasticity: ssp5") %>%
      add_legacy_name("L2326.aluminum_incelas_ssp5")%>%
      same_precursors_as(L2326.aluminum_incelas_gssp1) ->
      L2326.aluminum_incelas_ssp5

    L2326.aluminum_incelas_gcam3 %>%
      add_title("aluminum Income Elasticity: gcam3") %>%
      add_units("Unitless (% change in service demand / % change in income)") %>%
      add_comments("Uses previously calculated per-capita GDP assumptions of aluminum elastciity") %>%
      add_comments("aluminum income elasticity for each GCAM region generated by linear interpolation of assumption data") %>%
      add_legacy_name("L2326.aluminum_incelas_gcam3") %>%
      add_precursors("common/GCAM_region_names", "L101.Pop_thous_GCAM3_R_Y", "L102.gdp_mil90usd_GCAM3_R_Y",
                     "L1326.out_Mt_R_aluminum_Yh","L102.pcgdp_thous90USD_GCAM3_R_Y") ->
      L2326.aluminum_incelas_gcam3

    return_data(L2326.aluminum_incelas_gssp1,
                L2326.aluminum_incelas_gssp2,
                L2326.aluminum_incelas_gssp3,
                L2326.aluminum_incelas_gssp4,
                L2326.aluminum_incelas_gssp5,
                L2326.aluminum_incelas_ssp1,
                L2326.aluminum_incelas_ssp2,
                L2326.aluminum_incelas_ssp3,
                L2326.aluminum_incelas_ssp4,
                L2326.aluminum_incelas_ssp5,
                L2326.aluminum_incelas_gcam3)
  } else {
    stop("Unknown command")
  }
}

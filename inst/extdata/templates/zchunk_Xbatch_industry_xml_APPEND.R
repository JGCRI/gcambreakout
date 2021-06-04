# Copyright 2019 Battelle Memorial Institute; see the LICENSE file.

#' module_energy_Xbatch_industry_xml_APPEND
#'
#' Construct XML data structure for \code{industry_APPEND}.
#'
#' @param command API command to execute
#' @param ... other optional parameters, depending on command
#' @return Depends on \code{command}: either a vector of required inputs,
#' a vector of output names, or (if \code{command} is "MAKE") all
#' the generated outputs: \code{industry_APPEND}. The corresponding file in the
#' original data system was \code{batch_industry_APPEND} (energy XML).
module_energy_Xbatch_industry_xml_APPEND <- function(command, ...) {
  if(command == driver.DECLARE_INPUTS) {
    return(c("S232.DeleteFinalDemand_APPENDind",
             "S232.DeleteSupplysector_APPENDind",
             "S232.Supplysector_ind",
             "S232.FinalEnergyKeyword_ind",
             "S232.SubsectorLogit_ind",
             "S232.SubsectorShrwtFllt_ind",
             "S232.SubsectorInterp_ind",
             "S232.FuelPrefElast_indenergy",
             "S232.StubTech_ind",
             "S232.StubTechInterp_ind",
             "S232.StubTechCalInput_indenergy",
             "S232.StubTechCalInput_indfeed",
             "S232.StubTechProd_industry",
             "S232.StubTechCoef_industry",
             "S232.PerCapitaBased_ind",
             "S232.IncomeElasticity_ind_gssp2",
             "S232.PriceElasticity_ind",
             "S232.BaseService_ind",
             "S232.UnlimitRsrc_APPEND",
             "S232.UnlimitRsrcPrice_APPEND",
             "S232.Supplysector_indproc_APPEND",
             "S232.SubsectorLogit_ind_APPEND",
             "S232.SubsectorShrwtFllt_ind_APPEND",
             "S232.SubsectorInterp_ind_APPEND",
             "S232.StubTech_ind_APPEND",
             "S232.StubTechCoef_indproc_APPEND",
             "S232.MAC_indproc_APPEND",
             "S232.fgas_all_units_ind_APPEND",
             "S232.nonghg_max_reduction_ind_APPEND",
             "S232.nonghg_steepness_ind_APPEND",
             "S232.hfc_future_ind_APPEND",
             "S232.nonco2_max_reduction_indproc_APPEND",
             "S232.nonco2_steepness_indproc_APPEND",
             "S232.pol_emissions_ind_APPEND",
             "S232.ghg_emissions_ind_APPEND",
             "S232.StubTechMarket_ind_APPEND",
             "S232.StubTechSecMarket_ind_APPEND",
             "S232.nonco2_indproc_APPEND"))
  } else if(command == driver.DECLARE_OUTPUTS) {
    return(c(XML = "industry_APPEND.xml"))
  } else if(command == driver.MAKE) {

    all_data <- list(...)[[1]]

    # Load required inputs
    S232.DeleteFinalDemand_APPENDind <- get_data(all_data, "S232.DeleteFinalDemand_APPENDind")
    S232.DeleteSupplysector_APPENDind <- get_data(all_data, "S232.DeleteSupplysector_APPENDind")
    S232.Supplysector_ind <- get_data(all_data, "S232.Supplysector_ind")
    S232.FinalEnergyKeyword_ind <- get_data(all_data, "S232.FinalEnergyKeyword_ind")
    S232.SubsectorLogit_ind <- get_data(all_data, "S232.SubsectorLogit_ind")
    S232.SubsectorShrwtFllt_ind <- get_data(all_data, "S232.SubsectorShrwtFllt_ind")
    S232.SubsectorInterp_ind <- get_data(all_data, "S232.SubsectorInterp_ind")
    S232.FuelPrefElast_indenergy <- get_data(all_data, "S232.FuelPrefElast_indenergy")
    S232.StubTech_ind <- get_data(all_data, "S232.StubTech_ind")
    S232.StubTechInterp_ind <- get_data(all_data, "S232.StubTechInterp_ind")
    S232.StubTechCalInput_indenergy <- get_data(all_data, "S232.StubTechCalInput_indenergy")
    S232.StubTechCalInput_indfeed <- get_data(all_data, "S232.StubTechCalInput_indfeed")
    S232.StubTechProd_industry <- get_data(all_data, "S232.StubTechProd_industry")
    S232.StubTechCoef_industry <- get_data(all_data, "S232.StubTechCoef_industry")
    S232.PerCapitaBased_ind <- get_data(all_data, "S232.PerCapitaBased_ind")
    S232.IncomeElasticity_ind_gssp2 <- get_data(all_data, "S232.IncomeElasticity_ind_gssp2")
    S232.PriceElasticity_ind <- get_data(all_data, "S232.PriceElasticity_ind")
    S232.BaseService_ind <- get_data(all_data, "S232.BaseService_ind")
    S232.UnlimitRsrc_APPEND <- get_data(all_data, "S232.UnlimitRsrc_APPEND")
    S232.UnlimitRsrcPrice_APPEND <- get_data(all_data, "S232.UnlimitRsrcPrice_APPEND")
    S232.Supplysector_indproc_APPEND <- get_data(all_data, "S232.Supplysector_indproc_APPEND")
    S232.SubsectorLogit_ind_APPEND <- get_data(all_data, "S232.SubsectorLogit_ind_APPEND")
    S232.SubsectorShrwtFllt_ind_APPEND <- get_data(all_data, "S232.SubsectorShrwtFllt_ind_APPEND")
    S232.SubsectorInterp_ind_APPEND <- get_data(all_data, "S232.SubsectorInterp_ind_APPEND")
    S232.StubTech_ind_APPEND <- get_data(all_data, "S232.StubTech_ind_APPEND")
    S232.StubTechCoef_indproc_APPEND <- get_data(all_data, "S232.StubTechCoef_indproc_APPEND")
    S232.MAC_indproc_APPEND <- get_data(all_data, "S232.MAC_indproc_APPEND")
    S232.fgas_all_units_ind_APPEND <- get_data(all_data, "S232.fgas_all_units_ind_APPEND")
    S232.nonghg_max_reduction_ind_APPEND <- get_data(all_data, "S232.nonghg_max_reduction_ind_APPEND")
    S232.nonghg_steepness_ind_APPEND <- get_data(all_data, "S232.nonghg_steepness_ind_APPEND")
    S232.hfc_future_ind_APPEND <- get_data(all_data, "S232.hfc_future_ind_APPEND")
    S232.nonco2_max_reduction_indproc_APPEND <- get_data(all_data, "S232.nonco2_max_reduction_indproc_APPEND")
    S232.nonco2_steepness_indproc_APPEND <- get_data(all_data, "S232.nonco2_steepness_indproc_APPEND")
    S232.pol_emissions_ind_APPEND <- get_data(all_data, "S232.pol_emissions_ind_APPEND")
    S232.ghg_emissions_ind_APPEND <- get_data(all_data, "S232.ghg_emissions_ind_APPEND")
    S232.StubTechMarket_ind_APPEND <- get_data(all_data, "S232.StubTechMarket_ind_APPEND")
    S232.StubTechSecMarket_ind_APPEND <- get_data(all_data, "S232.StubTechSecMarket_ind_APPEND")
    S232.nonco2_indproc_APPEND <- get_data(all_data, "S232.nonco2_indproc_APPEND")

    # ===================================================

    # Produce outputs
    create_xml("industry_APPEND.xml") %>%
      add_xml_data(S232.DeleteFinalDemand_APPENDind, "DeleteFinalDemand") %>%
      add_xml_data(S232.DeleteSupplysector_APPENDind, "DeleteSupplysector") %>%
      add_logit_tables_xml(S232.Supplysector_ind, "Supplysector") %>%
      add_xml_data(S232.FinalEnergyKeyword_ind, "FinalEnergyKeyword") %>%
      add_logit_tables_xml(S232.SubsectorLogit_ind, "SubsectorLogit") %>%
      add_xml_data(S232.SubsectorShrwtFllt_ind, "SubsectorShrwtFllt") %>%
      add_xml_data(S232.SubsectorInterp_ind, "SubsectorInterp") %>%
      add_xml_data(S232.FuelPrefElast_indenergy, "FuelPrefElast") %>%
      add_xml_data(S232.StubTech_ind, "StubTech") %>%
      add_xml_data(S232.StubTechInterp_ind, "StubTechInterp") %>%
      add_xml_data(S232.StubTechCalInput_indenergy, "StubTechCalInput") %>%
      add_xml_data(S232.StubTechCalInput_indfeed, "StubTechCalInput") %>%
      add_xml_data(S232.StubTechProd_industry, "StubTechProd") %>%
      add_xml_data(S232.StubTechCoef_industry, "StubTechCoef") %>%
      add_xml_data(S232.PerCapitaBased_ind, "PerCapitaBased") %>%
      add_xml_data(S232.IncomeElasticity_ind_gssp2, "IncomeElasticity") %>%
      add_xml_data(S232.PriceElasticity_ind, "PriceElasticity") %>%
      add_xml_data(S232.BaseService_ind, "BaseService") %>%
      add_xml_data(S232.UnlimitRsrc_APPEND, "UnlimitRsrc") %>%
      add_xml_data(S232.UnlimitRsrcPrice_APPEND, "UnlimitRsrcPrice") %>%
      add_logit_tables_xml(S232.Supplysector_indproc_APPEND, "Supplysector") %>%
      add_logit_tables_xml(S232.SubsectorLogit_ind_APPEND, "SubsectorLogit") %>%
      add_xml_data(S232.SubsectorShrwtFllt_ind_APPEND, "SubsectorShrwtFllt") %>%
      add_xml_data(S232.SubsectorInterp_ind_APPEND, "SubsectorInterp") %>%
      add_xml_data(S232.StubTech_ind_APPEND, "StubTech") %>%
      add_xml_data(S232.StubTechCoef_indproc_APPEND, "StubTechCoef") %>%
      add_xml_data(S232.MAC_indproc_APPEND, "MAC") %>%
      add_xml_data(S232.fgas_all_units_ind_APPEND, "StubTechEmissUnits") %>%
      add_xml_data(S232.nonghg_max_reduction_ind_APPEND, "GDPCtrlMax") %>%
      add_xml_data(S232.nonghg_steepness_ind_APPEND, "GDPCtrlSteep") %>%
      add_xml_data(S232.hfc_future_ind_APPEND, "OutputEmissCoeff") %>%
      add_xml_data(S232.nonco2_max_reduction_indproc_APPEND, "GDPCtrlMax") %>%
      add_xml_data(S232.nonco2_steepness_indproc_APPEND, "GDPCtrlSteep") %>%
      add_xml_data(S232.pol_emissions_ind_APPEND, "InputEmissions") %>%
      add_xml_data(S232.ghg_emissions_ind_APPEND, "InputEmissions") %>%
      add_xml_data(S232.StubTechMarket_ind_APPEND, "StubTechMarket") %>%
      add_xml_data(S232.StubTechSecMarket_ind_APPEND, "StubTechSecMarket") %>%
      add_xml_data(S232.nonco2_indproc_APPEND, "StbTechOutputEmissions") %>%
      add_precursors("S232.DeleteFinalDemand_APPENDind",
                     "S232.DeleteSupplysector_APPENDind",
                     "S232.Supplysector_ind",
                     "S232.FinalEnergyKeyword_ind",
                     "S232.SubsectorLogit_ind",
                     "S232.SubsectorShrwtFllt_ind",
                     "S232.SubsectorInterp_ind",
                     "S232.FuelPrefElast_indenergy",
                     "S232.StubTech_ind",
                     "S232.StubTechInterp_ind",
                     "S232.StubTechCalInput_indenergy",
                     "S232.StubTechCalInput_indfeed",
                     "S232.StubTechProd_industry",
                     "S232.StubTechCoef_industry",
                     "S232.PerCapitaBased_ind",
                     "S232.IncomeElasticity_ind_gssp2",
                     "S232.PriceElasticity_ind",
                     "S232.BaseService_ind",
                     "S232.UnlimitRsrc_APPEND",
                     "S232.UnlimitRsrcPrice_APPEND",
                     "S232.Supplysector_indproc_APPEND",
                     "S232.SubsectorLogit_ind_APPEND",
                     "S232.SubsectorShrwtFllt_ind_APPEND",
                     "S232.SubsectorInterp_ind_APPEND",
                     "S232.StubTech_ind_APPEND",
                     "S232.StubTechCoef_indproc_APPEND",
                     "S232.MAC_indproc_APPEND",
                     "S232.fgas_all_units_ind_APPEND",
                     "S232.nonghg_max_reduction_ind_APPEND",
                     "S232.nonghg_steepness_ind_APPEND",
                     "S232.hfc_future_ind_APPEND",
                     "S232.nonco2_max_reduction_indproc_APPEND",
                     "S232.nonco2_steepness_indproc_APPEND",
                     "S232.pol_emissions_ind_APPEND",
                     "S232.ghg_emissions_ind_APPEND",
                     "S232.StubTechMarket_ind_APPEND",
                     "S232.StubTechSecMarket_ind_APPEND",
                     "S232.nonco2_indproc_APPEND") ->
      industry_APPEND.xml

    return_data(industry_APPEND.xml)
  } else {
    stop("Unknown command")
  }
}

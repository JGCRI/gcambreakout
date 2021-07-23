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
module_energy_Xbatch_industry_xml_APPEND<- function(command, ...) {
  if(command == driver.DECLARE_INPUTS) {
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
  } else if(command == driver.DECLARE_OUTPUTS) {
    return(c(XML = "industry_APPEND.xml"))
  } else if(command == driver.MAKE) {

    all_data <- list(...)[[1]]

    # Load required inputs
    X232.DeleteFinalDemand_ind_APPEND<- get_data(all_data, "X232.DeleteFinalDemand_ind_APPEND")
    X232.DeleteSupplysector_ind_APPEND<- get_data(all_data, "X232.DeleteSupplysector_ind_APPEND")
    X232.Supplysector_ind_APPEND<- get_data(all_data, "X232.Supplysector_ind_APPEND")
    X232.FinalEnergyKeyword_ind_APPEND<- get_data(all_data, "X232.FinalEnergyKeyword_ind_APPEND")
    X232.SubsectorLogit_ind_APPEND<- get_data(all_data, "X232.SubsectorLogit_ind_APPEND")
    X232.SubsectorShrwtFllt_ind_APPEND<- get_data(all_data, "X232.SubsectorShrwtFllt_ind_APPEND")
    X232.SubsectorInterp_ind_APPEND<- get_data(all_data, "X232.SubsectorInterp_ind_APPEND")
    X232.FuelPrefElast_indenergy_APPEND<- get_data(all_data, "X232.FuelPrefElast_indenergy_APPEND")
    X232.StubTech_ind_APPEND<- get_data(all_data, "X232.StubTech_ind_APPEND")
    X232.StubTechInterp_ind_APPEND<- get_data(all_data, "X232.StubTechInterp_ind_APPEND")
    X232.StubTechCalInput_indenergy_APPEND<- get_data(all_data, "X232.StubTechCalInput_indenergy_APPEND")
    X232.StubTechCalInput_indfeed_APPEND<- get_data(all_data, "X232.StubTechCalInput_indfeed_APPEND")
    X232.StubTechProd_industry_APPEND<- get_data(all_data, "X232.StubTechProd_industry_APPEND")
    X232.StubTechCoef_industry_APPEND<- get_data(all_data, "X232.StubTechCoef_industry_APPEND")
    X232.PerCapitaBased_ind_APPEND<- get_data(all_data, "X232.PerCapitaBased_ind_APPEND")
    X232.IncomeElasticity_ind_gssp2_APPEND<- get_data(all_data, "X232.IncomeElasticity_ind_gssp2_APPEND")
    X232.PriceElasticity_ind_APPEND<- get_data(all_data, "X232.PriceElasticity_ind_APPEND")
    X232.BaseService_ind_APPEND<- get_data(all_data, "X232.BaseService_ind_APPEND")
    X232.UnlimitRsrc_APPEND<- get_data(all_data, "X232.UnlimitRsrc_APPEND")
    X232.UnlimitRsrcPrice_APPEND<- get_data(all_data, "X232.UnlimitRsrcPrice_APPEND")
    X232.Supplysector_urb_indproc_APPEND<- get_data(all_data, "X232.Supplysector_urb_indproc_APPEND")
    X232.SubsectorLogit_urb_ind_APPEND<- get_data(all_data, "X232.SubsectorLogit_urb_ind_APPEND")
    X232.SubsectorShrwtFllt_urb_ind_APPEND<- get_data(all_data, "X232.SubsectorShrwtFllt_urb_ind_APPEND")
    X232.SubsectorInterp_urb_ind_APPEND<- get_data(all_data, "X232.SubsectorInterp_urb_ind_APPEND")
    X232.StubTech_urb_ind_APPEND<- get_data(all_data, "X232.StubTech_urb_ind_APPEND")
    X232.StubTechCoef_indproc_APPEND<- get_data(all_data, "X232.StubTechCoef_indproc_APPEND")
    X232.MAC_indproc_APPEND<- get_data(all_data, "X232.MAC_indproc_APPEND")
    X232.fgas_all_units_ind_APPEND<- get_data(all_data, "X232.fgas_all_units_ind_APPEND")
    X232.nonghg_max_reduction_ind_APPEND<- get_data(all_data, "X232.nonghg_max_reduction_ind_APPEND")
    X232.nonghg_steepness_ind_APPEND<- get_data(all_data, "X232.nonghg_steepness_ind_APPEND")
    X232.hfc_future_ind_APPEND<- get_data(all_data, "X232.hfc_future_ind_APPEND")
    X232.MAC_higwp_ind_APPEND <- get_data(all_data, "X232.MAC_higwp_ind_APPEND")
    X232.nonco2_max_reduction_indproc_APPEND<- get_data(all_data, "X232.nonco2_max_reduction_indproc_APPEND")
    X232.nonco2_steepness_indproc_APPEND<- get_data(all_data, "X232.nonco2_steepness_indproc_APPEND")
    X232.pol_emissions_ind_APPEND<- get_data(all_data, "X232.pol_emissions_ind_APPEND")
    X232.ghg_emissions_ind_APPEND<- get_data(all_data, "X232.ghg_emissions_ind_APPEND")
    X232.StubTechMarket_ind_APPEND<- get_data(all_data, "X232.StubTechMarket_ind_APPEND")
    X232.StubTechSecMarket_ind_APPEND<- get_data(all_data, "X232.StubTechSecMarket_ind_APPEND")
    X232.nonco2_indproc_APPEND<- get_data(all_data, "X232.nonco2_indproc_APPEND")
    X232.hfc_all_indproc_APPEND <- get_data(all_data, "X232.hfc_all_indproc_APPEND")
    X232.pfc_all_indproc_APPEND <- get_data(all_data, "X232.pfc_all_indproc_APPEND")

    # ===================================================

    # Produce outputs
    create_xml("industry_APPEND.xml") %>%
      add_xml_data(X232.DeleteFinalDemand_ind_APPEND, "DeleteFinalDemand") %>%
      add_xml_data(X232.DeleteSupplysector_ind_APPEND, "DeleteSupplysector") %>%
      add_logit_tables_xml(X232.Supplysector_ind_APPEND, "Supplysector") %>%
      add_xml_data(X232.FinalEnergyKeyword_ind_APPEND, "FinalEnergyKeyword") %>%
      add_logit_tables_xml(X232.SubsectorLogit_ind_APPEND, "SubsectorLogit") %>%
      add_xml_data(X232.SubsectorShrwtFllt_ind_APPEND, "SubsectorShrwtFllt") %>%
      add_xml_data(X232.SubsectorInterp_ind_APPEND, "SubsectorInterp") %>%
      add_xml_data(X232.FuelPrefElast_indenergy_APPEND, "FuelPrefElast") %>%
      add_xml_data(X232.StubTech_ind_APPEND, "StubTech") %>%
      add_xml_data(X232.StubTechInterp_ind_APPEND, "StubTechInterp") %>%
      add_xml_data(X232.StubTechCalInput_indenergy_APPEND, "StubTechCalInput") %>%
      add_xml_data(X232.StubTechCalInput_indfeed_APPEND, "StubTechCalInput") %>%
      add_xml_data(X232.StubTechProd_industry_APPEND, "StubTechProd") %>%
      add_xml_data(X232.StubTechCoef_industry_APPEND, "StubTechCoef") %>%
      add_xml_data(X232.PerCapitaBased_ind_APPEND, "PerCapitaBased") %>%
      add_xml_data(X232.IncomeElasticity_ind_gssp2_APPEND, "IncomeElasticity") %>%
      add_xml_data(X232.PriceElasticity_ind_APPEND, "PriceElasticity") %>%
      add_xml_data(X232.BaseService_ind_APPEND, "BaseService") %>%
      add_xml_data(X232.UnlimitRsrc_APPEND, "UnlimitRsrc") %>%
      add_xml_data(X232.UnlimitRsrcPrice_APPEND, "UnlimitRsrcPrice") %>%
      add_logit_tables_xml(X232.Supplysector_urb_indproc_APPEND, "Supplysector") %>%
      add_logit_tables_xml(X232.SubsectorLogit_urb_ind_APPEND, "SubsectorLogit") %>%
      add_xml_data(X232.SubsectorShrwtFllt_urb_ind_APPEND, "SubsectorShrwtFllt") %>%
      add_xml_data(X232.SubsectorInterp_urb_ind_APPEND, "SubsectorInterp") %>%
      add_xml_data(X232.StubTech_urb_ind_APPEND, "StubTech") %>%
      add_xml_data(X232.StubTechCoef_indproc_APPEND, "StubTechCoef") %>%
      add_xml_data(X232.MAC_indproc_APPEND, "MAC") %>%
      add_xml_data(X232.fgas_all_units_ind_APPEND, "StubTechEmissUnits") %>%
      add_xml_data(X232.nonghg_max_reduction_ind_APPEND, "GDPCtrlMax") %>%
      add_xml_data(X232.nonghg_steepness_ind_APPEND, "GDPCtrlSteep") %>%
      add_xml_data(X232.hfc_future_ind_APPEND, "OutputEmissCoeff") %>%
      add_xml_data(X232.MAC_higwp_ind_APPEND, "MAC") %>%
      add_xml_data(X232.nonco2_max_reduction_indproc_APPEND, "GDPCtrlMax") %>%
      add_xml_data(X232.nonco2_steepness_indproc_APPEND, "GDPCtrlSteep") %>%
      add_xml_data(X232.pol_emissions_ind_APPEND, "InputEmissions") %>%
      add_xml_data(X232.ghg_emissions_ind_APPEND, "InputEmissions") %>%
      add_xml_data(X232.StubTechMarket_ind_APPEND, "StubTechMarket") %>%
      add_xml_data(X232.StubTechSecMarket_ind_APPEND, "StubTechSecMarket") %>%
      add_xml_data(X232.nonco2_indproc_APPEND, "StbTechOutputEmissions") %>%
      add_xml_data(X232.hfc_all_indproc_APPEND, "StbTechOutputEmissions") %>%
      add_xml_data(X232.pfc_all_indproc_APPEND, "StbTechOutputEmissions") %>%
      add_precursors("X232.DeleteFinalDemand_ind_APPEND",
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
                     "X232.pfc_all_indproc_APPEND") ->
      industry_APPEND.xml

    return_data(industry_APPEND.xml)
  } else {
    stop("Unknown command")
  }
}

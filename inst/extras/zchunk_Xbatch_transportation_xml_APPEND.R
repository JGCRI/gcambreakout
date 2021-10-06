# Copyright 2019 Battelle Memorial Institute; see the LICENSE file.

#' module_energy_Xbatch_transportation_xml_APPEND
#'
#' Construct XML data structure for \code{transportation_APPEND}.
#'
#' @param command API command to execute
#' @param ... other optional parameters, depending on command
#' @return Depends on \code{command}: either a vector of required inputs,
#' a vector of output names, or (if \code{command} is "MAKE") all
#' the generated outputs: \code{transportation_APPEND.xml}. The corresponding file in the
#' original data system was \code{batch_transportation_APPEND} (energy XML).
module_energy_Xbatch_transportation_xml_APPEND <- function(command, ...) {
  if(command == driver.DECLARE_INPUTS) {
    return(c("X254.DeleteFinalDemand_trn_APPEND",
             "X254.DeleteSupplysector_trn_APPEND",
             "X254.Supplysector_trn_APPEND",
             "X254.FinalEnergyKeyword_trn_APPEND",
             "X254.tranSubsectorLogit_trn_APPEND",
             "X254.tranSubsectorShrwt_trn_APPEND",
             "X254.tranSubsectorShrwtFllt_trn_APPEND",
             "X254.tranSubsectorInterp_trn_APPEND",
             "X254.tranSubsectorSpeed_trn_APPEND",
             "X254.tranSubsectorSpeed_passthru_trn_APPEND",
             "X254.tranSubsectorSpeed_noVOTT_trn_APPEND",
             "X254.tranSubsectorSpeed_nonmotor_trn_APPEND",
             "X254.tranSubsectorVOTT_trn_APPEND",
             "X254.tranSubsectorFuelPref_trn_APPEND",
             "X254.StubTranTech_trn_APPEND",
             "X254.StubTranTech_passthru_trn_APPEND",
             "X254.StubTranTech_nonmotor_trn_APPEND",
             "X254.StubTranTechCalInput_trn_APPEND",
             "X254.StubTranTechLoadFactor_trn_APPEND",
             "X254.StubTranTechCost_trn_APPEND",
             "X254.StubTranTechCoef_trn_APPEND",
             "X254.StubTechCalInput_passthru_trn_APPEND",
             "X254.StubTechProd_nonmotor_trn_APPEND",
             "X254.PerCapitaBased_trn_APPEND",
             "X254.PriceElasticity_trn_APPEND",
             "X254.IncomeElasticity_trn_APPEND",
             "X254.BaseService_trn_APPEND",
             "X254.fgas_all_units_trn_APPEND",
             "X254.nonghg_max_reduction_trn_APPEND",
             "X254.nonghg_steepness_trn_APPEND",
             "X254.hfc_future_trn_APPEND",
             "X254.pol_emissions_trn_APPEND",
             "X254.ghg_emissions_trn_APPEND"))
  } else if(command == driver.DECLARE_OUTPUTS) {
    return(c(XML = "transportation_APPEND.xml"))
  } else if(command == driver.MAKE) {

    all_data <- list(...)[[1]]

    # Load required inputs
    X254.DeleteFinalDemand_trn_APPEND <- get_data(all_data, "X254.DeleteFinalDemand_trn_APPEND")
    X254.DeleteSupplysector_trn_APPEND <- get_data(all_data, "X254.DeleteSupplysector_trn_APPEND")
    X254.Supplysector_trn_APPEND <- get_data(all_data, "X254.Supplysector_trn_APPEND")
    X254.FinalEnergyKeyword_trn_APPEND <- get_data(all_data, "X254.FinalEnergyKeyword_trn_APPEND")
    X254.tranSubsectorLogit_trn_APPEND <- get_data(all_data, "X254.tranSubsectorLogit_trn_APPEND")
    X254.tranSubsectorShrwt_trn_APPEND <- get_data(all_data, "X254.tranSubsectorShrwt_trn_APPEND")
    X254.tranSubsectorShrwtFllt_trn_APPEND <- get_data(all_data, "X254.tranSubsectorShrwtFllt_trn_APPEND")
    X254.tranSubsectorInterp_trn_APPEND <- get_data(all_data, "X254.tranSubsectorInterp_trn_APPEND")
    X254.tranSubsectorSpeed_trn_APPEND <- get_data(all_data, "X254.tranSubsectorSpeed_trn_APPEND")
    X254.tranSubsectorSpeed_passthru_trn_APPEND <- get_data(all_data, "X254.tranSubsectorSpeed_passthru_trn_APPEND")
    X254.tranSubsectorSpeed_noVOTT_trn_APPEND <- get_data(all_data, "X254.tranSubsectorSpeed_noVOTT_trn_APPEND")
    X254.tranSubsectorSpeed_nonmotor_trn_APPEND <- get_data(all_data, "X254.tranSubsectorSpeed_nonmotor_trn_APPEND")
    X254.tranSubsectorVOTT_trn_APPEND <- get_data(all_data, "X254.tranSubsectorVOTT_trn_APPEND")
    X254.tranSubsectorFuelPref_trn_APPEND <- get_data(all_data, "X254.tranSubsectorFuelPref_trn_APPEND")
    X254.StubTranTech_trn_APPEND <- get_data(all_data, "X254.StubTranTech_trn_APPEND")
    X254.StubTranTech_passthru_trn_APPEND <- get_data(all_data, "X254.StubTranTech_passthru_trn_APPEND")
    X254.StubTranTech_nonmotor_trn_APPEND <- get_data(all_data, "X254.StubTranTech_nonmotor_trn_APPEND")
    X254.StubTranTechCalInput_trn_APPEND <- get_data(all_data, "X254.StubTranTechCalInput_trn_APPEND")
    X254.StubTranTechLoadFactor_trn_APPEND <- get_data(all_data, "X254.StubTranTechLoadFactor_trn_APPEND")
    X254.StubTranTechCost_trn_APPEND <- get_data(all_data, "X254.StubTranTechCost_trn_APPEND")
    X254.StubTranTechCoef_trn_APPEND <- get_data(all_data, "X254.StubTranTechCoef_trn_APPEND")
    X254.StubTechCalInput_passthru_trn_APPEND <- get_data(all_data, "X254.StubTechCalInput_passthru_trn_APPEND")
    X254.StubTechProd_nonmotor_trn_APPEND <- get_data(all_data, "X254.StubTechProd_nonmotor_trn_APPEND")
    X254.PerCapitaBased_trn_APPEND <- get_data(all_data, "X254.PerCapitaBased_trn_APPEND")
    X254.PriceElasticity_trn_APPEND <- get_data(all_data, "X254.PriceElasticity_trn_APPEND")
    X254.IncomeElasticity_trn_APPEND <- get_data(all_data, "X254.IncomeElasticity_trn_APPEND")
    X254.BaseService_trn_APPEND <- get_data(all_data, "X254.BaseService_trn_APPEND")
    X254.fgas_all_units_trn_APPEND <- get_data(all_data, "X254.fgas_all_units_trn_APPEND")
    X254.nonghg_max_reduction_trn_APPEND <- get_data(all_data, "X254.nonghg_max_reduction_trn_APPEND")
    X254.nonghg_steepness_trn_APPEND <- get_data(all_data, "X254.nonghg_steepness_trn_APPEND")
    X254.hfc_future_trn_APPEND <- get_data(all_data, "X254.hfc_future_trn_APPEND")
    X254.pol_emissions_trn_APPEND <- get_data(all_data, "X254.pol_emissions_trn_APPEND")
    X254.ghg_emissions_trn_APPEND <- get_data(all_data, "X254.ghg_emissions_trn_APPEND")

    # ===================================================

    # Produce outputs
    create_xml("transportation_APPEND.xml") %>%
      add_xml_data(X254.DeleteFinalDemand_trn_APPEND, "DeleteFinalDemand") %>%
      add_xml_data(X254.DeleteSupplysector_trn_APPEND, "DeleteSupplysector") %>%
      add_logit_tables_xml(X254.Supplysector_trn_APPEND, "Supplysector") %>%
      add_xml_data(X254.FinalEnergyKeyword_trn_APPEND, "FinalEnergyKeyword") %>%
      add_logit_tables_xml(X254.tranSubsectorLogit_trn_APPEND, "tranSubsectorLogit", "tranSubsector") %>%
      add_xml_data(X254.tranSubsectorShrwt_trn_APPEND, "tranSubsectorShrwt") %>%
      add_xml_data(X254.tranSubsectorShrwtFllt_trn_APPEND, "tranSubsectorShrwtFllt") %>%
      add_xml_data(X254.tranSubsectorInterp_trn_APPEND, "tranSubsectorInterp") %>%
      add_xml_data(X254.tranSubsectorSpeed_trn_APPEND, "tranSubsectorSpeed") %>%
      add_xml_data(X254.tranSubsectorSpeed_passthru_trn_APPEND, "tranSubsectorSpeed") %>%
      add_xml_data(X254.tranSubsectorSpeed_noVOTT_trn_APPEND, "tranSubsectorSpeed") %>%
      add_xml_data(X254.tranSubsectorSpeed_nonmotor_trn_APPEND, "tranSubsectorSpeed") %>%
      add_xml_data(X254.tranSubsectorVOTT_trn_APPEND, "tranSubsectorVOTT") %>%
      add_xml_data(X254.tranSubsectorFuelPref_trn_APPEND, "tranSubsectorFuelPref") %>%
      add_xml_data(X254.StubTranTech_trn_APPEND, "StubTranTech") %>%
      add_xml_data(X254.StubTranTech_passthru_trn_APPEND, "StubTranTech") %>%
      add_xml_data(X254.StubTranTech_nonmotor_trn_APPEND, "StubTranTech") %>%
      add_xml_data(X254.StubTranTechCalInput_trn_APPEND, "StubTranTechCalInput") %>%
      add_xml_data(X254.StubTranTechLoadFactor_trn_APPEND, "StubTranTechLoadFactor") %>%
      add_xml_data(X254.StubTranTechCost_trn_APPEND, "StubTranTechCost") %>%
      add_xml_data(X254.StubTranTechCoef_trn_APPEND, "StubTranTechCoef") %>%
      add_xml_data(X254.StubTechCalInput_passthru_trn_APPEND, "StubTranTechCalInput") %>%
      add_xml_data(X254.StubTechProd_nonmotor_trn_APPEND, "StubTranTechProd") %>%
      add_xml_data(X254.PerCapitaBased_trn_APPEND, "PerCapitaBased") %>%
      add_xml_data(X254.PriceElasticity_trn_APPEND, "PriceElasticity") %>%
      add_xml_data(X254.IncomeElasticity_trn_APPEND, "IncomeElasticity") %>%
      add_xml_data(X254.BaseService_trn_APPEND, "BaseService") %>%
      add_xml_data(X254.fgas_all_units_trn_APPEND, "StubTechEmissUnits") %>%
      add_xml_data(X254.nonghg_max_reduction_trn_APPEND, "GDPCtrlMax") %>%
      add_xml_data(X254.nonghg_steepness_trn_APPEND, "GDPCtrlSteep") %>%
      add_xml_data(X254.hfc_future_trn_APPEND, "OutputEmissCoeff") %>%
      add_xml_data(X254.pol_emissions_trn_APPEND, "InputEmissions") %>%
      add_xml_data(X254.ghg_emissions_trn_APPEND, "InputEmissions") %>%
      add_precursors("X254.DeleteFinalDemand_trn_APPEND",
                     "X254.DeleteSupplysector_trn_APPEND",
                     "X254.Supplysector_trn_APPEND",
                     "X254.FinalEnergyKeyword_trn_APPEND",
                     "X254.tranSubsectorLogit_trn_APPEND",
                     "X254.tranSubsectorShrwt_trn_APPEND",
                     "X254.tranSubsectorShrwtFllt_trn_APPEND",
                     "X254.tranSubsectorInterp_trn_APPEND",
                     "X254.tranSubsectorSpeed_trn_APPEND",
                     "X254.tranSubsectorSpeed_passthru_trn_APPEND",
                     "X254.tranSubsectorSpeed_noVOTT_trn_APPEND",
                     "X254.tranSubsectorSpeed_nonmotor_trn_APPEND",
                     "X254.tranSubsectorVOTT_trn_APPEND",
                     "X254.tranSubsectorFuelPref_trn_APPEND",
                     "X254.StubTranTech_trn_APPEND",
                     "X254.StubTranTech_passthru_trn_APPEND",
                     "X254.StubTranTech_nonmotor_trn_APPEND",
                     "X254.StubTranTechCalInput_trn_APPEND",
                     "X254.StubTranTechLoadFactor_trn_APPEND",
                     "X254.StubTranTechCost_trn_APPEND",
                     "X254.StubTranTechCoef_trn_APPEND",
                     "X254.StubTechCalInput_passthru_trn_APPEND",
                     "X254.StubTechProd_nonmotor_trn_APPEND",
                     "X254.PerCapitaBased_trn_APPEND",
                     "X254.PriceElasticity_trn_APPEND",
                     "X254.IncomeElasticity_trn_APPEND",
                     "X254.BaseService_trn_APPEND",
                     "X254.fgas_all_units_trn_APPEND",
                     "X254.nonghg_max_reduction_trn_APPEND",
                     "X254.nonghg_steepness_trn_APPEND",
                     "X254.hfc_future_trn_APPEND",
                     "X254.pol_emissions_trn_APPEND",
                     "X254.ghg_emissions_trn_APPEND") ->
      transportation_APPEND.xml

    return_data(transportation_APPEND.xml)
  } else {
    stop("Unknown command")
  }
}

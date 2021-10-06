# Copyright 2019 Battelle Memorial Institute; see the LICENSE file.

#' module_energy_Xbatch_building_xml_APPEND
#'
#' Construct XML data structure for \code{building_APPEND.xml}.
#'
#' @param command API command to execute
#' @param ... other optional parameters, depending on command
#' @return Depends on \code{command}: either a vector of required inputs,
#' a vector of output names, or (if \code{command} is "MAKE") all
#' the generated outputs: \code{building_APPEND.xml}. The corresponding file in the
#' original data system was \code{batch_building_APPEND.xml} (energy XML).
module_energy_Xbatch_building_xml_APPEND <- function(command, ...) {
  if(command == driver.DECLARE_INPUTS) {
    return(c("X244.DeleteThermalService_bld_APPEND",
             "X244.DeleteConsumer_bld_APPEND",
             "X244.DeleteSupplysector_bld_APPEND",
             "X244.SubregionalShares_APPEND",
             "X244.PriceExp_IntGains_APPEND",
             "X244.Floorspace_APPEND",
             "X244.DemandFunction_serv_APPEND",
             "X244.DemandFunction_flsp_APPEND",
             "X244.Satiation_flsp_APPEND",
             "X244.SatiationAdder_APPEND",
             "X244.ThermalBaseService_APPEND",
             "X244.GenericBaseService_APPEND",
             "X244.ThermalServiceSatiation_APPEND",
             "X244.GenericServiceSatiation_APPEND",
             "X244.Intgains_scalar_APPEND",
             "X244.ShellConductance_bld_APPEND",
             "X244.Supplysector_bld_APPEND",
             "X244.FinalEnergyKeyword_bld_APPEND",
             "X244.SubsectorShrwtFllt_bld_APPEND",
             "X244.SubsectorInterp_bld_APPEND",
             "X244.FuelPrefElast_bld_APPEND",
             "X244.StubTech_bld_APPEND",
             "X244.StubTechEff_bld_APPEND",
             "X244.StubTechCalInput_bld_APPEND",
             "X244.SubsectorLogit_bld_APPEND",
             "X244.StubTechIntGainOutputRatio_APPEND",
             "X244.HDDCDD_constdd_no_GCM_APPEND",
             "X244.fgas_all_units_bld_APPEND",
             "X244.nonghg_max_reduction_bld_APPEND",
             "X244.nonghg_steepness_bld_APPEND",
             "X244.hfc_future_bld_APPEND",
             "X244.pol_emissions_bld_APPEND",
             "X244.ghg_emissions_bld_APPEND"))
  } else if(command == driver.DECLARE_OUTPUTS) {
    return(c(XML = "building_APPEND.xml"))
  } else if(command == driver.MAKE) {

    all_data <- list(...)[[1]]

    # Load required inputs
    X244.DeleteConsumer_bld_APPEND<- get_data(all_data, "X244.DeleteConsumer_bld_APPEND")
    X244.DeleteSupplysector_bld_APPEND<- get_data(all_data, "X244.DeleteSupplysector_bld_APPEND")
    X244.SubregionalShares_APPEND<- get_data(all_data, "X244.SubregionalShares_APPEND")
    X244.PriceExp_IntGains_APPEND<- get_data(all_data, "X244.PriceExp_IntGains_APPEND")
    X244.Floorspace_APPEND<- get_data(all_data, "X244.Floorspace_APPEND")
    X244.DemandFunction_serv_APPEND<- get_data(all_data, "X244.DemandFunction_serv_APPEND")
    X244.DemandFunction_flsp_APPEND<- get_data(all_data, "X244.DemandFunction_flsp_APPEND")
    X244.Satiation_flsp_APPEND<- get_data(all_data, "X244.Satiation_flsp_APPEND")
    X244.SatiationAdder_APPEND<- get_data(all_data, "X244.SatiationAdder_APPEND")
    X244.ThermalBaseService_APPEND<- get_data(all_data, "X244.ThermalBaseService_APPEND")
    X244.GenericBaseService_APPEND<- get_data(all_data, "X244.GenericBaseService_APPEND")
    X244.ThermalServiceSatiation_APPEND<- get_data(all_data, "X244.ThermalServiceSatiation_APPEND")
    X244.GenericServiceSatiation_APPEND<- get_data(all_data, "X244.GenericServiceSatiation_APPEND")
    X244.Intgains_scalar_APPEND<- get_data(all_data, "X244.Intgains_scalar_APPEND")
    X244.ShellConductance_bld_APPEND<- get_data(all_data, "X244.ShellConductance_bld_APPEND")
    X244.Supplysector_bld_APPEND<- get_data(all_data, "X244.Supplysector_bld_APPEND")
    X244.FinalEnergyKeyword_bld_APPEND<- get_data(all_data, "X244.FinalEnergyKeyword_bld_APPEND")
    X244.SubsectorShrwtFllt_bld_APPEND<- get_data(all_data, "X244.SubsectorShrwtFllt_bld_APPEND")
    X244.SubsectorInterp_bld_APPEND<- get_data(all_data, "X244.SubsectorInterp_bld_APPEND")
    X244.FuelPrefElast_bld_APPEND<- get_data(all_data, "X244.FuelPrefElast_bld_APPEND")
    X244.StubTech_bld_APPEND<- get_data(all_data, "X244.StubTech_bld_APPEND")
    X244.StubTechEff_bld_APPEND<- get_data(all_data, "X244.StubTechEff_bld_APPEND")
    X244.StubTechCalInput_bld_APPEND<- get_data(all_data, "X244.StubTechCalInput_bld_APPEND")
    X244.SubsectorLogit_bld_APPEND<- get_data(all_data, "X244.SubsectorLogit_bld_APPEND")
    X244.StubTechIntGainOutputRatio_APPEND<- get_data(all_data, "X244.StubTechIntGainOutputRatio_APPEND")
    X244.HDDCDD_constdd_no_GCM_APPEND<- get_data(all_data, "X244.HDDCDD_constdd_no_GCM_APPEND")
    X244.fgas_all_units_bld_APPEND<- get_data(all_data, "X244.fgas_all_units_bld_APPEND")
    X244.nonghg_max_reduction_bld_APPEND<- get_data(all_data, "X244.nonghg_max_reduction_bld_APPEND")
    X244.nonghg_steepness_bld_APPEND<- get_data(all_data, "X244.nonghg_steepness_bld_APPEND")
    X244.hfc_future_bld_APPEND<- get_data(all_data, "X244.hfc_future_bld_APPEND")
    X244.pol_emissions_bld_APPEND<- get_data(all_data, "X244.pol_emissions_bld_APPEND")
    X244.ghg_emissions_bld_APPEND<- get_data(all_data, "X244.ghg_emissions_bld_APPEND")
    X244.DeleteThermalService_bld_APPEND<- get_data(all_data, "X244.DeleteThermalService_bld_APPEND")

    # ===================================================

    # Produce outputs
    create_xml("building_APPEND.xml") %>%
      add_xml_data(X244.DeleteConsumer_bld_APPEND, "DeleteConsumer") %>%
      add_xml_data(X244.DeleteSupplysector_bld_APPEND, "DeleteSupplysector") %>%
      add_logit_tables_xml(X244.Supplysector_bld_APPEND, "Supplysector") %>%
      add_logit_tables_xml(X244.SubsectorLogit_bld_APPEND, "SubsectorLogit") %>%
      add_xml_data(X244.SubregionalShares_APPEND, "SubregionalShares") %>%
    add_xml_data(X244.PriceExp_IntGains_APPEND, "PriceExp_IntGains") %>%
    add_xml_data(X244.Floorspace_APPEND, "Floorspace") %>%
    add_xml_data(X244.DemandFunction_serv_APPEND, "DemandFunction_serv") %>%
    add_xml_data(X244.DemandFunction_flsp_APPEND, "DemandFunction_flsp") %>%
    add_xml_data(X244.Satiation_flsp_APPEND, "Satiation_flsp") %>%
    add_xml_data(X244.SatiationAdder_APPEND, "SatiationAdder") %>%
    add_xml_data(X244.ThermalBaseService_APPEND, "ThermalBaseService") %>%
    add_xml_data(X244.GenericBaseService_APPEND, "GenericBaseService") %>%
    add_xml_data(X244.ThermalServiceSatiation_APPEND, "ThermalServiceSatiation") %>%
    add_xml_data(X244.GenericServiceSatiation_APPEND, "GenericServiceSatiation") %>%
    add_xml_data(X244.Intgains_scalar_APPEND, "Intgains_scalar") %>%
    add_xml_data(X244.ShellConductance_bld_APPEND, "ShellConductance") %>%
    add_xml_data(X244.FinalEnergyKeyword_bld_APPEND, "FinalEnergyKeyword") %>%
    add_xml_data(X244.SubsectorShrwtFllt_bld_APPEND, "SubsectorShrwtFllt") %>%
    add_xml_data(X244.SubsectorInterp_bld_APPEND, "SubsectorInterp") %>%
    add_xml_data(X244.FuelPrefElast_bld_APPEND, "FuelPrefElast") %>%
    add_xml_data(X244.StubTech_bld_APPEND, "StubTech") %>%
    add_xml_data(X244.StubTechEff_bld_APPEND, "StubTechEff") %>%
    add_xml_data(X244.StubTechCalInput_bld_APPEND, "StubTechCalInput") %>%
    add_xml_data(X244.StubTechIntGainOutputRatio_APPEND, "StubTechIntGainOutputRatio") %>%
    add_xml_data(X244.HDDCDD_constdd_no_GCM_APPEND, "HDDCDD") %>%
      add_xml_data(X244.fgas_all_units_bld_APPEND, "StubTechEmissUnits") %>%
      add_xml_data(X244.nonghg_max_reduction_bld_APPEND, "GDPCtrlMax") %>%
      add_xml_data(X244.nonghg_steepness_bld_APPEND, "GDPCtrlSteep") %>%
      add_xml_data(X244.hfc_future_bld_APPEND, "OutputEmissCoeff") %>%
      add_xml_data(X244.pol_emissions_bld_APPEND, "InputEmissions") %>%
      add_xml_data(X244.ghg_emissions_bld_APPEND, "InputEmissions") %>%
      add_precursors("X244.DeleteConsumer_bld_APPEND",
                     "X244.DeleteSupplysector_bld_APPEND",
                     "X244.SubregionalShares_APPEND",
                     "X244.PriceExp_IntGains_APPEND",
                     "X244.Floorspace_APPEND",
                     "X244.DemandFunction_serv_APPEND",
                     "X244.DemandFunction_flsp_APPEND",
                     "X244.Satiation_flsp_APPEND",
                     "X244.SatiationAdder_APPEND",
                     "X244.ThermalBaseService_APPEND",
                     "X244.GenericBaseService_APPEND",
                     "X244.ThermalServiceSatiation_APPEND",
                     "X244.GenericServiceSatiation_APPEND",
                     "X244.Intgains_scalar_APPEND",
                     "X244.ShellConductance_bld_APPEND",
                     "X244.Supplysector_bld_APPEND",
                     "X244.FinalEnergyKeyword_bld_APPEND",
                     "X244.SubsectorShrwtFllt_bld_APPEND",
                     "X244.SubsectorInterp_bld_APPEND",
                     "X244.FuelPrefElast_bld_APPEND",
                     "X244.StubTech_bld_APPEND",
                     "X244.StubTechEff_bld_APPEND",
                     "X244.StubTechCalInput_bld_APPEND",
                     "X244.SubsectorLogit_bld_APPEND",
                     "X244.StubTechIntGainOutputRatio_APPEND",
                     "X244.HDDCDD_constdd_no_GCM_APPEND",
                     "X244.fgas_all_units_bld_APPEND",
                     "X244.nonghg_max_reduction_bld_APPEND",
                     "X244.nonghg_steepness_bld_APPEND",
                     "X244.hfc_future_bld_APPEND",
                     "X244.pol_emissions_bld_APPEND",
                     "X244.ghg_emissions_bld_APPEND",
                     "X244.DeleteThermalService_bld_APPEND") ->
      building_APPEND.xml

    if(nrow(X244.DeleteThermalService_bld_APPEND) > 0) {
      building_APPEND.xml %>%
        add_xml_data(X244.DeleteThermalService_bld_APPEND, "DeleteThermalService") ->
        building_APPEND.xml
    }


    return_data(building_APPEND.xml)
  } else {
    stop("Unknown command")
  }
}

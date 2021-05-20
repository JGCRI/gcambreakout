# Copyright 2019 Battelle Memorial Institute; see the LICENSE file.

#' module_energy_Sbatch_building_SEA_xml
#'
#' Construct XML data structure for \code{building_SEA.xml}.
#'
#' @param command API command to execute
#' @param ... other optional parameters, depending on command
#' @return Depends on \code{command}: either a vector of required inputs,
#' a vector of output names, or (if \code{command} is "MAKE") all
#' the generated outputs: \code{building_SEA.xml}. The corresponding file in the
#' original data system was \code{batch_building_SEA.xml} (energy XML).
module_energy_Sbatch_building_SEA_xml <- function(command, ...) {
  if(command == driver.DECLARE_INPUTS) {
    return(c("S244.DeleteConsumer_SEAbld",
             "S244.DeleteSupplysector_SEAbld",
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
             "S244.fgas_all_units_bld_SEA",
             "S244.nonghg_max_reduction_bld_SEA",
             "S244.nonghg_steepness_bld_SEA",
             "S244.hfc_future_bld_SEA",
             "S244.pol_emissions_bld_SEA",
             "S244.ghg_emissions_bld_SEA"))
  } else if(command == driver.DECLARE_OUTPUTS) {
    return(c(XML = "building_SEA.xml"))
  } else if(command == driver.MAKE) {

    all_data <- list(...)[[1]]

    # Load required inputs
    S244.DeleteConsumer_SEAbld<- get_data(all_data, "S244.DeleteConsumer_SEAbld")
    S244.DeleteSupplysector_SEAbld<- get_data(all_data, "S244.DeleteSupplysector_SEAbld")
    S244.SubregionalShares<- get_data(all_data, "S244.SubregionalShares")
    S244.PriceExp_IntGains<- get_data(all_data, "S244.PriceExp_IntGains")
    S244.Floorspace<- get_data(all_data, "S244.Floorspace")
    S244.DemandFunction_serv<- get_data(all_data, "S244.DemandFunction_serv")
    S244.DemandFunction_flsp<- get_data(all_data, "S244.DemandFunction_flsp")
    S244.Satiation_flsp<- get_data(all_data, "S244.Satiation_flsp")
    S244.SatiationAdder<- get_data(all_data, "S244.SatiationAdder")
    S244.ThermalBaseService<- get_data(all_data, "S244.ThermalBaseService")
    S244.GenericBaseService<- get_data(all_data, "S244.GenericBaseService")
    S244.ThermalServiceSatiation<- get_data(all_data, "S244.ThermalServiceSatiation")
    S244.GenericServiceSatiation<- get_data(all_data, "S244.GenericServiceSatiation")
    S244.Intgains_scalar<- get_data(all_data, "S244.Intgains_scalar")
    S244.ShellConductance_bld<- get_data(all_data, "S244.ShellConductance_bld")
    S244.Supplysector_bld<- get_data(all_data, "S244.Supplysector_bld")
    S244.FinalEnergyKeyword_bld<- get_data(all_data, "S244.FinalEnergyKeyword_bld")
    S244.SubsectorShrwtFllt_bld<- get_data(all_data, "S244.SubsectorShrwtFllt_bld")
    S244.SubsectorInterp_bld<- get_data(all_data, "S244.SubsectorInterp_bld")
    S244.FuelPrefElast_bld<- get_data(all_data, "S244.FuelPrefElast_bld")
    S244.StubTech_bld<- get_data(all_data, "S244.StubTech_bld")
    S244.StubTechEff_bld<- get_data(all_data, "S244.StubTechEff_bld")
    S244.StubTechCalInput_bld<- get_data(all_data, "S244.StubTechCalInput_bld")
    S244.SubsectorLogit_bld<- get_data(all_data, "S244.SubsectorLogit_bld")
    S244.StubTechIntGainOutputRatio<- get_data(all_data, "S244.StubTechIntGainOutputRatio")
    S244.HDDCDD_constdd_no_GCM <- get_data(all_data, "S244.HDDCDD_constdd_no_GCM")
    S244.fgas_all_units_bld_SEA <- get_data(all_data, "S244.fgas_all_units_bld_SEA")
    S244.nonghg_max_reduction_bld_SEA <- get_data(all_data, "S244.nonghg_max_reduction_bld_SEA")
    S244.nonghg_steepness_bld_SEA <- get_data(all_data, "S244.nonghg_steepness_bld_SEA")
    S244.hfc_future_bld_SEA <- get_data(all_data, "S244.hfc_future_bld_SEA")
    S244.pol_emissions_bld_SEA <- get_data(all_data, "S244.pol_emissions_bld_SEA")
    S244.ghg_emissions_bld_SEA <- get_data(all_data, "S244.ghg_emissions_bld_SEA")

    # ===================================================

    # Produce outputs
    create_xml("building_SEA.xml") %>%
      add_xml_data(S244.DeleteConsumer_SEAbld, "DeleteConsumer") %>%
      add_xml_data(S244.DeleteSupplysector_SEAbld, "DeleteSupplysector") %>%
      add_logit_tables_xml(S244.Supplysector_bld, "Supplysector") %>%
      add_logit_tables_xml(S244.SubsectorLogit_bld, "SubsectorLogit") %>%
      add_xml_data(S244.SubregionalShares, "SubregionalShares") %>%
    add_xml_data(S244.PriceExp_IntGains, "PriceExp_IntGains") %>%
    add_xml_data(S244.Floorspace, "Floorspace") %>%
    add_xml_data(S244.DemandFunction_serv, "DemandFunction_serv") %>%
    add_xml_data(S244.DemandFunction_flsp, "DemandFunction_flsp") %>%
    add_xml_data(S244.Satiation_flsp, "Satiation_flsp") %>%
    add_xml_data(S244.SatiationAdder, "SatiationAdder") %>%
    add_xml_data(S244.ThermalBaseService, "ThermalBaseService") %>%
    add_xml_data(S244.GenericBaseService, "GenericBaseService") %>%
    add_xml_data(S244.ThermalServiceSatiation, "ThermalServiceSatiation") %>%
    add_xml_data(S244.GenericServiceSatiation, "GenericServiceSatiation") %>%
    add_xml_data(S244.Intgains_scalar, "Intgains_scalar") %>%
    add_xml_data(S244.ShellConductance_bld, "ShellConductance") %>%
    add_xml_data(S244.FinalEnergyKeyword_bld, "FinalEnergyKeyword") %>%
    add_xml_data(S244.SubsectorShrwtFllt_bld, "SubsectorShrwtFllt") %>%
    add_xml_data(S244.SubsectorInterp_bld, "SubsectorInterp") %>%
    add_xml_data(S244.FuelPrefElast_bld, "FuelPrefElast") %>%
    add_xml_data(S244.StubTech_bld, "StubTech") %>%
    add_xml_data(S244.StubTechEff_bld, "StubTechEff") %>%
    add_xml_data(S244.StubTechCalInput_bld, "StubTechCalInput") %>%
    add_xml_data(S244.StubTechIntGainOutputRatio, "StubTechIntGainOutputRatio") %>%
    add_xml_data(S244.HDDCDD_constdd_no_GCM , "HDDCDD") %>%
      add_xml_data(S244.fgas_all_units_bld_SEA, "StubTechEmissUnits") %>%
      add_xml_data(S244.nonghg_max_reduction_bld_SEA, "GDPCtrlMax") %>%
      add_xml_data(S244.nonghg_steepness_bld_SEA, "GDPCtrlSteep") %>%
      add_xml_data(S244.hfc_future_bld_SEA, "OutputEmissCoeff") %>%
      add_xml_data(S244.pol_emissions_bld_SEA, "InputEmissions") %>%
      add_xml_data(S244.ghg_emissions_bld_SEA, "InputEmissions") %>%
      add_precursors("S244.DeleteConsumer_SEAbld",
                     "S244.DeleteSupplysector_SEAbld",
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
                     "S244.fgas_all_units_bld_SEA",
                     "S244.nonghg_max_reduction_bld_SEA",
                     "S244.nonghg_steepness_bld_SEA",
                     "S244.hfc_future_bld_SEA",
                     "S244.pol_emissions_bld_SEA",
                     "S244.ghg_emissions_bld_SEA") ->
      building_SEA.xml

    return_data(building_SEA.xml)
  } else {
    stop("Unknown command")
  }
}

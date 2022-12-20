# Copyright 2019 Battelle Memorial Institute; see the LICENSE file.

#' module_water_batch_water_demand_industry_xml_APPEND
#'
#' Construct XML data structure for \code{water_demand_industry_APPEND.xml}.
#'
#' @param command API command to execute
#' @param ... other optional parameters, depending on command
#' @return Depends on \code{command}: either a vector of required inputs,
#' a vector of output names, or (if \code{command} is "MAKE") all
#' the generated outputs: \code{water_demand_industry.xml}. The corresponding file in the
#' original data system was \code{batch_water_demand_industry.xml.R} (water XML).
module_water_batch_water_demand_industry_xml_APPEND <- function(command, ...) {
  if(command == driver.DECLARE_INPUTS) {
    return(c("L232.TechCoef",
             "X201.Pop_APPEND"))
  } else if(command == driver.DECLARE_OUTPUTS) {
    return(c(XML = "water_demand_industry_APPEND.xml"))
  } else if(command == driver.MAKE) {

    all_data <- list(...)[[1]]

    # Load required inputs
    L232.TechCoef <- get_data(all_data, "L232.TechCoef")
    X201.Pop_APPEND <- get_data(all_data, "X201.Pop_APPEND")

    # gcambreakout Add subregions
    parent_region <- "APPEND_REGION"
    subregions <- X201.Pop_APPEND$region
    subregions <- subregions[!subregions %in% "APPEND_REGION"]

    L232.StubTechCoef_subRegion <- L232.TechCoef %>%
      dplyr::filter(region == parent_region) %>%
      dplyr::mutate(region = subregions) %>%
      dplyr::rename(stub.technology = technology); L232.StubTechCoef_subRegion

    # ===================================================

    # Produce outputs
    create_xml("water_demand_industry_APPEND.xml") %>%
      add_xml_data(L232.StubTechCoef_subRegion, "StubTechCoef") %>%
      add_precursors("L232.TechCoef","X201.Pop_APPEND") ->
      water_demand_industry_APPEND.xml

    return_data(water_demand_industry_APPEND.xml)
  } else {
    stop("Unknown command")
  }
}

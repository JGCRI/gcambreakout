# Copyright 2019 Battelle Memorial Institute; see the LICENSE file.

#' module_seasia_batch_socioeconomics_SEA_xml
#'
#' Construct XML data structure for \code{socioeconomics_USA.xml}.
#'
#' @param command API command to execute
#' @param ... other optional parameters, depending on command
#' @return Depends on \code{command}: either a vector of required inputs,
#' a vector of output names, or (if \code{command} is "MAKE") all
#' the generated outputs: \code{socioeconomics_USA.xml}. The corresponding file in the
#' original data system was \code{batch_socioeconomics_USA.xml} (gcamusa XML).
module_seasia_batch_socioeconomics_SEA_xml <- function(command, ...) {
  if(command == driver.DECLARE_INPUTS) {
    return(c("L201.Pop_SEA",
             "L201.BaseGDP_SEA",
             "L201.LaborForceFillout_SEA",
             "L201.LaborProductivity_SEA"))
  } else if(command == driver.DECLARE_OUTPUTS) {
    return(c(XML = "socioeconomics_SEA.xml"))
  } else if(command == driver.MAKE) {

    all_data <- list(...)[[1]]

    # Load required inputs
    L201.Pop_SEA <- get_data(all_data, "L201.Pop_SEA")
    L201.BaseGDP_SEA <- get_data(all_data, "L201.BaseGDP_SEA")
    L201.LaborForceFillout_SEA <- get_data(all_data, "L201.LaborForceFillout_SEA")
    L201.LaborProductivity_SEA <- get_data(all_data, "L201.LaborProductivity_SEA")

    # ===================================================

    # Produce outputs
    create_xml("socioeconomics_SEA.xml") %>%
      add_xml_data(L201.Pop_SEA, "Pop") %>%
      add_xml_data(L201.BaseGDP_SEA, "BaseGDP") %>%
      add_xml_data(L201.LaborForceFillout_SEA, "LaborForceFillout") %>%
      add_xml_data(L201.LaborProductivity_SEA, "LaborProductivity") %>%
      add_precursors("L201.Pop_SEA",
                     "L201.BaseGDP_SEA",
                     "L201.LaborForceFillout_SEA",
                     "L201.LaborProductivity_SEA") ->
      socioeconomics_SEA.xml

    return_data(socioeconomics_SEA.xml)
  } else {
    stop("Unknown command")
  }
}

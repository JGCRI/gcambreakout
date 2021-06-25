# Copyright 2019 Battelle Memorial Institute; see the LICENSE file.

#' module_breakout_Xbatch_socioeconomics_xml_APPEND
#'
#' Construct XML data structure for \code{socioeconomics_USA.xml}.
#'
#' @param command API command to execute
#' @param ... other optional parameters, depending on command
#' @return Depends on \code{command}: either a vector of required inputs,
#' a vector of output names, or (if \code{command} is "MAKE") all
#' the generated outputs: \code{socioeconomics_USA.xml}. The corresponding file in the
#' original data system was \code{batch_socioeconomics_USA.xml} (gcamusa XML).
module_breakout_Xbatch_socioeconomics_xml_APPEND <- function(command, ...) {
  if(command == driver.DECLARE_INPUTS) {
    return(c("X201.Pop_APPEND",
             "X201.BaseGDP_APPEND",
             "X201.LaborForceFillout_APPEND",
             "X201.LaborProductivity_APPEND"))
  } else if(command == driver.DECLARE_OUTPUTS) {
    return(c(XML = "socioeconomics_APPEND.xml"))
  } else if(command == driver.MAKE) {

    all_data <- list(...)[[1]]

    # Load required inputs
    X201.Pop_APPEND <- get_data(all_data, "X201.Pop_APPEND")
    X201.BaseGDP_APPEND <- get_data(all_data, "X201.BaseGDP_APPEND")
    X201.LaborForceFillout_APPEND <- get_data(all_data, "X201.LaborForceFillout_APPEND")
    X201.LaborProductivity_APPEND <- get_data(all_data, "X201.LaborProductivity_APPEND")

    # ===================================================

    # Produce outputs
    create_xml("socioeconomics_APPEND.xml") %>%
      add_xml_data(X201.Pop_APPEND, "Pop") %>%
      add_xml_data(X201.BaseGDP_APPEND, "BaseGDP") %>%
      add_xml_data(X201.LaborForceFillout_APPEND, "LaborForceFillout") %>%
      add_xml_data(X201.LaborProductivity_APPEND, "LaborProductivity") %>%
      add_precursors("X201.Pop_APPEND",
                     "X201.BaseGDP_APPEND",
                     "X201.LaborForceFillout_APPEND",
                     "X201.LaborProductivity_APPEND") ->
      socioeconomics_APPEND.xml

    return_data(socioeconomics_APPEND.xml)
  } else {
    stop("Unknown command")
  }
}

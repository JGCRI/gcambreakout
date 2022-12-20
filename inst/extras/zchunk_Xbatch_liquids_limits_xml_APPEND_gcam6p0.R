# Copyright 2019 Battelle Memorial Institute; see the LICENSE file.

#' module_Xbatch_liquids_limits_xml_APPEND
#'
#' Construct XML data structure for \code{socioeconomics_USA.xml}.
#'
#' @param command API command to execute
#' @param ... other optional parameters, depending on command
#' @return Depends on \code{command}: either a vector of required inputs,
#' a vector of output names, or (if \code{command} is "MAKE") all
#' the generated outputs: \code{socioeconomics_USA.xml}. The corresponding file in the
#' original data system was \code{batch_socioeconomics_USA.xml} (gcamusa XML).
module_Xbatch_liquids_limits_xml_APPEND <- function(command, ...) {
  if(command == driver.DECLARE_INPUTS) {
    return(c("X201.Pop_APPEND",
             "L270.CreditMkt"))
  } else if(command == driver.DECLARE_OUTPUTS) {
    return(c(XML = "liquids_limits_APPEND.xml"))
  } else if(command == driver.MAKE) {

    all_data <- list(...)[[1]]

    # Load required inputs
    X201.Pop_APPEND <- get_data(all_data, "X201.Pop_APPEND")
    L270.CreditMkt <- get_data(all_data, "L270.CreditMkt")

    subregions <- unique(X201.Pop_APPEND$region)
    subregions <- subregions[!subregions %in% c("APPEND_REGION")]

    PortfolioStd_APPEND <- L270.CreditMkt %>%
      write_to_breakout_regions(data = .,
                                composite_region = "APPEND_REGION",
                                disag_regions = c(subregions))

    # ===================================================

    # Produce outputs
    create_xml("liquids_limits_APPEND.xml") %>%
      add_xml_data(PortfolioStd_APPEND, "PortfolioStd") %>%
      add_precursors("X201.Pop_APPEND","L270.CreditMkt") ->
      liquids_limits_APPEND.xml

    return_data(liquids_limits_APPEND.xml)
  } else {
    stop("Unknown command")
  }
}

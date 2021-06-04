# Copyright 2019 Battelle Memorial Institute; see the LICENSE file.

# breakout_helpers.R

# Functions that are useful in Southeast Asia disaggregation studies

#' write_to_breakout_regions
#'
#' Copy Thailand data to disaggregated Bangkok and Rest of Thailand regions
#'
#' @param data Data frame with a "region" column
#' @param composite_region Composite (larger) region that data are being copied from (e.g. "Thailand")
#' @param disag_regions Disaggregated regions that data are being copied to (e.g. c("Bangkok","Rest of Thailand"))
#' @return Table with both regions.
#' @details This function is designed to take data from a composite (standard) region that is
#' generic in nature and apply it similarly to disaggregated regions
#' @importFrom dplyr mutate select
write_to_breakout_regions <- function(
  data = NULL,
  composite_region = NULL,
  disag_regions = NULL){

   if(is.null(data) | is.null(composite_region) | is.null(disag_regions)){
     stop("Null data passed to breakout-helpers.R write_to_breakout_regions()")
   }

  data_new <- subset(data, region == composite_region)

  if(nrow(data_new) > 0){
    data_new %>%
      repeat_add_columns(tibble(new_region = disag_regions)) %>%
      mutate(region = new_region) %>%
      select(-new_region) ->
      data_new
  }
  return(data_new)
}

#' downscale_to_breakout_regions
#'
#' Downscale (apportion) Thailand data to disaggregated Bangkok and Rest of Thailand regions
#'
#' @param data Data frame with a "region" column
#' @param composite_region Composite (larger) region that data are being downscaled from (e.g. "Thailand")
#' @param disag_regions Disaggregated regions that data are being assigned to (e.g. c("Bangkok", "Rest of Thailand"))
#' @param share_data Data frame with the disaggregated regions' shares to use for downscaling
#' @param value.column Name of the column in data to be downscaled (e.g. "value")
#' @param share.column Name of the column in share_data to use for the downscaling (e.g. "popshare", "gdpshare")
#' @return Table with both regions and values that are properly assigned
#' @details Uses some share proxy to apportion some physical quantity from the composite
#' region to its constituent disaggregated regions. The default is to use population shares.
#' @importFrom dplyr mutate select
downscale_to_breakout_regions <- function(
  data = NULL,
  composite_region = NULL,
  disag_regions = NULL,
  share_data = NULL,
  value.column = NULL,
  share.column = NULL,
  ndigits = energy.DIGITS_CALOUTPUT){

  if(is.null(data) | is.null(composite_region) | is.null(disag_regions) | is.null(share_data) |
     is.null(value.column) | is.null(share.column)){
    stop("Null data passed to breakout-helpers.R write_to_breakout_regions()")
  }

  data_new <- subset(data, region == composite_region) %>%
    repeat_add_columns(tibble(new_region = disag_regions)) %>%
    mutate(region = new_region) %>%
    select(-new_region) %>%
    left_join_error_no_match(share_data, by = c("region", "year"))
  data_new[[value.column]] = round(data_new[[value.column]] * data_new[[share.column]], digits = ndigits)
  data_new <- data_new[names(data)]
  return(data_new)
}


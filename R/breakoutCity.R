# breakoutCity.R
#' Function to breakout region in gcamdata
#' @param gcamdataFolder Default = NULL. Full path to gcamdata folder.
#' @param region Default = NULL. Name of The region from which to break out the city.
#' @param city Default = NULL. Name of city to breakout.
#' @param popProjection Default = NULL. Projection of population for city.
#' @param gdpProjection Default = NULL. Projection of per capita gdp for city.
#' @importFrom magrittr %>%
#' @importFrom data.table :=
#' @export
#'

breakoutCity <- function(gcamdataFolder = NULL,
                         region = NULL,
                         city = NULL,
                         popProjection = NULL,
                         pcgdpProjection = NULL) {

  #..............
  # Initialize
  #.............

  if(T){
    print("Starting breakoutCity ...")

    # Declare File Names
    file_iso_GCAM_regID = paste(gcamdataFolder,"/inst/extdata/common/iso_GCAM_regID.csv",sep = "")
    file_GCAM_region_names = paste(gcamdataFolder,"/inst/extdata/common/GCAM_region_names.csv",sep = "")

  }

  #..............
  # Check inputs
  #.............

  if(T){

    # gcamdatafolder
    if (is.null(gcamdataFolder)) {
      stop("Please provide a gcamdataFolder path.")
    } else{
      if (!dir.exists(gcamdataFolder)) {
        stop("The gcamdataFolder path given does not exist.")
      }
    }

    # check region
    if (is.null(region)) {
      stop("Please provide a GCAM region name for the argument 'region'.")
    } else{
      if (file.exists(file_GCAM_region_names)) {

        # read in file
        GCAM_region_names = utils::read.csv(file_GCAM_region_names, sep = ",",comment.char="#") %>% tibble::as_tibble(); GCAM_region_names

        # Check if Region provided is in the list of regions
        if(!region %in% unique(GCAM_region_names$region)){
          stop(paste0("'region' provided is not part of GCAM regions in ",gcamdataFolder,"/inst/extdata/common/GCAM_region_names.csv"))
        }

      } else {
        stop(paste0("'",gcamdataFolder,"/inst/extdata/common/GCAM_region_names.csv' does not exist."))
      }
    }

    # Check projection files
    # Check that population file format is correct and contains both city as well as Rest of Region data
    # Check that pcgdp file format is correct and contains both city as well as Rest of Region data

    print("Input checks completed...")
  }

  #..............
  # Process Data
  #.............

  # Create a new folder in gcamdata to hold the city breakout files
  # in ./input/gcamdata/inst/extdata/

  # Copy the popProjection and pcgdpProjection files to the new city folder

  # Modify the template R files and replace with new city and corresponding region name

  # Copy the modified R files into the R folder: ./input/gcamdata/R/

  #..............
  # Close out
  #.............



}

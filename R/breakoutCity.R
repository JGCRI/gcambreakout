# breakoutCity.R
#' Function to breakout region in gcamdata
#' @param gcamdataFolder Default = NULL. Full path to gcamdata folder.
#' @param region Default = NULL. Name of The region from which to break out the city.
#' @param city Default = NULL. Name of city to breakout.
#' @param popProjection Default = NULL. Projection of population for city.
#' @param pcgdpProjection Default = NULL. Projection of per capita gdp for city.
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
    pop = utils::read.csv(popProjection, sep = ",", comment.char = "#")%>% tibble::as_tibble(); pop
    if (!(city %in% unique(pop$region) & paste0("Rest of ",region) %in% unique(pop$region) & ncol(pop)==3)){
      stop("Please check population projection file is formatted correctly.")
    }
    # Check that pcgdp file format is correct and contains both city as well as Rest of Region data
    pcgdp = utils::read.csv(pcgdpProjection, sep = ",", comment.char = "#")%>% tibble::as_tibble(); pcgdp
    if (!(city %in% unique(pcgdp$region) & paste0("Rest of ",region) %in% unique(pcgdp$region) & ncol(pcgdp)==3)){
      stop("Please check PCGDP projection file is formatted correctly.")
    }

    print("Input checks completed...")
  }

  #..............
  # Process Data
  #.............

  if(T){
    # Create a new folder in gcamdata to hold the city breakout files
    # in ./input/gcamdata/inst/extdata/
    breakoutFolder=(paste0(gcamdataFolder, "/inst/extdata/breakout"))
    dir.create(breakoutFolder)

    # Copy the popProjection and pcgdpProjection files to the new city folder
    file.copy(popProjection, paste0(breakoutFolder, "/", city, "_", region, "_pop.csv"))
    file.copy(pcgdpProjection, paste0(breakoutFolder,"/", city, "_", region,"_pcgdp.csv"))

    # Modify the template R files and replace with new city and corresponding region name
    # R files can be modified directly from the data templates:
    zchunk_X201 <- stringr::str_replace_all(gcambreakout::template_zchunk_X201.socioeconomic_APPEND, "APPEND", paste0(city, "_", region))
    zchunk_Xbatch <- stringr::str_replace_all(gcambreakout::template_zchunk_Xbatch_socioeconomics_APPEND, "APPEND", paste0(city, "_", region))


    ##### Write modified R files into the R folder
    readr::write_lines(zchunk_X201,paste0(gcamdataFolder, "/R/zchunk_X201.socioeconomic_", city, "_", region, ".R"))
    readr::write_lines(zchunk_Xbatch,paste0(gcamdataFolder, "/R/zchunk_Xbatch_socioeconomics_",  city, "_", region, ".R"))
    }


  #..............
  # Close out
  #.............



}

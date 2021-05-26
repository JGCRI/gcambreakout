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

  # gcamdataFolder = NULL
  # region = NULL
  # city = NULL
  # popProjection = NULL
  # pcgdpProjection = NULL

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
    if(is.null(popProjection)){
      print("Please provide full path to the 'popProjection' file as a .csv or enter an R Data Table.")
      print("This file must contain population projections for the city as well as for the Rest of 'Region'.")
      print("It should have the following format as provided in the example gcambreakout::template_popProjection for region = THailand and city = Bangkok")
      print(gcambreakout::template_popProjection)
      stop("Please provide full path to the 'popProjection' file as a .csv or enter an R Data Table.")
    }

    if(is.null(pcgdpProjection)){
      print("Please provide the 'pcgdpProjection' file as a .csv or enter an R Data Table.")
      print("This file must contain per capita GDP projections for the city as well as for the Rest of 'Region'.")
      print("It should have the following format as provided in the example gcambreakout::template_pcgdpProjection for region = THailand and city = Bangkok")
      print(gcambreakout::template_pcgdpProjection)
      stop("Please provide the 'pcgdpProjection' file as a .csv or enter an R Data Table.")
    }

    # Check that population file format is correct and contains both city as well as Rest of Region data
    if(any(class(popProjection) %in% "character")){
      if(grepl(".csv",popProjection)){
        if(file.exists(popProjection)){
          pop = utils::read.csv(popProjection, sep = ",", comment.char = "#")%>% tibble::as_tibble()
        } else {stop(paste0("popProjection file provided does not exist: ", popProjection))}
      }
    } else { pop = popProjection}
    if (!(city %in% unique(pop$region) & paste0("Rest of ",region) %in% unique(pop$region) & ncol(pop)==3)){
      stop("Please check population projection file is formatted correctly.")
    }

    # Check that pcgdp file format is correct and contains both city as well as Rest of Region data
    if(any(class(pcgdpProjection) %in% "character")){
      if(grepl(".csv",pcgdpProjection)){
        if(file.exists(pcgdpProjection)){
          pcgdp = utils::read.csv(pcgdpProjection, sep = ",", comment.char = "#")%>% tibble::as_tibble(); pcgdp
        } else {stop(paste0("pcgdpProjection file provided does not exist: ", pcgdpProjection))}
      }
    } else { pcgdp = pcgdpProjection}
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
    if(!dir.exists(breakoutFolder)){dir.create(breakoutFolder)}

    # Check to make sure the city and region files don't already exist
    if(T){
      if(file.exists(paste0(breakoutFolder, "/", city, "_", region, "_pop.csv"))){
        print(paste0("A file for this city and region already exists: ", breakoutFolder, "/", city, "_", region, "_pop.csv",
                     " and will be overwritten."))
        unlink(paste0(breakoutFolder, "/", city, "_", region, "_pop.csv"))
      }

      if(file.exists(paste0(breakoutFolder, "/", city, "_", region, "_pcgdp.csv"))){
        print(paste0("A file for this city and region already exists: ", breakoutFolder, "/", city, "_", region, "_pcgdp.csv",
                     " and will be overwritten."))
        unlink(paste0(breakoutFolder, "/", city, "_", region, "_pcgdp.csv"))
      }

      if(file.exists(paste0(gcamdataFolder, "/R/zchunk_Xbatch_socioeconomics_xml_",  city, "_", region, ".R"))){
        print(paste0("R file for this city and region already exists: ", paste0(gcamdataFolder, "/R/zchunk_Xbatch_socioeconomics_xml_",  city, "_", region, ".R"),
                     " and will be overwritten."))
        unlink(paste0(gcamdataFolder, "/R/zchunk_Xbatch_socioeconomics_xml_",  city, "_", region, ".R"))
      }

      if(file.exists(paste0(gcamdataFolder, "/R/zchunk_X201.socioeconomic_", city, "_", region, ".R"))){
        print(paste0("R file for this city and region already exists: ", paste0(gcamdataFolder, "/R/zchunk_X201.socioeconomic_", city, "_", region, ".R"),
                     " and will be overwritten."))
        unlink(paste0(gcamdataFolder, "/R/zchunk_X201.socioeconomic_", city, "_", region, ".R"))
      }

      # Check buildings files don't already exist

      if(file.exists(paste0(gcamdataFolder, "/R/zchunk_Xbatch_building_xml_",  city, "_", region, ".R"))){
        print(paste0("R file for this city and region already exists: ", paste0(gcamdataFolder, "/R/zchunk_Xbatch_building_xml_",  city, "_", region, ".R"),
                     " and will be overwritten."))
        unlink(paste0(gcamdataFolder, "/R/zchunk_Xbatch_building_xml_",  city, "_", region, ".R"))
      }

      if(file.exists(paste0(gcamdataFolder, "/R/zchunk_X244.building_", city, "_", region, ".R"))){
        print(paste0("R file for this city and region already exists: ", paste0(gcamdataFolder, "/R/zchunk_X244.building_", city, "_", region, ".R"),
                     " and will be overwritten."))
        unlink(paste0(gcamdataFolder, "/R/zchunk_X244.building_", city, "_", region, ".R"))
      }

    }


    # Add comments to pop files
    filename = paste0(breakoutFolder, "/", city, "_", region, "_pop.csv")
    con <- file(filename, open = "wt")
    comments <- data.frame(Comments=
      c(paste0("# File:",city, "_", region, "_pop.csv"),
        paste0("# Title:", city, " and rest-of-", region," population (all years)"),
        "# Units: millions",
        "# Description: Computed off-line",
        "# Column types: cin",
        "# ----------"))
    for (i in 1:nrow(comments)) {
      writeLines(paste(comments[i, ]), con)
    }
    utils::write.csv(pop, con, row.names = F)
    close(con)
    closeAllConnections()

    # Add comments to pcgdp files
    filename = paste0(breakoutFolder, "/", city, "_", region, "_pcgdp.csv")
    con <- file(filename, open = "wt")
    comments <- data.frame(Comments=
                             c(paste0("# File:",city, "_", region, "_pcgdp.csv"),
                               paste0("# Title:", city, " and rest-of-", region," pcgdp"),
                               "# Units: thousand 2005 USD per capita",
                               "# Description: Computed off-line",
                               "# Column types: cin",
                               "# ----------"))
    for (i in 1:nrow(comments)) {
      writeLines(paste(comments[i, ]), con)
    }
    utils::write.csv(pcgdp, con, row.names = F)
    close(con)
    closeAllConnections()

    # Modify the template R files and replace with new city and corresponding region name

    # Modify Socioeconomic R Files
    zchunk_X201 <- stringr::str_replace_all(gcambreakout::template_zchunk_X201.socioeconomic_APPEND, "APPEND", paste0(city, "_", region))
    zchunk_Xbatch <- stringr::str_replace_all(gcambreakout::template_zchunk_Xbatch_socioeconomics_xml_APPEND, "APPEND", paste0(city, "_", region))

    # Modify Buildings R Files
    zchunk_X201_build <- stringr::str_replace_all(gcambreakout::template_zchunk_X244.building_APPEND, c("APPEND_CITY" = city, "APPEND_REGION" = region, "APPEND"= paste0(city, "_", region)))
    zchunk_Xbatch_build <- stringr::str_replace_all(gcambreakout::template_zchunk_Xbatch_building_xml_APPEND, c("APPEND_CITY" = city, "APPEND_REGION" = region, "APPEND"= paste0(city, "_", region)))

    ##### Write modified R files into the R folder

    # Write out Breakout helper functions
    readr::write_lines(template_breakout_helpers,paste0(gcamdataFolder, "/R/breakout_helpers.R"))
    print(paste0("Added new file: ", gcamdataFolder, "/R/breakout_helpers.R"))

    # Write out Socioeconomics Files
    readr::write_lines(zchunk_X201,paste0(gcamdataFolder, "/R/zchunk_X201.socioeconomic_", city, "_", region, ".R"))
    print(paste0("Added new file: ", gcamdataFolder, "/R/zchunk_X201.socioeconomic_", city, "_", region, ".R"))

    readr::write_lines(zchunk_Xbatch,paste0(gcamdataFolder, "/R/zchunk_Xbatch_socioeconomics_xml_",  city, "_", region, ".R"))
    print(paste0("Added new file: ", gcamdataFolder, "/R/zchunk_Xbatch_socioeconomics_xml_",  city, "_", region, ".R"))

    # Write out Buildings Files
    readr::write_lines(zchunk_X201_build, paste0(gcamdataFolder, "/R/zchunk_X244.building_", city, "_", region, ".R"))
    print(paste0("Added new file: ", gcamdataFolder, "/R/zchunk_X244.building_", city, "_", region, ".R"))

    readr::write_lines(zchunk_Xbatch_build, paste0(gcamdataFolder, "/R/zchunk_Xbatch_building_xml_",  city, "_", region, ".R"))
    print(paste0("Added new file: ", gcamdataFolder, "/R/zchunk_Xbatch_building_xml_",  city, "_", region, ".R"))
  }


  #..............
  # Close out
  #.............

  print(paste0("City: ", city, " sucessfully broken out from region: ", region, "."))
  print(paste0("Please re-install gcamdata and re-run driver from your folder: ",gcamdataFolder))
  print(paste0("After running driver() please add the following xml to your configuration files:"))
  print(paste0("socioeconomics_", city, "_", region, ".xml"))
  print(paste0("buidling_", city, "_", region, ".xml"))
  print(paste0("Note: If during gcamdatabuild error: 'Error: .../input/gcamdata/man/GCAM_DATA_MAP.Rd:17: Bad /link text'",
               ", delete './input/gcamdata/man/GCAM_DATA_MAP.Rd' and then run devtools::install() in gcamdata.",
               " (Do not rebuild documentation after deleting GCAM_DATA_MAP.Rd."))
  print("breakoutCity complete.")


}

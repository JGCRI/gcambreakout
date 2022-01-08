# breakout_subregion.R
#' Function to breakout subregion in gcamdata
#' @param gcamdataFolder Default = NULL. Full path to gcamdata folder.
#' @param region Default = NULL. Name of The region from which to break out the subregion.
#' @param subregion Default = NULL. Name of subregion to breakout.
#' @param pop_projection Default = NULL. Projection of population for subregion.
#' @param pcgdp_projection Default = NULL. Projection of per capita gdp for subregion.
#' @importFrom magrittr %>%
#' @importFrom data.table :=
#' @export
#'

breakout_subregion <- function(gcamdataFolder = NULL,
                         region = NULL,
                         subregion = NULL,
                         pop_projection = NULL,
                         pcgdp_projection = NULL) {

  # Fold Code: Alt + 0
  # Unfold Code: Alt + SHIFT + O

  #..............
  # Initialize
  #.............

  if(T){
    print("Starting breakout_subregion ...")

    # Declare File Names
    file_iso_GCAM_regID = paste(gcamdataFolder,"/inst/extdata/common/iso_GCAM_regID.csv",sep = "")
    file_GCAM_region_names = paste(gcamdataFolder,"/inst/extdata/common/GCAM_region_names.csv",sep = "")

  }


  #...............
  # Loop Across subregions
  #...............

  for(i in 1:length(subregion)){

    subregion_i_original <- subregion[i]
    subregion_i <- gsub(" ","",subregion_i_original) # Remove spaces from name
    pop_projection_i <- pop_projection[i]
    pcgdp_projection_i <- pcgdp_projection[i]


    print(paste0("Starting breakout for subregion: ", subregion_i))

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
    if(is.null(pop_projection_i)){
      print("Please provide full path to the 'pop_projection_i' file as a .csv or enter an R Data Table.")
      print("This file must contain population projections for the subregion_i as well as for the Rest of 'Region'.")
      print("It should have the following format as provided in the example gcambreakout::template_pop_projection for region = THailand and subregion_i = Bangkok")
      print(gcambreakout::template_pop_projection)
      stop("Please provide full path to the 'pop_projection_i' file as a .csv or enter an R Data Table.")
    }

    if(is.null(pcgdp_projection_i)){
      print("Please provide the 'pcgdp_projection_i' file as a .csv or enter an R Data Table.")
      print("This file must contain per capita GDP projections for the subregion_i as well as for the Rest of 'Region'.")
      print("It should have the following format as provided in the example gcambreakout::template_pcgdp_projection for region = THailand and subregion_i = Bangkok")
      print(gcambreakout::template_pcgdp_projection)
      stop("Please provide the 'pcgdp_projection_i' file as a .csv or enter an R Data Table.")
    }

    # Check that population file format is correct and contains both subregion_i as well as Rest of Region data
    if(any(class(pop_projection_i) %in% "character")){
      if(grepl(".csv",pop_projection_i)){
        if(file.exists(pop_projection_i)){
          pop = utils::read.csv(pop_projection_i, sep = ",", comment.char = "#")%>% tibble::as_tibble()
        } else {stop(paste0("pop_projection_i file provided does not exist: ", pop_projection_i))}
      }
    } else { pop = pop_projection_i}

    # Remove spaces from subregion names
    pop <- pop %>%
      dplyr::mutate(region = dplyr::if_else(region==subregion_i_original,gsub(" ","",region),region)) %>%
      dplyr::select(region,year,population)

    if (!(subregion_i %in% unique(pop$region) & paste0("Rest of ",region) %in% unique(pop$region) & ncol(pop)==3)){
      stop("Please check population projection file is formatted correctly.")
    }



    # Check that pcgdp file format is correct and contains both subregion_i as well as Rest of Region data
    if(any(class(pcgdp_projection_i) %in% "character")){
      if(grepl(".csv",pcgdp_projection_i)){
        if(file.exists(pcgdp_projection_i)){
          pcgdp = utils::read.csv(pcgdp_projection_i, sep = ",", comment.char = "#")%>% tibble::as_tibble(); pcgdp
        } else {stop(paste0("pcgdp_projection_i file provided does not exist: ", pcgdp_projection_i))}
      }
    } else { pcgdp = pcgdp_projection_i}

    # Remove spaces from subregion names
    pcgdp <- pcgdp %>%
      dplyr::mutate(region = dplyr::if_else(region==subregion_i_original,gsub(" ","",region),region)) %>%
      dplyr::select(region,year,pcgdp)

    if (!(subregion_i %in% unique(pcgdp$region) & paste0("Rest of ",region) %in% unique(pcgdp$region) & ncol(pcgdp)==3)){
      stop("Please check PCGDP projection file is formatted correctly.")
    }



    print("Input checks completed...")
  }

  #..............
  # Process Data
  #.............

  if(T){
    # Create a new folder in gcamdata to hold the subregion_i breakout files
    # in ./input/gcamdata/inst/extdata/
    breakoutFolder=(paste0(gcamdataFolder, "/inst/extdata/breakout"))
    if(!dir.exists(breakoutFolder)){dir.create(breakoutFolder)}

    # Check to make sure the subregion_i and region socio economic files don't already exist
    if(T){
      if(file.exists(paste0(breakoutFolder, "/", subregion_i, "_", region, "_pop.csv"))){
        print(paste0("A file for this subregion_i and region already exists: ", breakoutFolder, "/", subregion_i, "_", region, "_pop.csv",
                     " and will be overwritten."))
        unlink(paste0(breakoutFolder, "/", subregion_i, "_", region, "_pop.csv"))
      }

      if(file.exists(paste0(breakoutFolder, "/", subregion_i, "_", region, "_pcgdp.csv"))){
        print(paste0("A file for this subregion_i and region already exists: ", breakoutFolder, "/", subregion_i, "_", region, "_pcgdp.csv",
                     " and will be overwritten."))
        unlink(paste0(breakoutFolder, "/", subregion_i, "_", region, "_pcgdp.csv"))
      }

      if(file.exists(paste0(gcamdataFolder, "/R/zchunk_Xbatch_socioeconomics_xml_",  subregion_i, "_", region, ".R"))){
        print(paste0("R file for this subregion_i and region already exists: ", paste0(gcamdataFolder, "/R/zchunk_Xbatch_socioeconomics_xml_",  subregion_i, "_", region, ".R"),
                     " and will be overwritten."))
        unlink(paste0(gcamdataFolder, "/R/zchunk_Xbatch_socioeconomics_xml_",  subregion_i, "_", region, ".R"))
      }

      if(file.exists(paste0(gcamdataFolder, "/R/zchunk_X201.socioeconomic_", subregion_i, "_", region, ".R"))){
        print(paste0("R file for this subregion_i and region already exists: ", paste0(gcamdataFolder, "/R/zchunk_X201.socioeconomic_", subregion_i, "_", region, ".R"),
                     " and will be overwritten."))
        unlink(paste0(gcamdataFolder, "/R/zchunk_X201.socioeconomic_", subregion_i, "_", region, ".R"))
      }

      # Check to make sure buildings files don't already exist

      if(file.exists(paste0(gcamdataFolder, "/R/zchunk_Xbatch_building_xml_",  subregion_i, "_", region, ".R"))){
        print(paste0("R file for this subregion_i and region already exists: ", paste0(gcamdataFolder, "/R/zchunk_Xbatch_building_xml_",  subregion_i, "_", region, ".R"),
                     " and will be overwritten."))
        unlink(paste0(gcamdataFolder, "/R/zchunk_Xbatch_building_xml_",  subregion_i, "_", region, ".R"))
      }

      if(file.exists(paste0(gcamdataFolder, "/R/zchunk_X244.building_", subregion_i, "_", region, ".R"))){
        print(paste0("R file for this subregion_i and region already exists: ", paste0(gcamdataFolder, "/R/zchunk_X244.building_", subregion_i, "_", region, ".R"),
                     " and will be overwritten."))
        unlink(paste0(gcamdataFolder, "/R/zchunk_X244.building_", subregion_i, "_", region, ".R"))
      }

      # Check to make sure transport files don't already exist
      if(file.exists(paste0(gcamdataFolder, "/R/zchunk_Xbatch_transportation_xml_",  subregion_i, "_", region, ".R"))){
        print(paste0("R file for this subregion_i and region already exists: ", paste0(gcamdataFolder, "/R/zchunk_Xbatch_transportation_xml_",  subregion_i, "_", region, ".R"),
                     " and will be overwritten."))
        unlink(paste0(gcamdataFolder, "/R/zchunk_Xbatch_transportation_xml_",  subregion_i, "_", region, ".R"))
      }

      if(file.exists(paste0(gcamdataFolder, "/R/zchunk_X254.transportation_", subregion_i, "_", region, ".R"))){
        print(paste0("R file for this subregion_i and region already exists: ", paste0(gcamdataFolder, "/R/zchunk_X254.transportation_", subregion_i, "_", region, ".R"),
                     " and will be overwritten."))
        unlink(paste0(gcamdataFolder, "/R/zchunk_X254.transportation_", subregion_i, "_", region, ".R"))
      }

      # Check to make sure industry files don't already exist
      if(file.exists(paste0(gcamdataFolder, "/R/zchunk_Xbatch_industry_xml_",  subregion_i, "_", region, ".R"))){
        print(paste0("R file for this subregion_i and region already exists: ", paste0(gcamdataFolder, "/R/zchunk_Xbatch_industry_xml_",  subregion_i, "_", region, ".R"),
                     " and will be overwritten."))
        unlink(paste0(gcamdataFolder, "/R/zchunk_Xbatch_industry_xml_",  subregion_i, "_", region, ".R"))
      }

      if(file.exists(paste0(gcamdataFolder, "/R/zchunk_X232.industry_", subregion_i, "_", region, ".R"))){
        print(paste0("R file for this subregion_i and region already exists: ", paste0(gcamdataFolder, "/R/zchunk_X232.industry_", subregion_i, "_", region, ".R"),
                     " and will be overwritten."))
        unlink(paste0(gcamdataFolder, "/R/zchunk_X232.industry_", subregion_i, "_", region, ".R"))
      }

      # Check to make sure liquid limits files don't already exist
      if(file.exists(paste0(gcamdataFolder, "/R/zchunk_Xbatch_liquids_limits_xml_",  subregion_i, "_", region, ".R"))){
        print(paste0("R file for this subregion_i and region already exists: ", paste0(gcamdataFolder, "/R/zchunk_Xbatch_liquids_limits_xml_",  subregion_i, "_", region, ".R"),
                     " and will be overwritten."))
        unlink(paste0(gcamdataFolder, "/R/zchunk_Xbatch_liquids_limits_xml_",  subregion_i, "_", region, ".R"))
      }

    }


    # Add comments to files
    if(T){
    # Add comments to pop files
    filename = paste0(breakoutFolder, "/", subregion_i, "_", region, "_pop.csv")
    con <- file(filename, open = "wt")
    comments <- data.frame(Comments=
      c(paste0("# File:",subregion_i, "_", region, "_pop.csv"),
        paste0("# Title:", subregion_i, " and rest-of-", region," population (all years)"),
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
    filename = paste0(breakoutFolder, "/", subregion_i, "_", region, "_pcgdp.csv")
    con <- file(filename, open = "wt")
    comments <- data.frame(Comments=
                             c(paste0("# File:",subregion_i, "_", region, "_pcgdp.csv"),
                               paste0("# Title:", subregion_i, " and rest-of-", region," pcgdp"),
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
    }

    # Modify the template R files and replace with new subregion_i and corresponding region name
    if(T){
    # Modify Socioeconomic R Files
    zchunk_X201 <- stringr::str_replace_all(gcambreakout::template_zchunk_X201.socioeconomic_APPEND, "APPEND", paste0(subregion_i, "_", region))
    zchunk_Xbatch <- stringr::str_replace_all(gcambreakout::template_zchunk_Xbatch_socioeconomics_xml_APPEND, "APPEND", paste0(subregion_i, "_", region))

    # Modify Buildings R Files
    zchunk_X244_build <- stringr::str_replace_all(gcambreakout::template_zchunk_X244.building_APPEND, c("APPEND_SUBREGION" = subregion_i, "APPEND_REGION" = region, "APPEND"= paste0(subregion_i, "_", region)))
    zchunk_Xbatch_build <- stringr::str_replace_all(gcambreakout::template_zchunk_Xbatch_building_xml_APPEND, c("APPEND_SUBREGION" = subregion_i, "APPEND_REGION" = region, "APPEND"= paste0(subregion_i, "_", region)))

    # Modify Industry R Files
    zchunk_X232_ind <- stringr::str_replace_all(gcambreakout::template_zchunk_X232.industry_APPEND, c("APPEND_SUBREGION" = subregion_i, "APPEND_REGION" = region, "APPEND"= paste0(subregion_i, "_", region)))
    zchunk_Xbatch_ind <- stringr::str_replace_all(gcambreakout::template_zchunk_Xbatch_industry_xml_APPEND, c("APPEND_SUBREGION" = subregion_i, "APPEND_REGION" = region, "APPEND"= paste0(subregion_i, "_", region)))

    # Modify Transport R Files
    zchunk_X254_trn <- stringr::str_replace_all(gcambreakout::template_zchunk_X254.transportation_APPEND, c("APPEND_SUBREGION" = subregion_i, "APPEND_REGION" = region, "APPEND"= paste0(subregion_i, "_", region)))
    zchunk_Xbatch_trn <- stringr::str_replace_all(gcambreakout::template_zchunk_Xbatch_transportation_xml_APPEND, c("APPEND_SUBREGION" = subregion_i, "APPEND_REGION" = region, "APPEND"= paste0(subregion_i, "_", region)))

    # Modify Liquid Limits R Files
    zchunk_Xbatch_liquid_limits <- stringr::str_replace_all(gcambreakout::template_zchunk_Xbatch_liquids_limits_xml_APPEND, c("APPEND_SUBREGION" = subregion_i, "APPEND_REGION" = region, "APPEND"= paste0(subregion_i, "_", region)))

    ##### Write modified R files into the R folder

    # Write out Breakout helper functions
    readr::write_lines(gcambreakout::template_breakout_helpers,paste0(gcamdataFolder, "/R/breakout_helpers.R"))
    print(paste0("Added new file: ", gcamdataFolder, "/R/breakout_helpers.R"))

    # Write out Socioeconomics Files
    readr::write_lines(zchunk_X201,paste0(gcamdataFolder, "/R/zchunk_X201.socioeconomic_", subregion_i, "_", region, ".R"))
    print(paste0("Added new file: ", gcamdataFolder, "/R/zchunk_X201.socioeconomic_", subregion_i, "_", region, ".R"))

    readr::write_lines(zchunk_Xbatch,paste0(gcamdataFolder, "/R/zchunk_Xbatch_socioeconomics_xml_",  subregion_i, "_", region, ".R"))
    print(paste0("Added new file: ", gcamdataFolder, "/R/zchunk_Xbatch_socioeconomics_xml_",  subregion_i, "_", region, ".R"))

    # Write out Buildings Files
    readr::write_lines(zchunk_X244_build, paste0(gcamdataFolder, "/R/zchunk_X244.building_", subregion_i, "_", region, ".R"))
    print(paste0("Added new file: ", gcamdataFolder, "/R/zchunk_X244.building_", subregion_i, "_", region, ".R"))

    readr::write_lines(zchunk_Xbatch_build, paste0(gcamdataFolder, "/R/zchunk_Xbatch_building_xml_",  subregion_i, "_", region, ".R"))
    print(paste0("Added new file: ", gcamdataFolder, "/R/zchunk_Xbatch_building_xml_",  subregion_i, "_", region, ".R"))

    # Write out Industry Files
    readr::write_lines(zchunk_X232_ind, paste0(gcamdataFolder, "/R/zchunk_X232.industry_", subregion_i, "_", region, ".R"))
    print(paste0("Added new file: ", gcamdataFolder, "/R/zchunk_X232.industry_", subregion_i, "_", region, ".R"))

    readr::write_lines(zchunk_Xbatch_ind, paste0(gcamdataFolder, "/R/zchunk_Xbatch_industry_xml_",  subregion_i, "_", region, ".R"))
    print(paste0("Added new file: ", gcamdataFolder, "/R/zchunk_Xbatch_industry_xml_",  subregion_i, "_", region, ".R"))

    # Write out Transport Files
    readr::write_lines(zchunk_X254_trn, paste0(gcamdataFolder, "/R/zchunk_X254.transportation_", subregion_i, "_", region, ".R"))
    print(paste0("Added new file: ", gcamdataFolder, "/R/zchunk_X254.transportation_", subregion_i, "_", region, ".R"))

    readr::write_lines(zchunk_Xbatch_trn, paste0(gcamdataFolder, "/R/zchunk_Xbatch_transportation_xml_",  subregion_i, "_", region, ".R"))
    print(paste0("Added new file: ", gcamdataFolder, "/R/zchunk_Xbatch_transportation_xml_",  subregion_i, "_", region, ".R"))

    # Write out Buildings Files
    readr::write_lines(zchunk_Xbatch_liquid_limits, paste0(gcamdataFolder, "/R/zchunk_Xbatch_liquids_limits_xml_",  subregion_i, "_", region, ".R"))
    print(paste0("Added new file: ", gcamdataFolder, "/R/zchunk_Xbatch_liquids_limits_xml_",  subregion_i, "_", region, ".R"))
    }
  }


  #..............
  # Close out
  #.............

  if(T){
  print(paste0("subregion_i: ", subregion_i, " sucessfully broken out from region: ", region, "."))
  print(paste0("Please re-install gcamdata and re-run driver from your folder: ",gcamdataFolder))
  print(paste0("After running driver() please add the following xml to your configuration files:"))
  print(paste0("socioeconomics_", subregion_i, "_", region, ".xml"))
  print(paste0("buidling_", subregion_i, "_", region, ".xml"))
  print(paste0("industry_", subregion_i, "_", region, ".xml"))
  print(paste0("transportation_", subregion_i, "_", region, ".xml"))
  print(paste0("liquid_limits_", subregion_i, "_", region, ".xml"))
  print(paste0("Note: If during gcamdatabuild error: 'Error: .../input/gcamdata/man/GCAM_DATA_MAP.Rd:17: Bad /link text'",
               ", delete './input/gcamdata/man/GCAM_DATA_MAP.Rd' and then run devtools::install() in gcamdata.",
               " (Do not rebuild documentation after deleting GCAM_DATA_MAP.Rd."))
  print("breakout_subregion_i complete.")
  }


} # Close subregion loop

}

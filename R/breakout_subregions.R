# breakout_subregions.R
#' Function to breakout subregion in gcamdata
#' @param gcamdataFolder Default = NULL. Full path to gcamdata folder.
#' @param region Default = NULL. Name of The region from which to break out the subregion.
#' @param pop_projection Default = NULL. Projection of population (millions) for subregions and rest of region.
#' @param pcgdp_projection Default = NULL. Projection of per capita gdp (thous 2005 USD per capita) for subregions and rest of region.
#' @importFrom magrittr %>%
#' @importFrom data.table :=
#' @export
#'

breakout_subregions <- function(gcamdataFolder = NULL,
                         region = NULL,
                         pop_projection = NULL,
                         pcgdp_projection = NULL) {

  # Fold Code: Alt + 0
  # Unfold Code: Alt + SHIFT + O

  #..............
  # Initialize
  #.............

  if(T){

    NULL -> population -> year

    rlang::inform("Starting breakout_subregions ...")

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
    if(is.null(pop_projection)){
      rlang::inform("Please provide full path to the 'pop_projection' file as a .csv or enter an R Data Table.")
      rlang::inform("This file must contain population projections for the subregions as well as for the Rest of 'Region'.")
      rlang::inform("It should have the following format as provided in the example gcambreakout::template_pop_projection for region = Thailand and subregions = Bangkok")
      rlang::inform(gcambreakout::template_pop_projection)
      stop("Please provide full path to the 'pop_projection' file as a .csv or enter an R Data Table.")
    }

    if(is.null(pcgdp_projection)){
      rlang::inform("Please provide the 'pcgdp_projection' file as a .csv or enter an R Data Table.")
      rlang::inform("This file must contain per capita GDP projections for the subregions as well as for the Rest of 'Region'.")
      rlang::inform("It should have the following format as provided in the example gcambreakout::template_pcgdp_projection for region = THailand and subregions = Bangkok")
      rlang::inform(gcambreakout::template_pcgdp_projection)
      stop("Please provide the 'pcgdp_projection' file as a .csv or enter an R Data Table.")
    }

    # Check that population file format is correct and contains both subregions as well as Rest of Region data
    if(any(class(pop_projection) %in% "character")){
      if(grepl(".csv",pop_projection)){
        if(file.exists(pop_projection)){
          pop = utils::read.csv(pop_projection, sep = ",", comment.char = "#")%>% tibble::as_tibble()
        } else {stop(paste0("pop_projection file provided does not exist: ", pop_projection))}
      }
    } else { pop = pop_projection}

    if (!any(paste0("Rest of ",region) %in% unique(pop$region) & ncol(pop)==3)){
      stop("Please check population projection file is formatted correctly.")
    }

    # Check that pcgdp file format is correct and contains both subregions as well as Rest of Region data
    if(any(class(pcgdp_projection) %in% "character")){
      if(grepl(".csv",pcgdp_projection)){
        if(file.exists(pcgdp_projection)){
          pcgdp = utils::read.csv(pcgdp_projection, sep = ",", comment.char = "#")%>% tibble::as_tibble(); pcgdp
        } else {stop(paste0("pcgdp_projection file provided does not exist: ", pcgdp_projection))}
      }
    } else { pcgdp = pcgdp_projection}

    if (!any(paste0("Rest of ",region) %in% unique(pcgdp$region) & ncol(pcgdp)==3)){
      stop("Please check PCGDP projection file is formatted correctly.")
    }


    subregions_pop <- unique(pop$region)
    subregions_pcgdp <- unique(pcgdp$region)
    if(!any(subregions_pop %in% subregions_pcgdp)){stop("subregions in pop_projection and pcgdp_projection file must be the same.")}
    subregions <- subregions_pop

    rlang::inform(paste0("Starting breakout for subregions: ", paste0(subregions,collapse=", ")))

    rlang::inform("Input checks completed...")
  }

  #..............
  # Process Data
  #.............

  if(T){
    # Create a new folder in gcamdata to hold the subregions breakout files
    # in ./input/gcamdata/inst/extdata/
    breakoutFolder=(paste0(gcamdataFolder, "/inst/extdata/breakout"))
    if(!dir.exists(breakoutFolder)){dir.create(breakoutFolder)}

    # Check to make sure the subregions and region socio economic files don't already exist
    if(T){
      if(file.exists(paste0(breakoutFolder, "/Subregions_", region, "_pop.csv"))){
        rlang::inform(paste0("File : ", breakoutFolder, "/Subregions_", region, "_pop.csv",
                     " already exists and will be overwritten."))
        unlink(paste0(breakoutFolder, "/Subregions_", region, "_pop.csv"))
      }

      if(file.exists(paste0(breakoutFolder, "/Subregions_", region, "_pcgdp.csv"))){
        rlang::inform(paste0("File: ", breakoutFolder, "/Subregions_", region, "_pcgdp.csv",
                     " alread exists and will be overwritten."))
        unlink(paste0(breakoutFolder, "/Subregions_", region, "_pcgdp.csv"))
      }

      if(file.exists(paste0(gcamdataFolder, "/R/zchunk_Xbatch_socioeconomics_xml_Subregions_", region, ".R"))){
        rlang::inform(paste0("R file: ", paste0(gcamdataFolder, "/R/zchunk_Xbatch_socioeconomics_xml_Subregions_", region, ".R"),
                     " already exists and will be overwritten."))
        unlink(paste0(gcamdataFolder, "/R/zchunk_Xbatch_socioeconomics_xml_Subregions_", region, ".R"))
      }

      if(file.exists(paste0(gcamdataFolder, "/R/zchunk_X201.socioeconomic_Subregions_", region, ".R"))){
        rlang::inform(paste0("R file: ", paste0(gcamdataFolder, "/R/zchunk_X201.socioeconomic_Subregions_", region, ".R"),
                     " already exists and will be overwritten."))
        unlink(paste0(gcamdataFolder, "/R/zchunk_X201.socioeconomic_Subregions_", region, ".R"))
      }

      # Check to make sure buildings files don't already exist

      if(file.exists(paste0(gcamdataFolder, "/R/zchunk_Xbatch_building_xml_Subregions_", region, ".R"))){
        rlang::inform(paste0("R file: ", paste0(gcamdataFolder, "/R/zchunk_Xbatch_building_xml_Subregions_", region, ".R"),
                     " already exists and will be overwritten."))
        unlink(paste0(gcamdataFolder, "/R/zchunk_Xbatch_building_xml_Subregions_", region, ".R"))
      }

      if(file.exists(paste0(gcamdataFolder, "/R/zchunk_X244.building_Subregions_", region, ".R"))){
        rlang::inform(paste0("R file: ", paste0(gcamdataFolder, "/R/zchunk_X244.building_Subregions_", region, ".R"),
                     " already exists and will be overwritten."))
        unlink(paste0(gcamdataFolder, "/R/zchunk_X244.building_Subregions_", region, ".R"))
      }

      # Check to make sure transport files don't already exist
      if(file.exists(paste0(gcamdataFolder, "/R/zchunk_Xbatch_transportation_xml_Subregions_", region, ".R"))){
        rlang::inform(paste0("R file: ", paste0(gcamdataFolder, "/R/zchunk_Xbatch_transportation_xml_Subregions_", region, ".R"),
                     " already exists and will be overwritten."))
        unlink(paste0(gcamdataFolder, "/R/zchunk_Xbatch_transportation_xml_Subregions_", region, ".R"))
      }

      if(file.exists(paste0(gcamdataFolder, "/R/zchunk_X254.transportation_Subregions_", region, ".R"))){
        rlang::inform(paste0("R file: ", paste0(gcamdataFolder, "/R/zchunk_X254.transportation_Subregions_", region, ".R"),
                     " already exists and will be overwritten."))
        unlink(paste0(gcamdataFolder, "/R/zchunk_X254.transportation_Subregions_", region, ".R"))
      }

      # Check to make sure industry files don't already exist
      if(file.exists(paste0(gcamdataFolder, "/R/zchunk_Xbatch_industry_xml_Subregions_", region, ".R"))){
        rlang::inform(paste0("R file: ", paste0(gcamdataFolder, "/R/zchunk_Xbatch_industry_xml_Subregions_", region, ".R"),
                     " already exists and will be overwritten."))
        unlink(paste0(gcamdataFolder, "/R/zchunk_Xbatch_industry_xml_Subregions_", region, ".R"))
      }

      if(file.exists(paste0(gcamdataFolder, "/R/zchunk_X232.industry_Subregions_", region, ".R"))){
        rlang::inform(paste0("R file: ", paste0(gcamdataFolder, "/R/zchunk_X232.industry_Subregions_", region, ".R"),
                     " already exists and will be overwritten."))
        unlink(paste0(gcamdataFolder, "/R/zchunk_X232.industry_Subregions_", region, ".R"))
      }

      # Check to make sure liquid limits files don't already exist
      if(file.exists(paste0(gcamdataFolder, "/R/zchunk_Xbatch_liquids_limits_xml_Subregions_", region, ".R"))){
        rlang::inform(paste0("R file: ", paste0(gcamdataFolder, "/R/zchunk_Xbatch_liquids_limits_xml_Subregions_", region, ".R"),
                     " already exists and will be overwritten."))
        unlink(paste0(gcamdataFolder, "/R/zchunk_Xbatch_liquids_limits_xml_Subregions_", region, ".R"))
      }

    }


    # Add comments to files
    if(T){
    # Add comments to pop files
    filename = paste0(breakoutFolder, "/Subregions_", region, "_pop.csv")
    con <- file(filename, open = "wt")
    comments <- data.frame(Comments=
      c(paste0("# File: Subregions_", region, "_pop.csv"),
        paste0("# Title: Subregions and rest-of-", region," population (all years)"),
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
    filename = paste0(breakoutFolder, "/Subregions_", region, "_pcgdp.csv")
    con <- file(filename, open = "wt")
    comments <- data.frame(Comments=
                             c(paste0("# File: Subregions_", region, "_pcgdp.csv"),
                               paste0("# Title: Subregions and rest-of-", region," pcgdp"),
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

    # Modify the template R files and replace with new subregions and corresponding region name
    if(T){
    # Modify Socioeconomic R Files
    zchunk_X201 <- stringr::str_replace_all(gcambreakout::template_zchunk_X201.socioeconomic_APPEND, "APPEND", paste0("Subregions_", region))
    zchunk_Xbatch <- stringr::str_replace_all(gcambreakout::template_zchunk_Xbatch_socioeconomics_xml_APPEND, "APPEND", paste0("Subregions_", region))

    # Modify Buildings R Files
    zchunk_X244_build <- stringr::str_replace_all(gcambreakout::template_zchunk_X244.building_APPEND, c("APPEND_REGION" = region, "APPEND"= paste0("Subregions_", region)))
    zchunk_Xbatch_build <- stringr::str_replace_all(gcambreakout::template_zchunk_Xbatch_building_xml_APPEND, c("APPEND_REGION" = region, "APPEND"= paste0("Subregions_", region)))

    # Modify Industry R Files
    zchunk_X232_ind <- stringr::str_replace_all(gcambreakout::template_zchunk_X232.industry_APPEND, c("APPEND_REGION" = region, "APPEND"= paste0("Subregions_", region)))
    zchunk_Xbatch_ind <- stringr::str_replace_all(gcambreakout::template_zchunk_Xbatch_industry_xml_APPEND, c("APPEND_REGION" = region, "APPEND"= paste0("Subregions_", region)))

    # Modify Transport R Files
    zchunk_X254_trn <- stringr::str_replace_all(gcambreakout::template_zchunk_X254.transportation_APPEND, c("APPEND_REGION" = region, "APPEND"= paste0("Subregions_", region)))
    zchunk_Xbatch_trn <- stringr::str_replace_all(gcambreakout::template_zchunk_Xbatch_transportation_xml_APPEND, c("APPEND_REGION" = region, "APPEND"= paste0("Subregions_", region)))

    # Modify Liquid Limits R Files
    zchunk_Xbatch_liquid_limits <- stringr::str_replace_all(gcambreakout::template_zchunk_Xbatch_liquids_limits_xml_APPEND, c("APPEND_REGION" = region, "APPEND"= paste0("Subregions_", region)))

    ##### Write modified R files into the R folder

    # Write out Breakout helper functions
    readr::write_lines(gcambreakout::template_breakout_helpers,paste0(gcamdataFolder, "/R/breakout_helpers.R"))
    rlang::inform(paste0("Added new file: ", gcamdataFolder, "/R/breakout_helpers.R"))

    # Write out Socioeconomics Files
    readr::write_lines(zchunk_X201,paste0(gcamdataFolder, "/R/zchunk_X201.socioeconomic_Subregions_", region, ".R"))
    rlang::inform(paste0("Added new file: ", gcamdataFolder, "/R/zchunk_X201.socioeconomic_Subregions_", region, ".R"))

    readr::write_lines(zchunk_Xbatch,paste0(gcamdataFolder, "/R/zchunk_Xbatch_socioeconomics_xml_Subregions_", region, ".R"))
    rlang::inform(paste0("Added new file: ", gcamdataFolder, "/R/zchunk_Xbatch_socioeconomics_xml_Subregions_", region, ".R"))

    # Write out Buildings Files
    readr::write_lines(zchunk_X244_build, paste0(gcamdataFolder, "/R/zchunk_X244.building_Subregions_", region, ".R"))
    rlang::inform(paste0("Added new file: ", gcamdataFolder, "/R/zchunk_X244.building_Subregions_", region, ".R"))

    readr::write_lines(zchunk_Xbatch_build, paste0(gcamdataFolder, "/R/zchunk_Xbatch_building_xml_Subregions_", region, ".R"))
    rlang::inform(paste0("Added new file: ", gcamdataFolder, "/R/zchunk_Xbatch_building_xml_Subregions_", region, ".R"))

    # Write out Industry Files
    readr::write_lines(zchunk_X232_ind, paste0(gcamdataFolder, "/R/zchunk_X232.industry_Subregions_", region, ".R"))
    rlang::inform(paste0("Added new file: ", gcamdataFolder, "/R/zchunk_X232.industry_Subregions_", region, ".R"))

    readr::write_lines(zchunk_Xbatch_ind, paste0(gcamdataFolder, "/R/zchunk_Xbatch_industry_xml_Subregions_", region, ".R"))
    rlang::inform(paste0("Added new file: ", gcamdataFolder, "/R/zchunk_Xbatch_industry_xml_Subregions_", region, ".R"))

    # Write out Transport Files
    readr::write_lines(zchunk_X254_trn, paste0(gcamdataFolder, "/R/zchunk_X254.transportation_Subregions_", region, ".R"))
    rlang::inform(paste0("Added new file: ", gcamdataFolder, "/R/zchunk_X254.transportation_Subregions_", region, ".R"))

    readr::write_lines(zchunk_Xbatch_trn, paste0(gcamdataFolder, "/R/zchunk_Xbatch_transportation_xml_Subregions_", region, ".R"))
    rlang::inform(paste0("Added new file: ", gcamdataFolder, "/R/zchunk_Xbatch_transportation_xml_Subregions_", region, ".R"))

    # Write out Buildings Files
    readr::write_lines(zchunk_Xbatch_liquid_limits, paste0(gcamdataFolder, "/R/zchunk_Xbatch_liquids_limits_xml_Subregions_", region, ".R"))
    rlang::inform(paste0("Added new file: ", gcamdataFolder, "/R/zchunk_Xbatch_liquids_limits_xml_Subregions_", region, ".R"))
    }
  }


  #..............
  # Close out
  #.............

  if(T){
  rlang::inform(paste0("Subregions ", paste0(subregions, collapse=", ")," sucessfully broken out from region: ", region, "."))
  rlang::inform(paste0("Please re-install gcamdata and re-run driver from your folder: ",gcamdataFolder))
  rlang::inform(paste0("After running driver() please add the following xml to your configuration files:"))
  rlang::inform(paste0("socioeconomics_Subregions_", region, ".xml"))
  rlang::inform(paste0("buidling_Subregions_", region, ".xml"))
  rlang::inform(paste0("industry_Subregions_", region, ".xml"))
  rlang::inform(paste0("transportation_Subregions_", region, ".xml"))
  rlang::inform(paste0("liquid_limits_Subregions_", region, ".xml"))
  rlang::inform(paste0("Note: If during gcamdatabuild error: 'Error: .../input/gcamdata/man/GCAM_DATA_MAP.Rd:17: Bad /link text'",
               ", delete './input/gcamdata/man/GCAM_DATA_MAP.Rd' and then run devtools::install() in gcamdata.",
               " (Do not rebuild documentation after deleting GCAM_DATA_MAP.Rd."))
  rlang::inform("breakout_subregion complete.")
  }




}

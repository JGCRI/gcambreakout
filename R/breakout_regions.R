# breakout_regions.R
#' Function to breakout region in gcamdata
#' @param gcamdataFolder Default = NULL. Full path to gcamdata folder.
#' @param regionsNew Default = NULL. Name of New Region or regions to breakout.
#' Can be a vector or list. (e.g. regionsNew = "New Region" OR regionsNew = c("New Region 1","New Region 2"))
#' @param countriesNew Default = NULL. Name of countries in new region.
#' A vector if only one region or a list with countries for each regionsNew.
#' (e.g. c("New Region Country 1, "New Region Country 2) corresponding to a single regionsNew = "New Region" OR
#'  countriesNew = list(c("New Region 1 Country 1", "New Region 1 Country 2"), c("New Region 2 Country 1", "New Region 2 Country 2"))
#'  corresponding to regionsNew = c("New Region 1", "New Region 2")))
#' @param gcam_version Default = 6.0. Which version of GCAM are the changes being applied to. Default may work on multiple
#' @importFrom magrittr %>%
#' @importFrom data.table :=
#' @export
#'

breakout_regions <- function(gcamdataFolder = NULL,
                     regionsNew = NULL,
                     countriesNew = NULL,
                     gcam_version = "6.0") {

  # gcamdataFolder = NULL
  # regionsNew = NULL
  # countriesNew = NULL
  # gcam_version = "6.0"

  #..................
  # Initialize variables
  # .................

  if(T){
  rlang::inform("Starting breakout ...")
  rlang::inform(paste0("Running gcambreakout for GCAM version: ", gcam_version))
  rlang::inform(paste0("Version of GCAM can be set using the argument `gcam_version`."))

  NULL -> Col1-> country_name -> GCAM_region_ID -> region ->iso->IEA_memo_ctry ->
    file_A326.inc_elas_parameter -> file_A323.inc_elas_parameter->file_A62.calibration
  parent_region_ID <- c()
  parent_region <- c()
  IEA_memo_ctry_df <- data.frame()
  closeAllConnections()

  # Declare File Names
  # Files need to be updated, regardless of version
  file_iso_GCAM_regID = paste(gcamdataFolder,"/inst/extdata/common/iso_GCAM_regID.csv",sep = "")
  file_GCAM_region_names = paste(gcamdataFolder,"/inst/extdata/common/GCAM_region_names.csv",sep = "")
  file_A_bio_frac_prod_R = paste(gcamdataFolder,"/inst/extdata/aglu/A_bio_frac_prod_R.csv",sep = "")
  file_A_soil_time_scale_R = paste(gcamdataFolder,"/inst/extdata/aglu/A_soil_time_scale_R.csv",sep = "")
  file_emissions_A_regions = paste(gcamdataFolder,"/inst/extdata/emissions/A_regions.csv",sep = "")
  file_A23.subsector_interp_R = paste(gcamdataFolder,"/inst/extdata/energy/A23.subsector_interp_R.csv",sep = "")
  file_energy_A_regions = paste(gcamdataFolder,"/inst/extdata/energy/A_regions.csv",sep = "")
  file_offshore_wind_potential_scaler = paste(gcamdataFolder,"/inst/extdata/energy/offshore_wind_potential_scaler.csv",sep = "")
  file_EPA_country_map = paste(gcamdataFolder,"/inst/extdata/emissions/EPA_country_map.csv",sep = "")


  file_list <- list(file_iso_GCAM_regID, file_GCAM_region_names, file_A_bio_frac_prod_R,
                    file_A_soil_time_scale_R, file_A_soil_time_scale_R, file_emissions_A_regions,
                    file_A23.subsector_interp_R, file_energy_A_regions, file_offshore_wind_potential_scaler,
                    file_EPA_country_map)

  if(!any(gcam_version %in% c("6.0","5.4"))){
    rlang::warn(paste0("gcam_version picked: ", gcam_version, "is not available in this version of gcambreakout."))
    rlang::warn(paste0("Please pick from the following versions: '5.4', '6.0'"))
    rlang::warn(paste0("Setting to: '6.0'"))
  }

  if(gcam_version == '6.0'){
    # Files need to be updated in GCAM 6.0
    file_A323.inc_elas_parameter = paste(gcamdataFolder,"/inst/extdata/socioeconomics/A323.inc_elas_parameter.csv",sep = "")
    file_A326.inc_elas_parameter = paste(gcamdataFolder,"/inst/extdata/socioeconomics/A326.inc_elas_parameter.csv",sep = "")
    file_A62.calibration = paste(gcamdataFolder, "/inst/extdata/energy/A62.calibration.csv",sep = "")

    GCAM6_file_list <- list(file_A323.inc_elas_parameter, file_A326.inc_elas_parameter, file_A62.calibration)
    file_list <- append(file_list, GCAM6_file_list)
  }

  }

  #..................
  # Check Inputs
  # .................

  if(T){
  rlang::inform("Checking inputs ...")

  # gcamdatafolder
  if (is.null(gcamdataFolder)) {
    stop("Please provide a gcamdataFolder path.")
  } else{
    if (!dir.exists(gcamdataFolder)) {
      stop("The gcamdataFolder path given does not exist.")
    }
  }

  # Check that all the input files to be modified exist
 for(i in 1:length(file_list)){
  if (!file.exists(file_list[[i]])) {
    rlang::inform(paste("File ", file_list[[i]], " does not exist. Breakout may not work correctly.", sep = ""))
    rlang::inform(paste0("This could also be a file not available in the current version of GCAM being used."))
  }}

  # Check that regionsNew and countriesNew have the correct length
  if(!is.null(regionsNew) & !is.null(countriesNew)){
    if(length(regionsNew) > 1){
      if(length(regionsNew) != length(countriesNew)){
        rlang::inform("regionsNew and countriesNew must have the same length.")
        rlang::inform("For example for a single regionsNew:")
        rlang::inform("regionsNew = 'New Region' & countriesNew = c('New Region Country 1', New Region country 2')")
        rlang::inform("For multiple regions with different countries:")
        rlang::inform("regionsNew = c('New Region 1', 'New Region 2') &
              countriesNew = list(c('New Region 1 Country 1', 'New Region 1 Country 2'), c('New Region 2 Country 1', 'New Region 2 Country 2'))")
        stop("regionsNew and countriesNew must have the same length.")
      }
    } else {
      countriesNew = list(countriesNew)
    }
  } else {
    stop("Must provide both regionsNew and countriesNew")
  }

    # Check that regionsNew are not duplicated
    if(is.list(regionsNew)){
      regionsNew_duplicate_check <- unlist(regionsNew)
    } else {
      regionsNew_duplicate_check <- regionsNew
    }
    if(any(duplicated(regionsNew_duplicate_check))){
      rlang::inform(paste0("regionsNew provided: ", paste(regionsNew,collapse=", "), "has duplicate entries."))
      stop("regionsNew must all be unique.")
    }

    # Check that countries are not duplicated
      if(is.list(countriesNew)){
        countriesNew_duplicate_check <- unlist(countriesNew)
      } else {
        countriesNew_duplicate_check <- countriesNew
      }
      if(any(duplicated(countriesNew_duplicate_check))){
        rlang::inform(paste0("countriesNew provided: ", paste(countriesNew,collapse=", "), "has duplicate entries."))
        stop("countriesNew must all be unique.")
      }

  rlang::inform("Input checks complete ...")
  }


  #..................
  # Read in files to modify & modify them
  # .................

  # For each regionsNew and each countriesNew
  for(loop_regions_countries in 1:length(regionsNew)){

    regionsNew_i = regionsNew[loop_regions_countries]
    countriesNew_i = countriesNew[loop_regions_countries]

    # Convert countriesNew_i to vector if list
    if(is.list(countriesNew_i)){
      countriesNew_i <- unlist(countriesNew_i)
    }

    rlang::inform("----------------------------------------------------")
    rlang::inform(paste0("Starting to modify files for new region: ", regionsNew_i,
                 " with new countries: ", paste(countriesNew_i, collapse=", ")))
    rlang::inform("----------------------------------------------------")


  #..................
  # Read in files to modify
  # .................

  if(T){
  rlang::inform("Reading in files to modify ...")

  iso_GCAM_regID = utils::read.csv(file_iso_GCAM_regID, sep = ",",comment.char="#") %>% tibble::as_tibble(); iso_GCAM_regID

  if(file.exists(file_iso_GCAM_regID)){
  iso_GCAM_regID_comments <- ((utils::read.csv(file_iso_GCAM_regID, header = F))[,1])%>%
    as.data.frame();
    names(iso_GCAM_regID_comments)<-"Col1"
  iso_GCAM_regID_comments <- iso_GCAM_regID_comments %>%
    dplyr::filter(grepl("#",Col1)); iso_GCAM_regID_comments
  }

  if(file.exists(file_GCAM_region_names)){
  GCAM_region_names = utils::read.csv(file_GCAM_region_names, sep = ",",comment.char="#") %>% tibble::as_tibble(); GCAM_region_names
  GCAM_region_names_comments <- ((utils::read.csv(file_GCAM_region_names, header = F))[,1])%>%
    as.data.frame();
  names(GCAM_region_names_comments)<-"Col1"
  GCAM_region_names_comments <- GCAM_region_names_comments %>%
    dplyr::filter(grepl("#",Col1)); GCAM_region_names_comments
  }

  if(file.exists(file_A_bio_frac_prod_R)){
  A_bio_frac_prod_R = utils::read.csv(file_A_bio_frac_prod_R, sep = ",",comment.char="#") %>% tibble::as_tibble(); A_bio_frac_prod_R
  A_bio_frac_prod_R_comments <- ((utils::read.csv(file_A_bio_frac_prod_R, header = F))[,1])%>%
    as.data.frame();
  names(A_bio_frac_prod_R_comments)<-"Col1"
  A_bio_frac_prod_R_comments <- A_bio_frac_prod_R_comments %>%
    dplyr::filter(grepl("#",Col1)); A_bio_frac_prod_R_comments
  }

  if(file.exists(file_A_soil_time_scale_R)){
  A_soil_time_scale_R = utils::read.csv(file_A_soil_time_scale_R, sep = ",",comment.char="#") %>% tibble::as_tibble(); A_soil_time_scale_R
  A_soil_time_scale_R_comments <- ((utils::read.csv(file_A_soil_time_scale_R, header = F))[,1])%>%
    as.data.frame();
  names(A_soil_time_scale_R_comments)<-"Col1"
  A_soil_time_scale_R_comments <- A_soil_time_scale_R_comments %>%
    dplyr::filter(grepl("#",Col1)); A_soil_time_scale_R_comments
  }

  if(file.exists(file_emissions_A_regions)){
  emissions_A_regions = utils::read.csv(file_emissions_A_regions, sep = ",",comment.char="#") %>% tibble::as_tibble(); emissions_A_regions
  emissions_A_regions_comments <- ((utils::read.csv(file_emissions_A_regions, header = F))[,1])%>%
    as.data.frame();
  names(emissions_A_regions_comments)<-"Col1"
  emissions_A_regions_comments <- emissions_A_regions_comments %>%
    dplyr::filter(grepl("#",Col1)); emissions_A_regions_comments
  }

  if(file.exists(file_A23.subsector_interp_R)){
  A23.subsector_interp_R = utils::read.csv(file_A23.subsector_interp_R, sep = ",",comment.char="#") %>% tibble::as_tibble(); A23.subsector_interp_R
  A23.subsector_interp_R_comments <- ((utils::read.csv(file_A23.subsector_interp_R, header = F))[,1])%>%
    as.data.frame();
  names(A23.subsector_interp_R_comments)<-"Col1"
  A23.subsector_interp_R_comments <- A23.subsector_interp_R_comments %>%
    dplyr::filter(grepl("#",Col1)); A23.subsector_interp_R_comments
  }

  if(file.exists(file_energy_A_regions)){
  energy_A_regions = utils::read.csv(file_energy_A_regions, sep = ",",comment.char="#") %>% tibble::as_tibble(); energy_A_regions
  energy_A_regions_comments <- ((utils::read.csv(file_energy_A_regions, header = F))[,1])%>%
    as.data.frame();
  names(energy_A_regions_comments)<-"Col1"
  energy_A_regions_comments <- energy_A_regions_comments %>%
    dplyr::filter(grepl("#",Col1)); energy_A_regions_comments
  }

  if(file.exists(file_offshore_wind_potential_scaler)){
  offshore_wind_potential_scaler = utils::read.csv(file_offshore_wind_potential_scaler, sep = ",",comment.char="#") %>% tibble::as_tibble(); offshore_wind_potential_scaler
  offshore_wind_potential_scaler_comments <-  ((utils::read.csv(file_offshore_wind_potential_scaler, header = F))[,1])%>%
    as.data.frame();
  names(offshore_wind_potential_scaler_comments)<-"Col1"
  offshore_wind_potential_scaler_comments <- offshore_wind_potential_scaler_comments %>%
    dplyr::filter(grepl("#",Col1)); offshore_wind_potential_scaler_comments
  }

  if(file.exists(file_EPA_country_map)){
  EPA_country_map = utils::read.csv(file_EPA_country_map, sep = ",",comment.char="#") %>% tibble::as_tibble(); EPA_country_map
  EPA_country_map_comments <- ((utils::read.csv(file_EPA_country_map, header = F))[,1])%>%
    as.data.frame();
  names(EPA_country_map_comments)<-"Col1"
  EPA_country_map_comments <- EPA_country_map_comments %>%
    dplyr::filter(grepl("#",Col1)); EPA_country_map_comments
  }

  if(!is.null(file_A323.inc_elas_parameter)){
    if(file.exists(file_A323.inc_elas_parameter)){
      A323.inc_elas_parameter = utils::read.csv(file_A323.inc_elas_parameter, sep = ",",comment.char="#") %>% tibble::as_tibble(); A323.inc_elas_parameter
      A323.inc_elas_parameter_comments <- ((utils::read.csv(file_A323.inc_elas_parameter, header = F))[,1])%>%
        as.data.frame();
      names(A323.inc_elas_parameter_comments)<-"Col1"
      A323.inc_elas_parameter_comments <- A323.inc_elas_parameter_comments %>%
        dplyr::filter(grepl("#",Col1)); A323.inc_elas_parameter_comments
    }
  }

  if(!is.null(file_A326.inc_elas_parameter)){
    if(file.exists(file_A326.inc_elas_parameter)){
      A326.inc_elas_parameter = utils::read.csv(file_A326.inc_elas_parameter, sep = ",",comment.char="#") %>% tibble::as_tibble(); A326.inc_elas_parameter
      A326.inc_elas_parameter_comments <- ((utils::read.csv(file_A326.inc_elas_parameter, header = F))[,1])%>%
        as.data.frame();
      names(A326.inc_elas_parameter_comments)<-"Col1"
      A326.inc_elas_parameter_comments <- A326.inc_elas_parameter_comments %>%
        dplyr::filter(grepl("#",Col1)); A326.inc_elas_parameter_comments
    }
  }

  if(!is.null(file_A62.calibration)){
    if(file.exists(file_A62.calibration)){
      A62.calibration = utils::read.csv(file_A62.calibration, sep = ",",comment.char="#") %>% tibble::as_tibble(); A326.inc_elas_parameter
      A62.calibration_comments <- ((utils::read.csv(file_A62.calibration, header = F))[,1])%>%
        as.data.frame();
      names(A62.calibration_comments)<-"Col1"
      A62.calibration_comments <- A62.calibration_comments %>%
        dplyr::filter(grepl("#",Col1)); A62.calibration_comments
    }
  }

  rlang::inform("All files read.")
  }

  #..................
  # Modify files
  # .................

  if(T){

      #..................
      # Check regionsNew and original ID's
      # .................

      if (!is.null(regionsNew_i)){
        if(!is.null(countriesNew_i)){

          if (!all(tolower(countriesNew_i) %in% tolower(unique(iso_GCAM_regID$country_name)))){
            stop(paste("Not all countriesNew_i chosen: ", paste(countriesNew_i,collapse=", "),
                       " exist in iso_GCAM_regID country_name.", sep=""))
          }
          if (tolower(regionsNew_i) %in% tolower(unique(GCAM_region_names$region))){
            stop(paste("regionsNew_i chosen: ", regionsNew_i,
                       " already exists as a separate GCAM region.", sep=""))
          }

          # Reformat country names and get parent region IDs
          for (i in 1:length(countriesNew_i)){
            iso_GCAM_regID_countries <- as.vector(unique(iso_GCAM_regID$country_name))
            countriesNew_i[i] <- iso_GCAM_regID_countries[
              tolower(iso_GCAM_regID_countries) == tolower(countriesNew_i[i])]

            parent_region_ID[i] <- ((iso_GCAM_regID %>%
                                       dplyr::filter(
                                         tolower(country_name) == tolower(countriesNew_i[i])
                                       ))$GCAM_region_ID) %>%
              unique() %>%
              as.integer()

            parent_region[i] <- ((GCAM_region_names %>%
                                    dplyr::filter(
                                      GCAM_region_ID ==  parent_region_ID[i]))$region) %>%
              unique() %>%
              as.character()
          } # Close loop across countriesNew_i

          countriesNew_i
          parent_region_ID
          parent_region

          if(length(regionsNew_i)==0){stop("regionsNew_i not assigned correctly.")}
          if(length(unique(parent_region_ID))!=1){
            rlang::inform(paste("Unique parent_region_ID: ", paste(unique(parent_region_ID),collapse=", "),sep=""))
            stop("For now all new countries being broken out must come from same parent region.")
          }

        }else{stop("Must enter countriesNew_i to specify which country or countries to include in new region.")}
      } else {stop("Must enter a regionsNew_i to assign a name for the new region.")}

      #..................
      # Modify extdata/common/iso_GCAM_regID.csv
      # .................

      if(file.exists(file_iso_GCAM_regID)){

        new_region_ID <- as.integer(max(iso_GCAM_regID$GCAM_region_ID) + 1)
        new_region_ID <- as.integer(new_region_ID)

        iso_GCAM_regID_new <- iso_GCAM_regID %>%
          dplyr::mutate(GCAM_region_ID = as.integer(GCAM_region_ID))

        for ( i in 1:length(countriesNew_i)){
          iso_GCAM_regID_new <- iso_GCAM_regID_new %>%
            dplyr::mutate(GCAM_region_ID =
                            dplyr::case_when(
                              tolower(countriesNew_i[i]) == tolower(country_name) ~ new_region_ID,
                              TRUE ~ GCAM_region_ID
                            ))
        }
        iso_GCAM_regID_new

        filename <-file_iso_GCAM_regID

        file.copy(filename, gsub(".csv","_Original.csv",filename))
        unlink(filename)

        con <- file(filename, open = "wt")
        for (i in 1:nrow(iso_GCAM_regID_comments)) {
          writeLines(paste(iso_GCAM_regID_comments[i, ]), con)
        }
        utils::write.csv(iso_GCAM_regID_new, con, row.names = F)
        close(con)
        closeAllConnections()

        rlang::inform(paste("Added region: '", regionsNew_i,
                    "' and GCAM_region_ID: ", new_region_ID,
                    " for selected countries ", paste(countriesNew_i,collapse = ", "),
                    " to ", filename, sep=""))
      }

      #..................
      # Modify extdata/common/GCAM_region_names.csv
      # .................

      if(file.exists(file_GCAM_region_names)){

        filename <- file_GCAM_region_names

        GCAM_region_names_new <- GCAM_region_names %>%
          dplyr::bind_rows(GCAM_region_names[1,] %>%
                             dplyr::mutate(GCAM_region_ID = new_region_ID,
                                           region = regionsNew_i));
        #GCAM_region_names_new %>% as.data.frame()

        file.copy(filename, gsub(".csv","_Original.csv",filename))
        unlink(filename)

        con <- file(filename, open = "wt")
        for (i in 1:nrow(GCAM_region_names_comments)) {
          writeLines(paste(GCAM_region_names_comments[i, ]), con)
        }
        utils::write.csv(GCAM_region_names_new, con, row.names = F)
        close(con)
        closeAllConnections()

        rlang::inform(paste("Added region: ", regionsNew_i,
                    " and GCAM_region_ID: ", new_region_ID,
                    " to ", filename, sep=""))
      }

      #..................
      # Modify extdata/aglu/A_bio_frac_prod_R.csv
      # .................

      if(file.exists(file_A_bio_frac_prod_R)){

        filename <-file_A_bio_frac_prod_R

        # Assign the value from the parent region to the new country
        A_bio_frac_prod_R_new <- A_bio_frac_prod_R %>%
          dplyr::bind_rows(A_bio_frac_prod_R %>%
                             dplyr::filter(GCAM_region_ID == parent_region_ID) %>%
                             dplyr::mutate(GCAM_region_ID = new_region_ID));
        #A_bio_frac_prod_R_new %>% as.data.frame()

        file.copy(filename, gsub(".csv","_Original.csv",filename))
        unlink(filename)

        con <- file(filename, open = "wt")
        for (i in 1:nrow(A_bio_frac_prod_R_comments)) {
          writeLines(paste(A_bio_frac_prod_R_comments[i, ]), con)
        }
        utils::write.csv(A_bio_frac_prod_R_new, con, row.names = F)
        close(con)
        closeAllConnections()

        rlang::inform(paste("Added data for new region: ", regionsNew_i,
                    " with GCAM_region_ID: ", new_region_ID,
                    " based on data from parent region: ", unique(parent_region),
                    " with GCAM_region_ID: ", unique(parent_region_ID),
                    " to ", filename, sep=""))
      }

      #..................
      # Modify extdata/aglu/A_soil_time_scale_R.csv
      # .................

      if(file.exists(file_A_soil_time_scale_R)){

        filename <- file_A_soil_time_scale_R
        # Assign the value from the parent region to the new country
        A_soil_time_scale_R_new <- A_soil_time_scale_R %>%
          dplyr::bind_rows(A_soil_time_scale_R %>%
                             dplyr::filter(GCAM_region_ID == parent_region_ID) %>%
                             dplyr::mutate(GCAM_region_ID = new_region_ID));
        #A_soil_time_scale_R_new %>% as.data.frame()

        file.copy(filename, gsub(".csv","_Original.csv",filename))
        unlink(filename)

        con <- file(filename, open = "wt")
        for (i in 1:nrow(A_soil_time_scale_R_comments)) {
          writeLines(paste(A_soil_time_scale_R_comments[i, ]), con)
        }
        utils::write.csv(A_soil_time_scale_R_new, con, row.names = F)
        close(con)
        closeAllConnections()

        rlang::inform(paste("Added data for new region: ", regionsNew_i,
                    " with GCAM_region_ID: ", new_region_ID,
                    " based on data from parent region: ", unique(parent_region),
                    " with GCAM_region_ID: ", unique(parent_region_ID),
                    " to ", filename, sep=""))
      }

      #..................
      # Modify extdata/emissions/A_regions.csv
      # .................

      if(file.exists(file_emissions_A_regions)){

        filename <- file_emissions_A_regions
        # Assign the value from the parent region to the new country
        emissions_A_regions_new <- emissions_A_regions %>%
          dplyr::bind_rows(emissions_A_regions %>%
                             dplyr::filter(GCAM_region_ID == unique(parent_region_ID)) %>%
                             dplyr::mutate(GCAM_region_ID = new_region_ID,
                                           region = regionsNew_i));
        #emissions_A_regions_new %>% as.data.frame()

        file.copy(filename, gsub(".csv","_Original.csv",filename))
        unlink(filename)

        con <- file(filename, open = "wt")
        for (i in 1:nrow(emissions_A_regions_comments)) {
          writeLines(paste(emissions_A_regions_comments[i, ]), con)
        }
        utils::write.csv(emissions_A_regions_new, con, row.names = F)
        close(con)
        closeAllConnections()

        rlang::inform(paste("Added data for new region: ", regionsNew_i,
                    " with GCAM_region_ID: ", new_region_ID,
                    " based on data from parent region: ", unique(parent_region),
                    " with GCAM_region_ID: ", unique(parent_region_ID),
                    " to ", filename, sep=""))
      }


      #..................
      # Modify extdata/energy/A23.subsector_interp_R.csv
      # .................

      if(file.exists(file_A23.subsector_interp_R)){

        filename <- file_A23.subsector_interp_R
        # Assign the value from the parent region to the new country
        A23.subsector_interp_R_new <- A23.subsector_interp_R %>%
          dplyr::bind_rows(A23.subsector_interp_R %>%
                             dplyr::filter(region == unique(parent_region)) %>%
                             dplyr::mutate(region = regionsNew_i));
        #A23.subsector_interp_R_new %>% as.data.frame()

        file.copy(filename, gsub(".csv","_Original.csv",filename))
        unlink(filename)

        con <- file(filename, open = "wt")
        for (i in 1:nrow(A23.subsector_interp_R_comments)) {
          writeLines(paste(A23.subsector_interp_R_comments[i, ]), con)
        }
        utils::write.csv(A23.subsector_interp_R_new, con, row.names = F)
        close(con)
        closeAllConnections()

        rlang::inform(paste("Added data for new region: ", regionsNew_i,
                    " with GCAM_region_ID: ", new_region_ID,
                    " based on data from parent region: ", unique(parent_region),
                    " with GCAM_region_ID: ", unique(parent_region_ID),
                    " to ", filename, sep=""))
      }

      #..................
      # Modify extdata/energy/A_regions.csv
      # .................

      if(file.exists(file_energy_A_regions)){

        filename <- file_energy_A_regions
        # Assign the value from the parent region to the new country
        energy_A_regions <- energy_A_regions %>%
          dplyr::bind_rows(energy_A_regions %>%
                             dplyr::filter(GCAM_region_ID == unique(parent_region_ID)) %>%
                             dplyr::mutate(region = regionsNew_i,
                                           GCAM_region_ID = new_region_ID));
        #energy_A_regions %>% as.data.frame()

        file.copy(filename, gsub(".csv","_Original.csv",filename))
        unlink(filename)

        con <- file(filename, open = "wt")
        for (i in 1:nrow(energy_A_regions_comments)) {
          writeLines(paste(energy_A_regions_comments[i, ]), con)
        }
        utils::write.csv(energy_A_regions, con, row.names = F)
        close(con)
        closeAllConnections()

        rlang::inform(paste("Added data for new region: ", regionsNew_i,
                    " with GCAM_region_ID: ", new_region_ID,
                    " based on data from parent region: ", unique(parent_region),
                    " with GCAM_region_ID: ", unique(parent_region_ID),
                    " to ", filename, sep=""))
      }


      #..................
      # Modify extdata/energy/offshore_wind_potential_scaler.csv
      # .................

      if(file.exists(file_offshore_wind_potential_scaler)){

        filename <- file_offshore_wind_potential_scaler
        # Assign the value from the parent region to the new country
        offshore_wind_potential_scaler <- offshore_wind_potential_scaler %>%
          dplyr::bind_rows(offshore_wind_potential_scaler %>%
                             dplyr::filter(GCAM_region_ID == unique(parent_region_ID)) %>%
                             dplyr::mutate(GCAM_region_ID = new_region_ID));
        #offshore_wind_potential_scaler %>% as.data.frame()

        file.copy(filename, gsub(".csv","_Original.csv",filename))
        unlink(filename)

        con <- file(filename, open = "wt")
        for (i in 1:nrow(offshore_wind_potential_scaler_comments)) {
          writeLines(paste(offshore_wind_potential_scaler_comments[i, ]), con)
        }
        utils::write.csv(offshore_wind_potential_scaler, con, row.names = F)
        close(con)
        closeAllConnections()

        rlang::inform(paste("Added data for new region: ", regionsNew_i,
                    " with GCAM_region_ID: ", new_region_ID,
                    " based on data from parent region: ", unique(parent_region),
                    " with GCAM_region_ID: ", unique(parent_region_ID),
                    " to ", filename, sep=""))
      }


      #..................
      # Modify extdata/emissions/EPA_country_map.csv
      # .................

      if(file.exists(file_EPA_country_map)){

        EPA_country_map_new <- EPA_country_map %>%
          dplyr::mutate(GCAM_region_ID = as.integer(GCAM_region_ID))

        for ( i in 1:length(countriesNew_i)){

          isoOriginal_i = (iso_GCAM_regID %>%
            dplyr::filter(country_name == countriesNew_i[i]))$iso

          EPA_country_map_new <- EPA_country_map_new %>%
            dplyr::mutate(GCAM_region_ID =
                            dplyr::case_when(
                              tolower(isoOriginal_i) == tolower(iso) ~ new_region_ID,
                              TRUE ~ GCAM_region_ID
                            ))
        }
        EPA_country_map_new

        filename <-file_EPA_country_map

        file.copy(filename, gsub(".csv","_Original.csv",filename))
        unlink(filename)

        con <- file(filename, open = "wt")
        for (i in 1:nrow(EPA_country_map_comments)) {
          writeLines(paste(EPA_country_map_comments[i, ]), con)
        }
        utils::write.csv(EPA_country_map_new, con, row.names = F)
        close(con)
        closeAllConnections()

        rlang::inform(paste("Added region: '", regionsNew_i,
                    "' and GCAM_region_ID: ", new_region_ID,
                    " for selected countries ", paste(countriesNew_i,collapse = ", "),
                    " to ", filename, sep=""))
      }

    #..................
    # Modify extdata/socioeconomics/A323.inc_elas_parameter.csv
    # .................

    if(!is.null(file_A323.inc_elas_parameter)){
      if(file.exists(file_A323.inc_elas_parameter)){

        filename <- file_A323.inc_elas_parameter
        # Assign the value from the parent region to the new country
        A323.inc_elas_parameter_new <- A323.inc_elas_parameter %>%
          dplyr::bind_rows(A323.inc_elas_parameter %>%
                             dplyr::filter(region == unique(parent_region)) %>%
                             dplyr::mutate(region = regionsNew_i)) %>%
          unique();
        #A323.inc_elas_parameter_new %>% as.data.frame()

        file.copy(filename, gsub(".csv","_Original.csv",filename))
        unlink(filename)

        con <- file(filename, open = "wt")
        for (i in 1:nrow(A323.inc_elas_parameter_comments)) {
          writeLines(paste(A323.inc_elas_parameter_comments[i, ]), con)
        }
        utils::write.csv(A323.inc_elas_parameter_new, con, row.names = F)
        close(con)
        closeAllConnections()

        rlang::inform(paste("Added data for new region: ", regionsNew_i,
                    " with GCAM_region_ID: ", new_region_ID,
                    " based on data from parent region: ", unique(parent_region),
                    " with GCAM_region_ID: ", unique(parent_region_ID),
                    " to ", filename, sep=""))
      }
    }

    #..................
    # Modify extdata/socioeconomics/A326.inc_elas_parameter.csv
    # .................

    if(!is.null(file_A326.inc_elas_parameter)){
      if(file.exists(file_A326.inc_elas_parameter)){

        filename <- file_A326.inc_elas_parameter
        # Assign the value from the parent region to the new country
        A326.inc_elas_parameter_new <- A326.inc_elas_parameter %>%
          dplyr::bind_rows(A326.inc_elas_parameter %>%
                             dplyr::filter(region == unique(parent_region)) %>%
                             dplyr::mutate(region = regionsNew_i)) %>%
          unique();
        #A326.inc_elas_parameter_new %>% as.data.frame()

        file.copy(filename, gsub(".csv","_Original.csv",filename))
        unlink(filename)

        con <- file(filename, open = "wt")
        for (i in 1:nrow(A326.inc_elas_parameter_comments)) {
          writeLines(paste(A326.inc_elas_parameter_comments[i, ]), con)
        }
        utils::write.csv(A326.inc_elas_parameter_new, con, row.names = F)
        close(con)
        closeAllConnections()

        rlang::inform(paste("Added data for new region: ", regionsNew_i,
                    " with GCAM_region_ID: ", new_region_ID,
                    " based on data from parent region: ", unique(parent_region),
                    " with GCAM_region_ID: ", unique(parent_region_ID),
                    " to ", filename, sep=""))
      }
    }

    #..................
    # Modify extdata/energy/A62.calibration.csv
    # .................

    if(!is.null(file_A62.calibration)){
      if(file.exists(file_A62.calibration)){

        filename <- file_A62.calibration
        # Assign the value from the parent region to the new country
        A62.calibration_new <- A62.calibration %>%
          dplyr::bind_rows(A62.calibration %>%
                             dplyr::filter(GCAM_region_ID == unique(parent_region_ID)) %>%
                             dplyr::mutate(GCAM_region_ID = new_region_ID)) %>%
          unique();
        #A62.calibration_new %>% as.data.frame()

        file.copy(filename, gsub(".csv","_Original.csv",filename))
        unlink(filename)

        con <- file(filename, open = "wt")
        for (i in 1:nrow(A62.calibration_comments)) {
          writeLines(paste(A62.calibration_comments[i, ]), con)
        }
        utils::write.csv(A62.calibration_new, con, row.names = F)
        close(con)
        closeAllConnections()

        rlang::inform(paste("Added data for new region: ", regionsNew_i,
                            " with GCAM_region_ID: ", new_region_ID,
                            " based on data from parent region: ", unique(parent_region),
                            " with GCAM_region_ID: ", unique(parent_region_ID),
                            " to ", filename, sep=""))
      }
    }
  }


  } # Close loop for each regionsNew and each countriesNew

  #..................
  # Replace gcamdata modules for certain countries
  # Note: this may cause issues as the gcamdata package evolves.
  # To avoid these issues gcambreakout will need to be linked to versions of gcamdata
  # .................

  # Check which modules need to be replaced based on the mappings_module list and countriesNew chosen.
  modules_to_replace <- unique((gcambreakout::mapping_modules %>%
                           dplyr::filter(gcam_version %in% !!gcam_version))$module)

  for(module_i in modules_to_replace){

    rlang::inform(paste0("Replacing module: ", module_i,"..."))

    module_folder_i <- (gcambreakout::mapping_modules %>%
      dplyr::filter(module==module_i) %>%
        unique())$folder

    module_extension_i <- (gcambreakout::mapping_modules %>%
                          dplyr::filter(module==module_i) %>%
                          unique())$extension

    module_i_filename <- paste0(gcamdataFolder,"/",module_folder_i,"/",gsub("_breakout.*",module_extension_i,module_i))

    # Check if the modules exist in the gcamdata system
    if(file.exists(module_i_filename)){

      # Make a copy of the original module and put it in a folder called originals.
      if(!dir.exists(paste0(gcamdataFolder,"/",module_folder_i,"/originals"))){
        dir.create(paste0(gcamdataFolder,"/",module_folder_i,"/originals"))
      }

      file.copy(module_i_filename, gsub(paste0(module_folder_i,"/"),paste0(module_folder_i,"/originals/"),module_i_filename))
      unlink(module_i_filename)

      # Replace the original module with the modified modules
      replacement_module <- get(paste0("template_",gsub(paste0("\\",module_extension_i,"$"),"",module_i)))
      readr::write_lines(replacement_module,module_i_filename)
      rlang::inform(paste0("Replaced: ",module_i," with modified version."))
      rlang::inform(paste0("Original version of module is in: ", gsub(paste0(module_folder_i,"/"),
                                                                      paste0(module_folder_i,"/originals/"),
                                                                      module_i_filename)))


    } else {
      warning(paste0("Module: ", module_i, "is indicated as requiring replacement but does not exist in the version of gcamdata being used."))
    }

    } # Close module loop

  rlang::inform("Replacement of all modules complete.")



  #..............................
  #..............................

  closeAllConnections()
  rlang::inform(paste0("gcambreakout was run for GCAM version: ", gcam_version))
  rlang::inform(paste0("Version of GCAM can be set using the argument `gcam_version`."))
  rlang::inform("Finished running breakout.")
  rlang::inform(paste("Please re-build gcamdata and re-run driver() from your folder: ",gcamdataFolder,sep=""))
  rlang::inform(paste0("Please ensure correct version of GCAM is selected for your breakout. Current version: ", gcam_version))
}

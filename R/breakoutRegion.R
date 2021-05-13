# breakoutRegion.R
#' Function to breakout region in gcamdata
#' @param gcamdataFolder Default = NULL. Full path to gcamdata folder.
#' @param regionNew Default = NULL. Name of New Region to breakout.
#' @param countriesNew Default = NULL. Name of countries in new region.
#' @importFrom magrittr %>%
#' @importFrom data.table :=
#' @export
#'

breakoutRegion <- function(gcamdataFolder = NULL,
                     regionNew = NULL,
                     countriesNew = NULL) {

  # gcamdataFolder = NULL
  # regionNew = NULL
  # countriesNew = NULL

  #..................
  # Initialize variables
  # .................

  if(T){
  print("Starting breakout ...")

  NULL -> Col1-> country_name -> GCAM_region_ID -> region ->iso->IEA_memo_ctry
  parent_region_ID <- c()
  parent_region <- c()
  IEA_memo_ctry_df <- data.frame()
  closeAllConnections()

  # Declare File Names
  file_iso_GCAM_regID = paste(gcamdataFolder,"/inst/extdata/common/iso_GCAM_regID.csv",sep = "")
  file_GCAM_region_names = paste(gcamdataFolder,"/inst/extdata/common/GCAM_region_names.csv",sep = "")
  file_A_bio_frac_prod_R = paste(gcamdataFolder,"/inst/extdata/aglu/A_bio_frac_prod_R.csv",sep = "")
  file_A_soil_time_scale_R = paste(gcamdataFolder,"/inst/extdata/aglu/A_soil_time_scale_R.csv",sep = "")
  file_emissions_A_regions = paste(gcamdataFolder,"/inst/extdata/emissions/A_regions.csv",sep = "")
  file_A23.subsector_interp_R = paste(gcamdataFolder,"/inst/extdata/energy/A23.subsector_interp_R.csv",sep = "")
  file_energy_A_regions = paste(gcamdataFolder,"/inst/extdata/energy/A_regions.csv",sep = "")
  file_offshore_wind_potential_scaler = paste(gcamdataFolder,"/inst/extdata/energy/offshore_wind_potential_scaler.csv",sep = "")

  file_list <- list(file_iso_GCAM_regID, file_GCAM_region_names, file_A_bio_frac_prod_R,
                    file_A_soil_time_scale_R, file_A_soil_time_scale_R, file_emissions_A_regions,
                    file_A23.subsector_interp_R, file_energy_A_regions, file_offshore_wind_potential_scaler)

  }

  #..................
  # Check Inputs
  # .................

  if(T){
  print("Checking inputs ...")

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
    stop(paste("File ", file_list[[i]], " does not exist.", sep = ""))
  }}

  print("Input checks complete ...")
  }

  #..................
  # Read in files to modify
  # .................

  if(T){
  print("Reading in files to modify ...")

  iso_GCAM_regID = utils::read.csv(file_iso_GCAM_regID, sep = ",",comment.char="#") %>% tibble::as_tibble(); iso_GCAM_regID

  iso_GCAM_regID_comments <- ((utils::read.csv(file_iso_GCAM_regID, header = F))[,1])%>%
    as.data.frame();
    names(iso_GCAM_regID_comments)<-"Col1"
  iso_GCAM_regID_comments <- iso_GCAM_regID_comments %>%
    dplyr::filter(grepl("#",Col1)); iso_GCAM_regID_comments


  GCAM_region_names = utils::read.csv(file_GCAM_region_names, sep = ",",comment.char="#") %>% tibble::as_tibble(); GCAM_region_names

  GCAM_region_names_comments <- ((utils::read.csv(file_GCAM_region_names, header = F))[,1])%>%
    as.data.frame();
  names(GCAM_region_names_comments)<-"Col1"
  GCAM_region_names_comments <- GCAM_region_names_comments %>%
    dplyr::filter(grepl("#",Col1)); GCAM_region_names_comments


  A_bio_frac_prod_R = utils::read.csv(file_A_bio_frac_prod_R, sep = ",",comment.char="#") %>% tibble::as_tibble(); A_bio_frac_prod_R

  A_bio_frac_prod_R_comments <- ((utils::read.csv(file_A_bio_frac_prod_R, header = F))[,1])%>%
    as.data.frame();
  names(A_bio_frac_prod_R_comments)<-"Col1"
  A_bio_frac_prod_R_comments <- A_bio_frac_prod_R_comments %>%
    dplyr::filter(grepl("#",Col1)); A_bio_frac_prod_R_comments

  A_soil_time_scale_R = utils::read.csv(file_A_soil_time_scale_R, sep = ",",comment.char="#") %>% tibble::as_tibble(); A_soil_time_scale_R
  A_soil_time_scale_R_comments <- ((utils::read.csv(file_A_soil_time_scale_R, header = F))[,1])%>%
    as.data.frame();
  names(A_soil_time_scale_R_comments)<-"Col1"
  A_soil_time_scale_R_comments <- A_soil_time_scale_R_comments %>%
    dplyr::filter(grepl("#",Col1)); A_soil_time_scale_R_comments

  emissions_A_regions = utils::read.csv(file_emissions_A_regions, sep = ",",comment.char="#") %>% tibble::as_tibble(); emissions_A_regions
  emissions_A_regions_comments <- ((utils::read.csv(file_emissions_A_regions, header = F))[,1])%>%
    as.data.frame();
  names(emissions_A_regions_comments)<-"Col1"
  emissions_A_regions_comments <- emissions_A_regions_comments %>%
    dplyr::filter(grepl("#",Col1)); emissions_A_regions_comments

  A23.subsector_interp_R = utils::read.csv(file_A23.subsector_interp_R, sep = ",",comment.char="#") %>% tibble::as_tibble(); A23.subsector_interp_R
  A23.subsector_interp_R_comments <- ((utils::read.csv(file_A23.subsector_interp_R, header = F))[,1])%>%
    as.data.frame();
  names(A23.subsector_interp_R_comments)<-"Col1"
  A23.subsector_interp_R_comments <- A23.subsector_interp_R_comments %>%
    dplyr::filter(grepl("#",Col1)); A23.subsector_interp_R_comments

  energy_A_regions = utils::read.csv(file_energy_A_regions, sep = ",",comment.char="#") %>% tibble::as_tibble(); energy_A_regions
  energy_A_regions_comments <- ((utils::read.csv(file_energy_A_regions, header = F))[,1])%>%
    as.data.frame();
  names(energy_A_regions_comments)<-"Col1"
  energy_A_regions_comments <- energy_A_regions_comments %>%
    dplyr::filter(grepl("#",Col1)); energy_A_regions_comments

  offshore_wind_potential_scaler = utils::read.csv(file_offshore_wind_potential_scaler, sep = ",",comment.char="#") %>% tibble::as_tibble(); offshore_wind_potential_scaler
  offshore_wind_potential_scaler_comments <-  ((utils::read.csv(file_offshore_wind_potential_scaler, header = F))[,1])%>%
    as.data.frame();
  names(offshore_wind_potential_scaler_comments)<-"Col1"
  offshore_wind_potential_scaler_comments <- offshore_wind_potential_scaler_comments %>%
    dplyr::filter(grepl("#",Col1)); offshore_wind_potential_scaler_comments

  print("All files read.")
  }

  #..................
  # Modify files
  # .................

  if(T){

    print("Starting to modify files for new country ...")

    #..................
    # Check regionNew and original ID's
    # .................

    if (!is.null(regionNew)){
      if(!is.null(countriesNew)){
      if (!all(tolower(countriesNew) %in% tolower(unique(iso_GCAM_regID$country_name)))){
        stop(paste("Not all countriesNew chosen: ", paste(countriesNew,collapse=", "),
                   " exist in iso_GCAM_regID country_name.", sep=""))
      }
      if (tolower(regionNew) %in% tolower(unique(GCAM_region_names$region))){
        stop(paste("regionNew chosen: ", regionNew,
                   " already exists as a separate GCAM region.", sep=""))
      }

      # Reformat country names and get parent region IDs
      for (i in 1:length(countriesNew)){
        iso_GCAM_regID_countries <- as.vector(unique(iso_GCAM_regID$country_name))
        countriesNew[i] <- iso_GCAM_regID_countries[
        tolower(iso_GCAM_regID_countries) == tolower(countriesNew[i])]

      parent_region_ID[i] <- ((iso_GCAM_regID %>%
                                dplyr::filter(
                                  tolower(country_name) == tolower(countriesNew[i])
                                ))$GCAM_region_ID) %>%
        unique()

      parent_region[i] <- ((GCAM_region_names %>%
                              dplyr::filter(
                                GCAM_region_ID ==  parent_region_ID[i]))$region) %>%
        unique()
      } # Close loop across countriesNew

      countriesNew
      parent_region_ID
      parent_region

      if(length(regionNew)==0){stop("regionNew not assigned correctly.")}
      if(length(unique(parent_region_ID))!=1){
        print(paste("Unique parent_region_ID: ", paste(unique(parent_region_ID),collapse=", "),sep=""))
        stop("For now all new countries being broken out must come from same parent region.")
        }

      }else{stop("Must enter countriesNew to specify which country or countries to include in new region.")}
    } else {stop("Must enter a regionNew to assign a name for the new region.")}

    #..................
    # Modify extdata/common/iso_GCAM_regID.csv
    # .................

    if (T) {
        new_region_ID <- as.integer(max(iso_GCAM_regID$GCAM_region_ID) + 1)
        new_region_ID

        iso_GCAM_regID_new <- iso_GCAM_regID
        for ( i in 1:length(countriesNew)){
        iso_GCAM_regID_new <- iso_GCAM_regID_new %>%
          dplyr::mutate(GCAM_region_ID =
                          dplyr::case_when(
                            tolower(countriesNew[i]) == tolower(country_name) ~ new_region_ID,
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

        print(paste("Added region: '", regionNew,
                    "' and GCAM_region_ID: ", new_region_ID,
                    " for selected countries ", paste(countriesNew,collapse = ", "),
                    " to ", filename, sep=""))
      }

    #..................
    # Modify extdata/common/GCAM_region_names.csv
    # .................

    if (T) {

      filename <- file_GCAM_region_names

      GCAM_region_names_new <- GCAM_region_names %>%
        dplyr::bind_rows(GCAM_region_names[1,] %>%
        dplyr::mutate(GCAM_region_ID = new_region_ID,
                      region = regionNew));
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

      print(paste("Added region: ", regionNew,
                  " and GCAM_region_ID: ", new_region_ID,
                  " to ", filename, sep=""))
    }

    #..................
    # Modify extdata/aglu/A_bio_frac_prod_R.csv
    # .................

    if (T) {

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

      print(paste("Added data for new region: ", regionNew,
                  " with GCAM_region_ID: ", new_region_ID,
                  " based on data from parent region: ", unique(parent_region),
                  " with GCAM_region_ID: ", unique(parent_region_ID),
                  " to ", filename, sep=""))
    }

    #..................
    # Modify extdata/aglu/A_soil_time_scale_R.csv
    # .................

    if (T) {

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

      print(paste("Added data for new region: ", regionNew,
                  " with GCAM_region_ID: ", new_region_ID,
                  " based on data from parent region: ", unique(parent_region),
                  " with GCAM_region_ID: ", unique(parent_region_ID),
                  " to ", filename, sep=""))
    }

    #..................
    # Modify extdata/emissions/A_regions.csv
    # .................

    if (T) {

      filename <- file_emissions_A_regions
      # Assign the value from the parent region to the new country
      emissions_A_regions_new <- emissions_A_regions %>%
        dplyr::bind_rows(emissions_A_regions %>%
                           dplyr::filter(GCAM_region_ID == unique(parent_region_ID)) %>%
                           dplyr::mutate(GCAM_region_ID = new_region_ID,
                                         region = regionNew));
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

      print(paste("Added data for new region: ", regionNew,
                  " with GCAM_region_ID: ", new_region_ID,
                  " based on data from parent region: ", unique(parent_region),
                  " with GCAM_region_ID: ", unique(parent_region_ID),
                  " to ", filename, sep=""))
    }


    #..................
    # Modify extdata/energy/A23.subsector_interp_R.csv
    # .................

    if (T) {

      filename <- file_A23.subsector_interp_R
      # Assign the value from the parent region to the new country
      A23.subsector_interp_R_new <- A23.subsector_interp_R %>%
        dplyr::bind_rows(A23.subsector_interp_R %>%
                           dplyr::filter(region == unique(parent_region)) %>%
                           dplyr::mutate(region = regionNew));
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

      print(paste("Added data for new region: ", regionNew,
                  " with GCAM_region_ID: ", new_region_ID,
                  " based on data from parent region: ", unique(parent_region),
                  " with GCAM_region_ID: ", unique(parent_region_ID),
                  " to ", filename, sep=""))
    }

    #..................
    # Modify extdata/energy/A_regions.csv
    # .................

    if (T) {

      filename <- file_energy_A_regions
      # Assign the value from the parent region to the new country
      energy_A_regions <- energy_A_regions %>%
        dplyr::bind_rows(energy_A_regions %>%
                           dplyr::filter(GCAM_region_ID == unique(parent_region_ID)) %>%
                           dplyr::mutate(region = regionNew,
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

      print(paste("Added data for new region: ", regionNew,
                  " with GCAM_region_ID: ", new_region_ID,
                  " based on data from parent region: ", unique(parent_region),
                  " with GCAM_region_ID: ", unique(parent_region_ID),
                  " to ", filename, sep=""))
    }


    #..................
    # Modify extdata/energy/offshore_wind_potential_scaler.csv
    # .................

    if (T) {

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

      print(paste("Added data for new region: ", regionNew,
                  " with GCAM_region_ID: ", new_region_ID,
                  " based on data from parent region: ", unique(parent_region),
                  " with GCAM_region_ID: ", unique(parent_region_ID),
                  " to ", filename, sep=""))
    }

  }

  #..............................
  #..............................

  closeAllConnections()
  print("Finished running breakout.")
  print(paste("Please re-build gcamdata and re-run driver() from your folder: ",gcamdataFolder,sep=""))
}

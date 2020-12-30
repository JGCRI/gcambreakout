# breakout.R
#' Function to breakout region in gcamdata
#' @param gcamdataFolder Default = NULL. Full path to gcamdata folder.
#' @param countryNew Default = NULL. Name of New Country.
#' @importFrom magrittr %>%
#' @importFrom data.table :=
#' @export
#'

breakout <- function(gcamdataFolder=NULL,
                     countryNew=NULL) {

  #..................
  # Initialize variables
  # .................

  if(T){
  print("Starting rgcambreakout ...")

  NULL -> Col1
  closeAllConnections()
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
  files2check <- c("common/iso_GCAM_regID.csv",
                   "common/GCAM_region_names.csv",
                   "aglu/A_bio_frac_prod_R.csv",
                   "aglu/A_soil_time_scale_R.csv",
                   "emissions/A_regions.csv",
                   "energy/A23.subsector_interp_R.csv",
                   "energy/A_regions.csv",
                   "energy/offshore_wind_potential_scaler.csv")

  for(i in 1:length(files2check)){
  if (!file.exists(paste(gcamdataFolder,
                         "/inst/extdata/",
                         files2check[i],
                         sep = ""))) {
    stop(paste("File ", files2check[i], " does not exist.", sep = ""))
  }}

  print("Input checks complete ...")
  }

  #..................
  # Read in files to modify
  # .................

  if(T){
  print("Reading in files to modify ...")

  iso_GCAM_regID = utils::read.csv(paste(
    gcamdataFolder,
    "/inst/extdata/common/iso_GCAM_regID.csv",
    sep = ""),
  sep = ",",
  comment.char="#") %>% tibble::as_tibble(); iso_GCAM_regID

  iso_GCAM_regID_comments <- utils::read.csv(paste(
    gcamdataFolder,
    "/inst/extdata/common/iso_GCAM_regID.csv",
    sep = ""), header = F) %>%
    as.data.frame();
    names(iso_GCAM_regID_comments)<-"Col1"
  iso_GCAM_regID_comments <- iso_GCAM_regID_comments %>%
    dplyr::filter(grepl("#",Col1)); iso_GCAM_regID_comments

  GCAM_region_names = data.table::fread(paste(
    gcamdataFolder,
    "/inst/extdata/common/GCAM_region_names.csv",
    sep = ""
  )) %>% tibble::as_tibble(); GCAM_region_names

  GCAM_region_names_comments <- utils::read.csv(paste(
    gcamdataFolder,
    "/inst/extdata/common/GCAM_region_names.csv",
    sep = ""), header = F) %>%
    as.data.frame();
  names(GCAM_region_names_comments)<-"Col1"
  GCAM_region_names_comments <- GCAM_region_names_comments %>%
    dplyr::filter(grepl("#",Col1)); GCAM_region_names_comments

  A_bio_frac_prod_R = data.table::fread(paste(
    gcamdataFolder,
    "/inst/extdata/aglu/A_bio_frac_prod_R.csv",
    sep = ""
  )) %>% tibble::as_tibble(); A_bio_frac_prod_R

  A_soil_time_scale_R = data.table::fread(paste(
    gcamdataFolder,
    "/inst/extdata/aglu/A_soil_time_scale_R.csv",
    sep = ""
  )) %>% tibble::as_tibble(); A_soil_time_scale_R

  A_regions_emiss = data.table::fread(paste(
    gcamdataFolder,
    "/inst/extdata/emissions/A_regions.csv",
    sep = ""
  )) %>% tibble::as_tibble(); A_regions_emiss

  A23.subsector_interp_R = data.table::fread(paste(
    gcamdataFolder,
    "/inst/extdata/energy/A23.subsector_interp_R.csv",
    sep = ""
  )) %>% tibble::as_tibble(); A23.subsector_interp_R

  A_regions_energy = data.table::fread(paste(
    gcamdataFolder,
    "/inst/extdata/energy/A_regions.csv",
    sep = ""
  )) %>% tibble::as_tibble(); A_regions_energy

  offshore_wind_potential_scaler = data.table::fread(paste(
    gcamdataFolder,
    "/inst/extdata/energy/offshore_wind_potential_scaler.csv",
    sep = ""
  )) %>% tibble::as_tibble(); offshore_wind_potential_scaler

  print("All files read.")
  }

  #..................
  # Modify files
  # .................

  if(T){
  print("Starting to modify files for new country ...")

  # Check that countryNew exists in iso_GCAM_regID file
  if (!is.null(countryNew)){
    if (!tolower(countryNew) %in% tolower(unique(iso_GCAM_regID$country_name))){
      stop(paste("countryNew chosen: ", countryNew,
                 " does not exist in iso_GCAM_regID.", sep=""))
    }
    if (tolower(countryNew) %in% tolower(unique(iso_GCAM_regID$region_GCAM3))){
      stop(paste("countryNew chosen: ", countryNew,
                 " already exists as a separate GCAM region (region_GCAM3).", sep=""))
    }

    countryNew <- unique(iso_GCAM_regID$country_name)[
      tolower(unique(iso_GCAM_regID$country_name)) == tolower(countryNew)]

    if(length(countryNew)==0){stop("countryNew not assigned correctly.")}
  }

  # Change its ID # in iso_GCAM_regID
  if (!is.null(countryNew)) {
      newNum <- as.integer(max(iso_GCAM_regID$GCAM_region_ID) + 1)
      newNum

      iso_GCAM_regID_new <- iso_GCAM_regID %>%
        dplyr::mutate(GCAM_region_ID =
                        dplyr::case_when(
                          tolower(countryNew) == tolower(country_name) ~ newNum,
                          TRUE ~ GCAM_region_ID
                        ))
      iso_GCAM_regID_new

        filename <-
        paste(gcamdataFolder,
              "/inst/extdata/common/iso_GCAM_regID.csv",
              sep = "")

      file.copy(filename, gsub(".csv","_Original.csv",filename))
      unlink(filename)

      con <- file(filename, open = "wt")
      for (i in 1:nrow(iso_GCAM_regID_comments)) {
        writeLines(paste(iso_GCAM_regID_comments[i, ]), con)
      }
      utils::write.csv(iso_GCAM_regID_new, con, row.names = F)
      close(con)
      closeAllConnections()

      print(paste("Added region: ", countryNew,
                  " and GCAM_region_ID: ", newNum,
                  " to ", filename, sep=""))
    }

  # Add new region number and name in GCAM_region_names.csv
  if (!is.null(countryNew)) {

    filename <- paste(gcamdataFolder,"/inst/extdata/common/GCAM_region_names.csv",
                      sep = "")

    GCAM_region_names_new <- GCAM_region_names %>%
      dplyr::bind_rows(GCAM_region_names[1,] %>%
      dplyr::mutate(GCAM_region_ID = newNum,
                    region = countryNew)); GCAM_region_names_new

    file.copy(filename, gsub(".csv","_Original.csv",filename))
    unlink(filename)

    con <- file(filename, open = "wt")
    for (i in 1:nrow(GCAM_region_names_comments)) {
      writeLines(paste(GCAM_region_names_comments[i, ]), con)
    }
    utils::write.csv(GCAM_region_names_new, con, row.names = F)
    close(con)
    closeAllConnections()

    print(paste("Added region: ", countryNew,
                " and GCAM_region_ID: ", newNum,
                " to ", filename, sep=""))
  }
  }

  closeAllConnections()
}

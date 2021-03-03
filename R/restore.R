# restore.R
#' Function to breakout region in gcamdata
#' @param gcamdataFolder Default = NULL. Full path to gcamdata folder.
#' @importFrom magrittr %>%
#' @importFrom data.table :=
#' @export
#'

restore <- function(gcamdataFolder = NULL) {

  #..................
  # Initialize variables
  # .................

  if(T){
  print("Starting restore ...")

  NULL -> Col1-> country_name -> GCAM_region_ID -> region
  file_indices_remove <-c()

  # Declare File Names
  file_iso_GCAM_regID = paste(gcamdataFolder,"/inst/extdata/common/iso_GCAM_regID.csv",sep = "")
  file_GCAM_region_names = paste(gcamdataFolder,"/inst/extdata/common/GCAM_region_names.csv",sep = "")
  file_A_bio_frac_prod_R = paste(gcamdataFolder,"/inst/extdata/aglu/A_bio_frac_prod_R.csv",sep = "")
  file_A_soil_time_scale_R = paste(gcamdataFolder,"/inst/extdata/aglu/A_soil_time_scale_R.csv",sep = "")
  file_emissions_A_regions = paste(gcamdataFolder,"/inst/extdata/emissions/A_regions.csv",sep = "")
  file_A23.subsector_interp_R = paste(gcamdataFolder,"/inst/extdata/energy/A23.subsector_interp_R.csv",sep = "")
  file_energy_A_regions = paste(gcamdataFolder,"/inst/extdata/energy/A_regions.csv",sep = "")
  file_offshore_wind_potential_scaler = paste(gcamdataFolder,"/inst/extdata/energy/offshore_wind_potential_scaler.csv",sep = "")
  # Countries Electricity breakout
  file_IEA_Ctry = paste(gcamdataFolder,"/inst/extdata/energy/mappings/IEA_ctry.csv",sep = "")
  file_IEA_memo_ctry = paste(gcamdataFolder,"/inst/extdata/energy/mappings/IEA_memo_ctry.csv",sep = "")

  file_list <- list(file_iso_GCAM_regID, file_GCAM_region_names, file_A_bio_frac_prod_R,
                    file_A_soil_time_scale_R, file_A_soil_time_scale_R, file_emissions_A_regions,
                    file_A23.subsector_interp_R, file_energy_A_regions, file_offshore_wind_potential_scaler,
                    file_IEA_Ctry)

  file_iso_GCAM_regID_orig = paste(gcamdataFolder,"/inst/extdata/common/iso_GCAM_regID_Original.csv",sep = "")
  file_GCAM_region_names_orig = paste(gcamdataFolder,"/inst/extdata/common/GCAM_region_names_Original.csv",sep = "")
  file_A_bio_frac_prod_R_orig = paste(gcamdataFolder,"/inst/extdata/aglu/A_bio_frac_prod_R_Original.csv",sep = "")
  file_A_soil_time_scale_R_orig = paste(gcamdataFolder,"/inst/extdata/aglu/A_soil_time_scale_R_Original.csv",sep = "")
  file_emissions_A_regions_orig = paste(gcamdataFolder,"/inst/extdata/emissions/A_regions_Original.csv",sep = "")
  file_A23.subsector_interp_R_orig = paste(gcamdataFolder,"/inst/extdata/energy/A23.subsector_interp_R_Original.csv",sep = "")
  file_energy_A_regions_orig = paste(gcamdataFolder,"/inst/extdata/energy/A_regions_Original.csv",sep = "")
  file_offshore_wind_potential_scaler_orig = paste(gcamdataFolder,"/inst/extdata/energy/offshore_wind_potential_scaler_Original.csv",sep = "")
  # Countries Electricity breakout
  file_IEA_Ctry_orig = paste(gcamdataFolder,"/inst/extdata/energy/mappings/IEA_ctry_Original.csv",sep = "")
  file_IEA_memo_ctry_orig = paste(gcamdataFolder,"/inst/extdata/energy/mappings/IEA_memo_ctry_Original.csv",sep = "")

  file_list_orig <- list(file_iso_GCAM_regID_orig, file_GCAM_region_names_orig, file_A_bio_frac_prod_R_orig,
                        file_A_soil_time_scale_R_orig, file_A_soil_time_scale_R_orig, file_emissions_A_regions_orig,
                        file_A23.subsector_interp_R_orig, file_energy_A_regions_orig, file_offshore_wind_potential_scaler_orig,
                        file_IEA_Ctry_orig)

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
    print(paste("File ", file_list[[i]], " does not exist.", sep = ""))
  }}

    # Check that all original files exist
    for(i in 1:length(file_list_orig)){
      if (!file.exists(file_list_orig[[i]])) {
        print(paste("File ", file_list_orig[[i]], " does not exist. Will be skipped in restoration.", sep = ""))
        file_indices_remove<-c(file_indices_remove,i)
      }}
    file_list_orig<-file_list_orig[-c(file_indices_remove)]

  print("Input checks complete ...")
  }

  #..................
  # Delete new files and restore originals
  # .................
  if(T){
    print("Restoring files ...")

    # Delete new files
    for(i in 1:length(file_list)){
      if(file_list[[i]] %in% gsub("_Original","",unlist(file_list_orig))){
        unlink(file_list[[i]])
      }
      }

    # Check that all the input files to be modified exist
    for(i in 1:length(file_list_orig)){
      if( gsub("_Original","",file_list_orig[[i]]) %in% unlist(file_list)){
      file.copy(file_list_orig[[i]], gsub("_Original.csv",".csv",file_list_orig[[i]]))
        unlink(file_list_orig[[i]])
      }

      filename <- gsub("IEA_ctry.csv","IEA_memo_ctry.csv", file_IEA_Ctry)
      if(!file.exists(filename)){unlink(filename)}

      }

    }


  #..............................
  #..............................
  print("Finished restoring original files.")
  print(paste("Please re-run gcamdata from your folder: ",gcamdataFolder,sep=""))
}

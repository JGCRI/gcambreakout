# restore.R
#' Function to breakout region in gcamdata
#' @param gcamdataFolder Default = NULL. Full path to gcamdata folder.
#' @importFrom magrittr %>%
#' @importFrom data.table :=
#' @export
#'

restore <- function(gcamdataFolder = NULL) {

  # To fold code into readable sections place cursor here and enter: ALT + 0
  # To unfold: ALT + SHIFT + O (Not zero but O)

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
  file_EPA_country_map = paste(gcamdataFolder,"/inst/extdata/emissions/EPA_country_map.csv",sep = "")
  file_A323.inc_elas_parameter = paste(gcamdataFolder,"/inst/extdata/socioeconomics/A323.inc_elas_parameter.csv",sep = "")
  file_A326.inc_elas_parameter = paste(gcamdataFolder,"/inst/extdata/socioeconomics/A326.inc_elas_parameter.csv",sep = "")
  file_A62.calibration = paste(gcamdataFolder,"/inst/extdata/energy/A62.calibration.csv",sep = "")
  file_WSA_gcam_mapping = paste(gcamdataFolder,"/inst/extdata/energy/mappings/WSA_gcam_mapping.csv",sep = "")
  file_GCAM_region_pipeline_bloc_export = paste(gcamdataFolder,"/inst/extdata/energy/GCAM_region_pipeline_bloc_export.csv",sep = "")
  file_GCAM_region_pipeline_bloc_import = paste(gcamdataFolder,"/inst/extdata/energy/GCAM_region_pipeline_bloc_import.csv",sep = "")


  file_list <- list(file_iso_GCAM_regID, file_GCAM_region_names, file_A_bio_frac_prod_R,
                    file_A_soil_time_scale_R, file_A_soil_time_scale_R, file_emissions_A_regions,
                    file_A23.subsector_interp_R, file_energy_A_regions, file_offshore_wind_potential_scaler,
                    file_EPA_country_map,file_A323.inc_elas_parameter,file_A326.inc_elas_parameter,
                    file_A62.calibration, file_WSA_gcam_mapping, file_GCAM_region_pipeline_bloc_export, file_GCAM_region_pipeline_bloc_import)

  file_iso_GCAM_regID_orig = paste(gcamdataFolder,"/inst/extdata/common/iso_GCAM_regID_Original.csv",sep = "")
  file_iso_GCAM_regID_orig_parent = paste(gcamdataFolder,"/inst/extdata/common/iso_GCAM_regID_Original_parent.csv",sep = "")
  file_GCAM_region_names_orig = paste(gcamdataFolder,"/inst/extdata/common/GCAM_region_names_Original.csv",sep = "")
  file_A_bio_frac_prod_R_orig = paste(gcamdataFolder,"/inst/extdata/aglu/A_bio_frac_prod_R_Original.csv",sep = "")
  file_A_soil_time_scale_R_orig = paste(gcamdataFolder,"/inst/extdata/aglu/A_soil_time_scale_R_Original.csv",sep = "")
  file_emissions_A_regions_orig = paste(gcamdataFolder,"/inst/extdata/emissions/A_regions_Original.csv",sep = "")
  file_A23.subsector_interp_R_orig = paste(gcamdataFolder,"/inst/extdata/energy/A23.subsector_interp_R_Original.csv",sep = "")
  file_energy_A_regions_orig = paste(gcamdataFolder,"/inst/extdata/energy/A_regions_Original.csv",sep = "")
  file_offshore_wind_potential_scaler_orig = paste(gcamdataFolder,"/inst/extdata/energy/offshore_wind_potential_scaler_Original.csv",sep = "")
  file_EPA_country_map_orig = paste(gcamdataFolder,"/inst/extdata/emissions/EPA_country_map_Original.csv",sep = "")
  file_A323.inc_elas_parameter_orig = paste(gcamdataFolder,"/inst/extdata/socioeconomics/A323.inc_elas_parameter_Original.csv",sep = "")
  file_A326.inc_elas_parameter_orig = paste(gcamdataFolder,"/inst/extdata/socioeconomics/A326.inc_elas_parameter_Original.csv",sep = "")
  file_A62.calibration_orig = paste(gcamdataFolder,"/inst/extdata/energy/A62.calibration_Original.csv",sep = "")
  file_WSA_gcam_mapping_orig = paste(gcamdataFolder,"/inst/extdata/energy/mappings/WSA_gcam_mapping_Original.csv",sep = "")
  file_GCAM_region_pipeline_bloc_export_orig = paste(gcamdataFolder,"/inst/extdata/energy/GCAM_region_pipeline_bloc_export_Original.csv",sep = "")
  file_GCAM_region_pipeline_bloc_import_orig = paste(gcamdataFolder,"/inst/extdata/energy/GCAM_region_pipeline_bloc_import_Original.csv",sep = "")

  file_list_orig <- list(file_iso_GCAM_regID_orig, file_iso_GCAM_regID_orig_parent, file_GCAM_region_names_orig, file_A_bio_frac_prod_R_orig,
                        file_A_soil_time_scale_R_orig, file_A_soil_time_scale_R_orig, file_emissions_A_regions_orig,
                        file_A23.subsector_interp_R_orig, file_energy_A_regions_orig, file_offshore_wind_potential_scaler_orig,
                        file_EPA_country_map_orig, file_A323.inc_elas_parameter_orig, file_A326.inc_elas_parameter_orig,
                        file_A62.calibration_orig, file_WSA_gcam_mapping_orig,
                        file_GCAM_region_pipeline_bloc_export_orig, file_GCAM_region_pipeline_bloc_import_orig)


  # Cities
  file_list_cities <- list.files(paste0(gcamdataFolder,"/R"), full.names = T)
  file_list_cities <- file_list_cities[grepl("zchunk_X",file_list_cities)]
  file_list_cities <- file_list_cities[!grepl("building_breakout",file_list_cities)] # Remove breakout files from list

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
    if(!is.null(file_indices_remove)){
    file_list_orig<-file_list_orig[-c(file_indices_remove)]}


    # Check that all cities files exist
    if(length(file_list_cities)>0){
    for(i in 1:length(file_list_cities)){
      if (!file.exists(file_list_cities[[i]])) {
        print(paste("File ", file_list_cities[[i]], " does not exist. Will be skipped in restoration.", sep = ""))
        file_indices_remove<-c(file_indices_remove,i)
      }}
      if(!is.null(file_indices_remove)){
      file_list_cities<-file_list_cities[-c(file_indices_remove)]}
    }

  print("Input checks complete ...")
  }

  #..................
  # Delete new files and restore originals
  # .................
  if(T){
    print("Restoring files ...")

    # Delete new files
    if(length(file_list)>0){
    for(i in 1:length(file_list)){
      if(file_list[[i]] %in% gsub("_Original","",unlist(file_list_orig))){
        unlink(file_list[[i]])
      }
      }}

    # Delete Original Files
    if(length(file_list_orig)>0){
    for(i in 1:length(file_list_orig)){
      if( gsub("_Original","",file_list_orig[[i]]) %in% unlist(file_list)){
      file.copy(file_list_orig[[i]], gsub("_Original.csv",".csv",file_list_orig[[i]]))
        unlink(file_list_orig[[i]])
      }}
    }

    # Delete City Files
    if(length(file_list_cities)>0){
      for(i in 1:length(file_list_cities)){
          unlink(file_list_cities[[i]])
        }
    }

    # Replacing original module files
    module_folders <- mapping_modules$folder%>%unique()

    for(module_folder_i in module_folders){

    modules_folder <- paste0(gcamdataFolder,"/",module_folder_i,"/originals")
    if(dir.exists(modules_folder)){

      module_files_to_restore <- list.files(modules_folder, full.names = T)

      file.copy(module_files_to_restore, gsub(paste0("/",module_folder_i,"/originals/"),paste0("/",module_folder_i,"/"),module_files_to_restore),overwrite = T)
      unlink(modules_folder, recursive = T)

      print(paste0("Restored module files:"))
      print(paste0(module_files_to_restore))
    }
    }

    }

  #..............................
  #..............................
  print("Finished restoring original files.")
  print(paste("Please re-run gcamdata from your folder: ",gcamdataFolder,sep=""))
}

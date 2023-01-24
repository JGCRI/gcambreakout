context("test restore")
library(gcambreakout); library(testthat)

test_that("restore generates original files for gcam v5p4", {

  # Reset data test data
  gcamdataFolderOriginal = paste(getwd(),"/original",sep="")
  gcamdataFolder = paste(getwd(),"/test",sep="")
  unlink(gcamdataFolder,recursive=T)
  dir.create(gcamdataFolder)
  file.copy(paste(gcamdataFolderOriginal,"/inst",sep=""), gcamdataFolder, recursive=TRUE)

  gcambreakout::breakout_regions(gcamdataFolder = gcamdataFolder,
                          regionsNew = "Thailand Laos",
                          countriesNew = c("Thailand","Lao Peoples Democratic Republic"),
                          gcam_version = "5.4")

  gcambreakout::restore(gcamdataFolder = paste(getwd(),"/test",sep=""))

  expect_true(all(
    file.exists(paste(getwd(),"/test/inst/extdata/common/iso_GCAM_regID.csv",sep = "")),
    file.exists(paste(getwd(),"/test/inst/extdata/common/GCAM_region_names.csv",sep = "")),
    file.exists(paste(getwd(),"/test/inst/extdata/aglu/A_bio_frac_prod_R.csv",sep = "")),
    file.exists(paste(getwd(),"/test/inst/extdata/aglu/A_soil_time_scale_R.csv",sep = "")),
    file.exists(paste(getwd(),"/test/inst/extdata/emissions/A_regions.csv",sep = "")),
    file.exists(paste(getwd(),"/test/inst/extdata/energy/A23.subsector_interp_R.csv",sep = "")),
    file.exists(paste(getwd(),"/test/inst/extdata/energy/A_regions.csv",sep = "")),
    file.exists(paste(getwd(),"/test/inst/extdata/energy/offshore_wind_potential_scaler.csv",sep = "")),
    !file.exists(paste(getwd(),"/test/inst/extdata/common/iso_GCAM_regID_Original.csv",sep = "")),
    !file.exists(paste(getwd(),"/test/inst/extdata/common/iso_GCAM_regID_Original.csv",sep = "")),
    !file.exists(paste(getwd(),"/test/inst/extdata/common/GCAM_region_names_Original.csv",sep = "")),
    !file.exists(paste(getwd(),"/test/inst/extdata/aglu/A_bio_frac_prod_R_Original.csv",sep = "")),
    !file.exists(paste(getwd(),"/test/inst/extdata/aglu/A_soil_time_scale_R_Original.csv",sep = "")),
    !file.exists(paste(getwd(),"/test/inst/extdata/emissions/A_regions_Original.csv",sep = "")),
    !file.exists(paste(getwd(),"/test/inst/extdata/energy/A23.subsector_interp_R_Original.csv",sep = "")),
    !file.exists(paste(getwd(),"/test/inst/extdata/energy/A_regions_Original.csv",sep = "")),
    !file.exists(paste(getwd(),"/test/inst/extdata/energy/offshore_wind_potential_scaler_Original.csv",sep = ""))
  )
  )

})


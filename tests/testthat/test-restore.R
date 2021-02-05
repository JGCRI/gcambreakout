context("test restore")
library(gcambreakout); library(testthat)

test_that("restore generates original files", {

  # Reset data test data
  gcamdataFolderOriginal = paste(getwd(),"/gcamdata_test_Original",sep="")
  gcamdataFolder = paste(getwd(),"/gcamdata_test",sep="")
  unlink(gcamdataFolder,recursive=T)
  dir.create(gcamdataFolder)
  file.copy(paste(gcamdataFolderOriginal,"/inst",sep=""), gcamdataFolder, recursive=TRUE)

  gcambreakout::breakout(gcamdataFolder = gcamdataFolder,
                          regionNew = "Thailand Laos",
                          countriesNew = c("Thailand","Lao Peoples Democratic Republic"))

  gcambreakout::restore(gcamdataFolder = paste(getwd(),"/gcamdata_test",sep=""))

  expect_true(all(
    file.exists(paste(getwd(),"/gcamdata_test/inst/extdata/common/iso_GCAM_regID.csv",sep = "")),
    file.exists(paste(getwd(),"/gcamdata_test/inst/extdata/common/iso_GCAM_regID.csv",sep = "")),
    file.exists(paste(getwd(),"/gcamdata_test/inst/extdata/common/GCAM_region_names.csv",sep = "")),
    file.exists(paste(getwd(),"/gcamdata_test/inst/extdata/aglu/A_bio_frac_prod_R.csv",sep = "")),
    file.exists(paste(getwd(),"/gcamdata_test/inst/extdata/aglu/A_soil_time_scale_R.csv",sep = "")),
    file.exists(paste(getwd(),"/gcamdata_test/inst/extdata/emissions/A_regions.csv",sep = "")),
    file.exists(paste(getwd(),"/gcamdata_test/inst/extdata/energy/A23.subsector_interp_R.csv",sep = "")),
    file.exists(paste(getwd(),"/gcamdata_test/inst/extdata/energy/A_regions.csv",sep = "")),
    file.exists(paste(getwd(),"/gcamdata_test/inst/extdata/energy/offshore_wind_potential_scaler.csv",sep = "")),
    !file.exists(paste(getwd(),"/gcamdata_test/inst/extdata/common/iso_GCAM_regID_Original.csv",sep = "")),
    !file.exists(paste(getwd(),"/gcamdata_test/inst/extdata/common/iso_GCAM_regID_Original.csv",sep = "")),
    !file.exists(paste(getwd(),"/gcamdata_test/inst/extdata/common/GCAM_region_names_Original.csv",sep = "")),
    !file.exists(paste(getwd(),"/gcamdata_test/inst/extdata/aglu/A_bio_frac_prod_R_Original.csv",sep = "")),
    !file.exists(paste(getwd(),"/gcamdata_test/inst/extdata/aglu/A_soil_time_scale_R_Original.csv",sep = "")),
    !file.exists(paste(getwd(),"/gcamdata_test/inst/extdata/emissions/A_regions_Original.csv",sep = "")),
    !file.exists(paste(getwd(),"/gcamdata_test/inst/extdata/energy/A23.subsector_interp_R_Original.csv",sep = "")),
    !file.exists(paste(getwd(),"/gcamdata_test/inst/extdata/energy/A_regions_Original.csv",sep = "")),
    !file.exists(paste(getwd(),"/gcamdata_test/inst/extdata/energy/offshore_wind_potential_scaler_Original.csv",sep = ""))
  )
  )

})


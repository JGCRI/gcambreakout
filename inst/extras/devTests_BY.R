# library(devtools)
# install_github("JGCRI/gcambreakout")
library(gcambreakout); library(dplyr)

gcamdataFolderx <- "D:/INFEWS/GCAM/gcambreakout-LAC-6.0/input/gcamdata"
#city_files_folder <- "C:/gcam/gcam-core_stash/input/gcamdata/inst/extdata/breakout"
gcam_version_i="6.0"
#gcamdataFolderx <- "C:/gcam/gcam-v5.4-Windows-Release-Package/input/gcamdata"

countries_allowed <- read.csv(paste0(gcamdataFolderx,"/inst/extdata/common/iso_GCAM_regID.csv"), comment.char = '#', header=T); countries_allowed$country_name%>%sort()
current_GCAM_regions <- read.csv(paste0(gcamdataFolderx,"/inst/extdata/common/GCAM_region_names.csv"), comment.char = '#', header=T); current_GCAM_regions%>%arrange(GCAM_region_ID)


#-----------------------------------------------------------------
# Breakout a new region for a new region with a single country
#-----------------------------------------------------------------
restore(gcamdataFolder = gcamdataFolderx)  # (OPTIONAL) Uncomment this line and restore the datasystem to original state

breakout_regions(gcamdataFolder = gcamdataFolderx,
                 regionsNew = c("Thailand"),
                 countriesNew = c("Thailand"),
                 gcam_version=gcam_version_i)
# Users can confirm that a new region has been added by opening the .csv file: ./input/gcamdata/inst/extdata/common/GCAM_region_names.csv

breakout_regions(gcamdataFolder = gcamdataFolderx,
                 regionsNew = c("Malaysia"),
                 countriesNew = c("Malaysia"),
                 gcam_version=gcam_version_i)


#-----------------------------------------------------------------
# Breakout a new region for a new region with a single country
#-----------------------------------------------------------------
breakout_regions(gcamdataFolder = gcamdataFolderx,
                 regionsNew = c("Chile"),
                 countriesNew = c("Chile"),
                 gcam_version=gcam_version_i)
# Users can confirm that a new region has been added by opening the .csv file: ./input/gcamdata/inst/extdata/common/GCAM_region_names.csv
restore(gcamdataFolder = gcamdataFolderx)  # (OPTIONAL) Uncomment this line and restore the datasystem to original state

#-----------------------------------------------------------------
# Breakout a new region for a new region with a single country
#-----------------------------------------------------------------
breakout_regions(gcamdataFolder = gcamdataFolderx,
                 regionsNew = c("Nigeria"),
                 countriesNew = c("Nigeria"),
                 gcam_version=gcam_version_i)
# Users can confirm that a new region has been added by opening the .csv file: ./input/gcamdata/inst/extdata/common/GCAM_region_names.csv
restore(gcamdataFolder = gcamdataFolderx)  # (OPTIONAL) Uncomment this line and restore the datasystem to original state


#-----------------------------------------------------------------
# Breakout a new region for a new region with a single country
#-----------------------------------------------------------------
breakout_regions(gcamdataFolder = gcamdataFolderx,
                 regionsNew = c("Nigeria"),
                 countriesNew = c("Nigeria"),
                 gcam_version=gcam_version_i)
# Users can confirm that a new region has been added by opening the .csv file: ./input/gcamdata/inst/extdata/common/GCAM_region_names.csv
restore(gcamdataFolder = gcamdataFolderx)  # (OPTIONAL) Uncomment this line and restore the datasystem to original state


#-----------------------------------------------------------------
# Breakout a new region for a new region with a single country
#-----------------------------------------------------------------
breakout_regions(gcamdataFolder = gcamdataFolderx,
                 regionsNew = c("Uruguay"),
                 countriesNew = c("Uruguay"),
                 gcam_version=gcam_version_i)
# Users can confirm that a new region has been added by opening the .csv file: ./input/gcamdata/inst/extdata/common/GCAM_region_names.csv
restore(gcamdataFolder = gcamdataFolderx)  # (OPTIONAL) Uncomment this line and restore the datasystem to original state



#-----------------------------------------------------------------
# Breakout a new region for a new region with a single country Spain
#-----------------------------------------------------------------
breakout_regions(gcamdataFolder = gcamdataFolderx,
                regionsNew = c("Ukraine2010"),
                countriesNew = c("Ukraine"))
# Users can confirm that a new region has been added by opening the .csv file: ./input/gcamdata/inst/extdata/common/GCAM_region_names.csv
restore(gcamdataFolder = gcamdataFolderx)  # (OPTIONAL) Uncomment this line and restore the datasystem to original state


#-----------------------------------------------------------------
# Breakout a new custom region called "Peru_Chile" with both Peru and Chile
#-----------------------------------------------------------------
breakout_regions(gcamdataFolder = gcamdataFolderx,
                regionsNew = c("Peru_Chile"),
                countriesNew = c("Peru","Chile"))
# Users can confirm that a new region has been added by opening the .csv file: ./input/gcamdata/inst/extdata/common/GCAM_region_names.csv
restore(gcamdataFolder = gcamdataFolderx)  # (OPTIONAL) Uncomment this line and restore the datasystem to original state


#-----------------------------------------------------------------
# Breakout two new regions: One for Peru and One for Chile with each having its own single country within it.
#-----------------------------------------------------------------
breakout_regions(gcamdataFolder = gcamdataFolderx,
                regionsNew = c("Peru","Chile"),
                countriesNew = c("Peru","Chile"))
# Users can confirm that a new region has been added by opening the .csv file: ./input/gcamdata/inst/extdata/common/GCAM_region_names.csv
restore(gcamdataFolder = gcamdataFolderx)  # (OPTIONAL) Uncomment this line and restore the datasystem to original state


#-----------------------------------------------------------------
# Breakout two new regions: One for a combined "Peru_Chile" with Peru and Chile, and one for "Spain_France" with Spain and France
#-----------------------------------------------------------------

# NOTE: In this case the countriesNew must be a list!!

breakout_regions(gcamdataFolder = gcamdataFolderx,
                regionsNew = c("Peru_Chile",
                               "Spain_France"),
                countriesNew = list(c("Peru","Chile"),
                                    c("Spain","France")))
# Users can confirm that a new region has been added by opening the .csv file: ./input/gcamdata/inst/extdata/common/GCAM_region_names.csv
restore(gcamdataFolder = gcamdataFolderx)  # (OPTIONAL) Uncomment this line and restore the datasystem to original state


#--------------------------------------
# SubRegions
#-------------------------------------

breakout_subregions(gcamdataFolder = gcamdataFolderx,
                   region = "Thailand",
                   pop_projection = c(paste0(city_files_folder,"/Subregions_Thailand_pop.csv")),
                   pcgdp_projection = c(paste0(city_files_folder,"/Subregions_Thailand_pcgdp.csv")))

breakout_subregions(gcamdataFolder = gcamdataFolderx,
                   region = "Malaysia",
                   pop_projection = c(paste0(city_files_folder,"/Subregions_Malaysia_pop.csv")),
                   pcgdp_projection = c(paste0(city_files_folder,"/Subregions_Malaysia_pcgdp.csv")))


#restore(gcamdataFolder = gcamdataFolderx)



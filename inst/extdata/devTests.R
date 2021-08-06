# library(devtools)
# install_github("JGCRI/gcambreakout")
library(gcambreakout)

gcamdataFolderx <- "C:/Z/models/GCAMVersions/gcam-core_stash/input/gcamdata"
gcamdataFolderx <- "C:/Z/models/GCAMVersions/gcam-v5.4-Windows-Release-Package/input/gcamdata"

countries_allowed <- read.csv(paste0(gcamdataFolderx,"/inst/extdata/common/iso_GCAM_regID.csv"), comment.char = '#', header=T); countries_allowed$country_name
current_GCAM_regions <- read.csv(paste0(gcamdataFolderx,"/inst/extdata/common/GCAM_region_names.csv"), comment.char = '#', header=T); current_GCAM_regions

#-----------------------------------------------------------------
# Breakout a new region for Spain with a single country Spain
#-----------------------------------------------------------------
breakout_regions(gcamdataFolder = gcamdataFolderx,
                regionsNew = c("Saudi Arabia"),
                countriesNew = c("Saudi Arabia"))
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



#-------------------------------------
#--------------------------------------
# CITIES
#-------------------------------------
#-------------------------------------

breakout_city(gcamdataFolder = gcamdataFolderx,
             region = "Thailand",
             city = "Bangkok",
             popProjection = gcambreakout::template_popProjection,
             pcgdpProjection = gcambreakout::template_pcgdpProjection)

breakout_regions(gcamdataFolder = gcamdataFolderx,
                 regionsNew = c("Malaysia"),
                 countriesNew = c("Malaysia"))

breakout_city(gcamdataFolder = gcamdataFolderx,
             region = "Malaysia",
             city = "KualaLumpur",
             popProjection = "C:/Z/projects/current/00_SMART/kualalumpur/template_popProjection_kl.csv",
             pcgdpProjection = "C:/Z/projects/current/00_SMART/kualalumpur/template_pcgdpProjection_kl.csv")

# gcamdataFolder = gcamdataFolderx
# region = "Thailand"
# city = "Bangkok"

restore(gcamdataFolder = gcamdataFolderx)


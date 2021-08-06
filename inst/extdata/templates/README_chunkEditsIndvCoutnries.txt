
#------------------------------------------------------------------------------------
# Saudia Arabia, Middle East, Silvia/Fernando (George Mason), Mohamad (KAPSAARC)
#------------------------------------------------------------------------------------

# zchunk_L171.desalination.R
- Saudia Arabia 
- See commit https://github.com/pkyle/gcam-core/commit/66c32d621c2a638dafbbe5a538ebe2ab42c58483
- See commit https://github.com/pkyle/gcam-core/commit/3bc818a4f10ae182b9aacda25a6c024c1921ae14

# zchunk_LB120.LC_GIS_R_LTgis_Yh_GLU.R
# Line 120 Added:
# Note: (zk 6 Aug 2021) Removing issues with NA values when Grassland +Shurbland + Pasture =0 for some ne regions
      mutate(nonForScaler = if_else(is.na(nonForScaler) & is.na(ForScaler),1,nonForScaler),
             ForScaler = if_else(is.na(nonForScaler) & is.na(ForScaler),1,nonForScaler))%>%

# In zchunk_LB123.LC_R_MgdPastFor_Yh_GLU
# Line 188 
      # Note: (zk 6 Aug 2021) Modifying to avoid NaN for zero forest areas
      mutate(value = if_else(is.nan(value)|is.na(value),0,value))->


#------------------------------------------------------------------------------------
# SEAsia, malaysia, vietnam, thailand
#------------------------------------------------------------------------------------

# zchunk_L2231.wind_update.R
- SEAsia project
- See commit https://stash.pnnl.gov/projects/JGCRI/repos/gcam-core/commits/aacdc68419ebb5ffeffb78d84f1bd059a348a66b

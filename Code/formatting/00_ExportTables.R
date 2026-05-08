#!/bin/bash
# File was changed from .sh to .R from original analyses
# Export selected tables from Access database to CSV

# set user ID ------------------------------------------
## set your computer name 
## ex C:\Users\mcmahonl\Box\HERS_Working\Bats\DatabaseBE would be "mcmahonl"
user <- "rosesar" 

# set database names ------------------------------------
SRC_dbname <- "PNW_BatHub_Database_20251004.accdb"
SRC_CALLS_dbname <- "PNW_BatHub_Database_AcousticOutput_20251004.accdb"  
SRC_CALLS2_dbname <- "PNW_BatHub_Database_AcousticOutput_2024_to_Present_20251004.accdb"  

# create filepaths -------------------------------------
SRC = paste0("C:\\Users\\", 
             user, 
             "\\Box\\HERS_Working\\Bats\\DatabaseBE\\", 
             SRC_dbname)

SRC_CALLS = paste0("C:\\Users\\", 
                   user,
                   "\\Box\\HERS_Working\\Bats\\DatabaseBE\\", 
                   SRC_CALLS_dbname)

SRC_CALLS2 = paste0("C:\\Users\\", user, 
                    "\\Box\\HERS_Working\\Bats\\DatabaseBE\\",
                    SRC_CALLS2_dbname)

# set output -----------------------------------------
OUT = "DataRaw/tables"

# open each database and pull tables -----------------

## database1
src <- RODBC::odbcConnectAccess2007(SRC)

  ### read in Access Tables
  tblDeployment <- RODBC::sqlFetch(src,"tblDeployment")
  tblPointLocation <- RODBC::sqlFetch(src, "tblPointLocation")
  tblSite <- RODBC::sqlFetch(src, "tblSite")
  tluClutterType <- RODBC::sqlFetch(src, "tluClutterType")
  tluWaterBodyType <-RODBC::sqlFetch(src, "tluWaterBodyType")

  ### close database
  RODBC::odbcClose(src)

## database 2
src_calls <- RODBC::odbcConnectAccess2007(SRC_CALLS)

  ### read in Access tables
  tblcallsto2023 <- RODBC::sqlFetch(src_calls, "tblDeploymentDetection7")
  
  ### close database
  RODBC::odbcClose(src_calls)

## database 3
src_calls2 <- RODBC::odbcConnectAccess2007(SRC_CALLS2)
    
  ### read in Access tables                              
  tblcallsfrom2024 <- RODBC::sqlFetch(src_calls2, "tblDeploymentDetection8")
  
  ### close database
  RODBC::odbcClose(src_calls2)

# save to R files ------------------------------------

saveRDS(tblcallsfrom2024, paste0(getwd(), 
                                 "/DataRaw/tblcallsfrom2024_dwnl_", 
                                 format(Sys.Date(),"%Y%m%d"), ".R"))
saveRDS(tblcallsto2023, paste0(getwd(), 
                                 "/DataRaw/tblcallsto2023_dwnl_", 
                                 format(Sys.Date(),"%Y%m%d"), ".R"))
saveRDS(tblDeployment, paste0(getwd(), 
                                 "/DataRaw/tblDeployment_dwnl_", 
                                 format(Sys.Date(),"%Y%m%d"), ".R"))
saveRDS(tblPointLocation, paste0(getwd(), 
                                 "/DataRaw/tblPointLocation_dwnl_", 
                                 format(Sys.Date(),"%Y%m%d"), ".R"))
saveRDS(tblSite, paste0(getwd(), 
                                 "/DataRaw/tblSite_dwnl_", 
                                 format(Sys.Date(),"%Y%m%d"), ".R"))
saveRDS(tluClutterType, paste0(getwd(), 
                                 "/DataRaw/tluClutterType_dwnl_", 
                                 format(Sys.Date(),"%Y%m%d"), ".R"))
saveRDS(tluWaterBodyType, paste0(getwd(), 
                                 "/DataRaw/tluWaterBodyType_dwnl_", 
                                 format(Sys.Date(),"%Y%m%d"), ".R"))

#!/bin/bash

# Export selected tables from Access database to CSV
SRC<-"C:\\Users\\rosesar\\Box\\HERS_Working\\Bats\\DatabaseBE\\PNW_BatHub_Database_20251004.accdb"
SRC_CALLS="C:\\Users\\rosesar\\Box\\HERS_Working\\Bats\\DatabaseBE\\PNW_BatHub_Database_AcousticOutput_20251004.accdb"
SRC_CALLS2="C:\\Users\\rosesar\\Box\\HERS_Working\\Bats\\DatabaseBE\\PNW_BatHub_Database_AcousticOutput_2024_to_Present_20251004.accdb"
OUT="DataRaw/tables"

# Make sure output folder exists
mkdir -p "$OUT"

mdb-export "$SRC" tblDeployment    > "$OUT/tblDeployment.csv"
mdb-export "$SRC" tblPointLocation > "$OUT/tblPointLocation.csv"
mdb-export "$SRC" tblSite          > "$OUT/tblSite.csv"
mdb-export "$SRC" tluClutterType   > "$OUT/tluClutterType.csv"
mdb-export "$SRC" tluWaterBodyType > "$OUT/tluWaterBodyType.csv"
mdb-export "$SRC_CALLS" tblDeploymentDetection7 > "$OUT/calls_to_2024.csv"
mdb-export "$SRC_CALLS2" tblDeploymentDetection8 > "$OUT/calls_from_2024.csv"
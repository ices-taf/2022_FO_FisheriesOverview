
# Initial formatting of the data

library(icesTAF)
taf.library(icesFO)
library(dplyr)
library(icesFO)

mkdir("data")

# load species list
species_list <- read.taf("bootstrap/data/FAO_ASFIS_species/species_list.csv")
sid <- read.taf("bootstrap/data/ICES_StockInformation/sid.csv")


# 1: ICES official catch statistics

hist <- read.taf("bootstrap/data/ICES_nominal_catches/ICES_historical_catches.csv")
official <- read.taf("bootstrap/data/ICES_nominal_catches/ICES_2006_2019_catches.csv")
prelim <- read.taf("bootstrap/data/ICES_nominal_catches/2020PreliminaryCatchStatistics.csv") # not working
tibble(prelim)

# catch_dat <-
#   format_catches(2020, "Faroes",
#     hist, official, prelim, species_list, sid)
catch_dat <-  format_catches(2022, "Faroes",
    hist, official, NULL, species_list, sid)

write.taf(catch_dat, dir = "data", quote = TRUE)


# 2: Effort and landings, need to figure out data to be used


# 3: SAG
sag_sum <- read.taf("bootstrap/data/SAG_data/SAG_summary.csv")
sag_refpts <- read.taf("bootstrap/data/SAG_data/SAG_refpts.csv")
sag_status <- read.taf("bootstrap/data/SAG_data/SAG_status.csv")

clean_sag <- format_sag(sag_complete, sid)
clean_status <- format_sag_status(status, 2022, "Faroes")

check <- unique(clean_sag$StockKeyLabel)
unique(clean_sag$StockKeyLabel)

FO_2020FO_StockList_1 <- read.csv("data/FO_2020FO_StockList_1_PS.csv",sep = ";")
# Exclude also hom.27.2a4a5b6a7a-ce-k8
FO_2020FO_StockList_updated <- droplevels( FO_2020FO_StockList_1[-which(FO_2020FO_StockList_1$StockKeyLabel == "hom.27.2a4a5b6a7a-ce-k8"), ] )
#51
unique(FO_2020FO_StockList_updated$StockKeyLabel)
#12

# Stocks not showing up in SAG
setdiff(FO_2020FO_StockList_updated$StockKeyLabel,clean_sag$StockKeyLabel)

#""

#check
setdiff(clean_sag$StockKeyLabel, FO_2020FO_StockList_updated$StockKeyLabel)
#46

unique(clean_status$StockKeyLabel)

setdiff(FO_2020FO_StockList_updated$StockKeyLabel,clean_status$StockKeyLabel)
#[1] ""



## filter clean sag and clean status for the new list of stocks
clean_sag <- clean_sag %>% filter(StockKeyLabel %in% FO_2020FO_StockList_updated$StockKeyLabel)
unique(clean_sag$StockKeyLabel)
# [1] "ghl.27.561214"        "aru.27.5b6a"          "lin.27.5b"           
# [4] "usk.27.3a45b6a7-912b" "her.27.1-24a514a"     "whb.27.1-91214"      
# [7] "mac.27.nea"           "cod.27.5b1"           "cod.27.5b2"          
# [10] "had.27.5b"            "pok.27.5b"            "bli.27.5b67"    
clean_status <- clean_status %>% filter(StockKeyLabel %in% FO_2020FO_StockList_updated$StockKeyLabel)
unique(clean_status$StockKeyLabel)
# [1] "aru.27.5b6a"          "bli.27.5b67"          "cod.27.5b1"          
# [4] "cod.27.5b2"           "ghl.27.561214"        "had.27.5b"           
# [7] "her.27.1-24a514a"     "lin.27.5b"            "mac.27.nea"          
# [10] "pok.27.5b"            "usk.27.3a45b6a7-912b" "whb.27.1-91214"    

## not sure if I need to run this
# sag_refpts <- sag_refpts %>% filter(StockKeyLabel %in% FO_2020FO_StockList_updated$StockKeyLabel)
# unique(sag_refpts$StockKeyLabel)


write.taf(clean_sag, dir = "data")
write.taf(clean_status, dir = "data", quote = TRUE)

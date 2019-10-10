#2018 Boat Visitation Cleaning Script
## The purpose of this script it to take the boat visitation data from Matt and to make it useful for analyses
##There will be 2 final dataframes, 1 per year, of this data with all of the sites in it
library(tidyr)
library(dplyr)

#Reading in the raw data
BV32<- read.csv("Raw_Data/2018_Vessel_Detections.32.csv")
BV35<- read.csv("Raw_Data/2018_Vessel_Detections.35.csv")
BV40<- read.csv("Raw_Data/2018_Vessel_Detections.40.csv")
BV08<- read.csv("Raw_Data/2018_Vessel_Detections.8.csv")
BV05<- read.csv("Raw_Data/2018_Vessel_Detections.5.csv")

#subsetting just for total counts per day
BV32.tc <- subset(BV32, select = c("X.8", "X.9"))
BV35.tc <- subset(BV35, select = c("X.9", "X.10"))
BV40.tc <- subset(BV40, select = c("X.9", "X.10"))
BV05.tc <- subset(BV05, select = c("X.9", "X.10"))
BV08.tc <- subset(BV08, select = c("X.9", "X.10"))

#removing bottom rows (rows with NA)
BV32.tc <- BV32.tc[-c(22:2342),]
BV35.tc <- BV35.tc[-c(20:3747),]
BV40.tc <- BV40.tc[-c(21:2385),]
BV05.tc <- BV05.tc[-c(19:2112),]
BV08.tc <- BV08.tc[-c(21:4106),]

#removing top rows 
BV32.tc <- BV32.tc[-c(1:4),]
BV35.tc <- BV35.tc[-c(1:4),]
BV40.tc <- BV40.tc[-c(1:4),]
BV05.tc <- BV05.tc[-c(1:4),]
BV08.tc <- BV08.tc[-c(1:4),]


#renaming columns
names(BV32.tc) <- c("Date", "Visitations")
names(BV35.tc) <- c("Date", "Visitations")
names(BV40.tc) <- c("Date", "Visitations")
names(BV05.tc) <- c("Date", "Visitations")
names(BV08.tc) <- c("Date", "Visitations")

#Adding in column for site
BV32.tc$Site <- 32
BV35.tc$Site <- 35
BV40.tc$Site <- 40
BV08.tc$Site <- 8
BV05.tc$Site <- 5

#rbinding all dataframes into one long form dataframe
#creating a list of names
df_names <- c("BV32.tc", "BV35.tc", "BV40.tc", "BV08.tc", "BV05.tc")
df_names
lapply(df_names, get)
BV.all <- do.call(rbind, lapply(df_names, get))
str(BV.all)

#summing by site
BV.sum <- aggregate(Visitations ~ Site, data=BV.all, FUN=sum)

#saving dataframes
save(BV.all, file="Raw_Data/BV.all.Rdata")
save(BV.sum, file="Raw_Data/BV.sum.Rdata")

#2017-2018 SPL and ACI Cleaning script
##The purpose of this script is to reorganize the data into more manageable dataframes
##There will be 6 dataframes per year, 3 for ACI and 3 for SPL
    #each dataframe will contain a different frequency: BB, HF, MF
library(tidyr)
library(dplyr)


#Reading in all raw data

#2017 ACI/SPL data
s32.17<- read.csv("Raw_Data/SPL.ACI_2017_MP_32.csv")
s35.17<- read.csv("Raw_Data/SPL.ACI_2017_MP_35.csv")
s8.17<- read.csv("Raw_Data/SPL.ACI_2017_MP_8.csv")
s5.17<- read.csv("Raw_Data/SPL.ACI_2017_MP_5.csv")
s40.17<- read.csv("Raw_Data/SPL.ACI_2017_MP_40.csv")


#2018 ACI/SPL data
s32.18<- read.csv("Raw_Data/SPL.ACI_2018_MP_32.csv")
s35.18<- read.csv("Raw_Data/SPL.ACI_2018_MP_35.csv")
s8.18<- read.csv("Raw_Data/SPL.ACI_2018_MP_8.csv")
s5.18<- read.csv("Raw_Data/SPL.ACI_2018_MP_5.csv")
s40.18<- read.csv("Raw_Data/SPL.ACI_2018_MP_40.csv")


#### Adjustments to time and date columns ####
#Renaming first column in the dataframe to time
names(s32.17)[1] <- "Time"
names(s35.17)[1] <- "Time"
names(s8.17)[1] <- "Time"
names(s5.17)[1] <- "Time"
names(s40.17)[1] <- "Time"

#Renaming first column in the dataframe to time
names(s32.18)[1] <- "Time"
names(s35.18)[1] <- "Time"
names(s8.18)[1] <- "Time"
names(s5.18)[1] <- "Time"
names(s40.18)[1] <- "Time"
#
#
#seperating time column into two seperate columns, date and time=
s32.17 <- s32.17 %>% separate(Time, into = c("Date", "Time"), sep = 6)
s35.17 <- s35.17 %>% separate(Time, into = c("Date", "Time"), sep = 6)
s8.17 <- s8.17 %>% separate(Time, into = c("Date", "Time"), sep = 6)
s5.17 <- s5.17 %>% separate(Time, into = c("Date", "Time"), sep = 6)
s40.17 <- s40.17 %>% separate(Time, into = c("Date", "Time"), sep = 6)


s32.18 <- s32.18 %>% separate(Time, into = c("Date", "Time"), sep = 6)
s35.18 <- s35.18 %>% separate(Time, into = c("Date", "Time"), sep = 6)
s8.18 <- s8.18 %>% separate(Time, into = c("Date", "Time"), sep = 6)
s5.18 <- s5.18 %>% separate(Time, into = c("Date", "Time"), sep = 6)
s40.18 <- s40.18 %>% separate(Time, into = c("Date", "Time"), sep = 6)
#
#
#seperating date column into year and month columns
s32.17 <- s32.17 %>% separate(Date, into = c("Year", "Month"), sep = 2)
s35.17 <- s35.17 %>% separate(Date, into = c("Year", "Month"), sep = 2)
s8.17 <- s8.17 %>% separate(Date, into = c("Year", "Month"), sep = 2)
s5.17 <- s5.17 %>% separate(Date, into = c("Year", "Month"), sep = 2)
s40.17 <- s40.17 %>% separate(Date, into = c("Year", "Month"), sep = 2)

s32.18 <- s32.18 %>% separate(Date, into = c("Year", "Month"), sep = 2)
s35.18 <- s35.18 %>% separate(Date, into = c("Year", "Month"), sep = 2)
s8.18 <- s8.18 %>% separate(Date, into = c("Year", "Month"), sep = 2)
s5.18 <- s5.18 %>% separate(Date, into = c("Year", "Month"), sep = 2)
s40.18 <- s40.18 %>% separate(Date, into = c("Year", "Month"), sep = 2)
#
#
#separating month column into month and day columns
s32.17 <- s32.17 %>% separate(Month, into = c("Month", "Day"), sep = 2)
s35.17 <- s35.17 %>% separate(Month, into = c("Month", "Day"), sep = 2)
s8.17 <- s8.17 %>% separate(Month, into = c("Month", "Day"), sep = 2)
s5.17 <- s5.17 %>% separate(Month, into = c("Month", "Day"), sep = 2)
s40.17 <- s40.17 %>% separate(Month, into = c("Month", "Day"), sep = 2)

s32.18 <- s32.18 %>% separate(Month, into = c("Month", "Day"), sep = 2)
s35.18 <- s35.18 %>% separate(Month, into = c("Month", "Day"), sep = 2)
s5.18 <- s5.18 %>% separate(Month, into = c("Month", "Day"), sep = 2)
s8.18 <- s8.18 %>% separate(Month, into = c("Month", "Day"), sep = 2)
s40.18 <- s40.18 %>% separate(Month, into = c("Month", "Day"), sep = 2)
#
#
#seperating time into hours and minutes
s32.17 <- s32.17 %>% separate(Time, into = c("Hour", "Minute"), sep = 2)
s35.17 <- s35.17 %>% separate(Time, into = c("Hour", "Minute"), sep = 2)
s5.17 <- s5.17 %>% separate(Time, into = c("Hour", "Minute"), sep = 2)
s8.17 <- s8.17 %>% separate(Time, into = c("Hour", "Minute"), sep = 2)
s40.17 <- s40.17 %>% separate(Time, into = c("Hour", "Minute"), sep = 2)

s32.18 <- s32.18 %>% separate(Time, into = c("Hour", "Minute"), sep = 2)
s35.18 <- s35.18 %>% separate(Time, into = c("Hour", "Minute"), sep = 2)
s40.18 <- s40.18 %>% separate(Time, into = c("Hour", "Minute"), sep = 2)
s8.18 <- s8.18 %>% separate(Time, into = c("Hour", "Minute"), sep = 2)
s5.18 <- s5.18 %>% separate(Time, into = c("Hour", "Minute"), sep = 2)
#
#
#seperating minutes into minutes and seconds
s32.17 <- s32.17 %>% separate(Minute, into = c("Minute", "Seconds"), sep = 2)
s35.17 <- s35.17 %>% separate(Minute, into = c("Minute", "Seconds"), sep = 2)
s40.17 <- s40.17 %>% separate(Minute, into = c("Minute", "Seconds"), sep = 2)
s5.17 <- s5.17 %>% separate(Minute, into = c("Minute", "Seconds"), sep = 2)
s8.17 <- s8.17 %>% separate(Minute, into = c("Minute", "Seconds"), sep = 2)

s32.18 <- s32.18 %>% separate(Minute, into = c("Minute", "Seconds"), sep = 2)
s35.18 <- s35.18 %>% separate(Minute, into = c("Minute", "Seconds"), sep = 2)
s40.18 <- s40.18 %>% separate(Minute, into = c("Minute", "Seconds"), sep = 2)
s5.18 <- s5.18 %>% separate(Minute, into = c("Minute", "Seconds"), sep = 2)
s8.18 <- s8.18 %>% separate(Minute, into = c("Minute", "Seconds"), sep = 2)
#
#
#creating a column that combines hours and minutes as I want them
s32.17$Time <- paste(s32.17$Hour,s32.17$Minute, sep= ":")
s35.17$Time <- paste(s35.17$Hour,s35.17$Minute, sep= ":")
s40.17$Time <- paste(s40.17$Hour,s40.17$Minute, sep= ":")
s5.17$Time <- paste(s5.17$Hour,s5.17$Minute, sep= ":")
s8.17$Time <- paste(s8.17$Hour,s8.17$Minute, sep= ":")

s32.18$Time <- paste(s32.18$Hour,s32.18$Minute, sep= ":")
s35.18$Time <- paste(s35.18$Hour,s35.18$Minute, sep= ":")
s40.18$Time <- paste(s40.18$Hour,s40.18$Minute, sep= ":")
s5.18$Time <- paste(s5.18$Hour,s5.18$Minute, sep= ":")
s8.18$Time <- paste(s8.18$Hour,s8.18$Minute, sep= ":")
#
#
#creating a column combining month and day
s32.17$Date <- paste(s32.17$Day,s32.17$Month, sep= "-")
s35.17$Date <- paste(s35.17$Day,s35.17$Month, sep= "-")
s40.17$Date <- paste(s40.17$Day,s40.17$Month, sep= "-")
s8.17$Date <- paste(s8.17$Day,s8.17$Month, sep= "-")
s5.17$Date <- paste(s5.17$Day,s5.17$Month, sep= "-")

s32.18$Date <- paste(s32.18$Day,s32.18$Month, sep= "-")
s35.18$Date <- paste(s35.18$Day,s35.18$Month, sep= "-")
s40.18$Date <- paste(s40.18$Day,s40.18$Month, sep= "-")
s8.18$Date <- paste(s8.18$Day,s8.18$Month, sep= "-")
s5.18$Date <- paste(s5.18$Day,s5.18$Month, sep= "-")
#
#
#removing useless columns
# note - I now lose the info that all recordings started at roughly 2 sec of the minute
s32.17 <- subset(s32.17, select = -c(Month, Day, Hour, Minute, Seconds))
s35.17 <- subset(s35.17, select = -c(Month, Day, Hour, Minute, Seconds))
s40.17 <- subset(s40.17, select = -c(Month, Day, Hour, Minute, Seconds))
s8.17 <- subset(s8.17, select = -c(Month, Day, Hour, Minute, Seconds))
s5.17 <- subset(s5.17, select = -c(Month, Day, Hour, Minute, Seconds))

s32.18 <- subset(s32.18, select = -c(Month, Day, Hour, Minute, Seconds))
s35.18 <- subset(s35.18, select = -c(Month, Day, Hour, Minute, Seconds))
s40.18 <- subset(s40.18, select = -c(Month, Day, Hour, Minute, Seconds))
s8.18 <- subset(s8.18, select = -c(Month, Day, Hour, Minute, Seconds))
s5.18 <- subset(s5.18, select = -c(Month, Day, Hour, Minute, Seconds))




#### Merging Columns into larger ACI and SPL Dataframes for all sites ####

## Broadband ACI ####
#pulling columns before merge
ACI_BB_32 <- s32.17 %>% select(ACI_BB, Date, Time)
ACI_BB_35 <- s35.17 %>% select(ACI_BB, Date, Time)
ACI_BB_40 <- s40.17 %>% select(ACI_BB, Date, Time)
ACI_BB_5 <- s5.17 %>% select(ACI_BB, Date, Time)
ACI_BB_8 <- s8.17 %>% select(ACI_BB, Date, Time)

#Merging dataframes matching on date and time
ACI_BB <- merge(ACI_BB_32, ACI_BB_35, by = c('Date', 'Time'))
ACI_BB <- merge(ACI_BB, ACI_BB_40, by = c('Date', 'Time'))
ACI_BB <- merge(ACI_BB, ACI_BB_8, by = c('Date', 'Time'))
ACI_BB <- merge(ACI_BB, ACI_BB_5, by = c('Date', 'Time'))

#renaming columns
names(ACI_BB) <- c("Date", "Time", "32", "35", "40", "8", "5")

ACI_BB17 <- ACI_BB

#2018
#pulling columns before merge
ACI_BB_32 <- s32.18 %>% select(ACI_BB, Date, Time)
ACI_BB_35 <- s35.18 %>% select(ACI_BB, Date, Time)
ACI_BB_40 <- s40.18 %>% select(ACI_BB, Date, Time)
ACI_BB_5 <- s5.18 %>% select(ACI_BB, Date, Time)
ACI_BB_8 <- s8.18 %>% select(ACI_BB, Date, Time)

#Merging dataframes matching on date and time
ACI_BB <- merge(ACI_BB_32, ACI_BB_35, by = c('Date', 'Time'))
ACI_BB <- merge(ACI_BB, ACI_BB_40, by = c('Date', 'Time'))
ACI_BB <- merge(ACI_BB, ACI_BB_8, by = c('Date', 'Time'))
ACI_BB <- merge(ACI_BB, ACI_BB_5, by = c('Date', 'Time'))

ACI_BB18 <- ACI_BB

#renaming columns
names(ACI_BB18) <- c("Date", "Time", "32", "35", "40", "8", "5")

## HF ACI ####
#pulling columns before merge
ACI_HF_32 <- s32.17 %>% select(ACI_HF, Date, Time)
ACI_HF_35 <- s35.17 %>% select(ACI_HF, Date, Time)
ACI_HF_40 <- s40.17 %>% select(ACI_HF, Date, Time)
ACI_HF_5 <- s5.17 %>% select(ACI_HF, Date, Time)
ACI_HF_8 <- s8.17 %>% select(ACI_HF, Date, Time)

#Merging dataframes matching on date and time
ACI_HF <- merge(ACI_HF_32, ACI_HF_35, by = c('Date', 'Time'))
ACI_HF <- merge(ACI_HF, ACI_HF_40, by = c('Date', 'Time'))
ACI_HF <- merge(ACI_HF, ACI_HF_8, by = c('Date', 'Time'))
ACI_HF <- merge(ACI_HF, ACI_HF_5, by = c('Date', 'Time'))

#renaming columns
names(ACI_HF) <- c("Date", "Time", "32", "35", "40", "8", "5")

ACI_HF17 <- ACI_HF

#2018
#pulling columns before merge
ACI_HF_32 <- s32.18 %>% select(ACI_HF, Date, Time)
ACI_HF_35 <- s35.18 %>% select(ACI_HF, Date, Time)
ACI_HF_40 <- s40.18 %>% select(ACI_HF, Date, Time)
ACI_HF_5 <- s5.18 %>% select(ACI_HF, Date, Time)
ACI_HF_8 <- s8.18 %>% select(ACI_HF, Date, Time)

#Merging dataframes matching on date and time
ACI_HF <- merge(ACI_HF_32, ACI_HF_35, by = c('Date', 'Time'))
ACI_HF <- merge(ACI_HF, ACI_HF_40, by = c('Date', 'Time'))
ACI_HF <- merge(ACI_HF, ACI_HF_8, by = c('Date', 'Time'))
ACI_HF <- merge(ACI_HF, ACI_HF_5, by = c('Date', 'Time'))

#renaming columns
names(ACI_HF) <- c("Date", "Time", "32", "35", "40", "8", "5")

ACI_HF18 <- ACI_HF

## MF ACI ####
#pulling columns before merge
ACI_MF_32 <- s32.17 %>% select(ACI_Midrange, Date, Time)
ACI_MF_35 <- s35.17 %>% select(ACI_Midrange, Date, Time)
ACI_MF_40 <- s40.17 %>% select(ACI_Midrange, Date, Time)
ACI_MF_5 <- s5.17 %>% select(ACI_Midrange, Date, Time)
ACI_MF_8 <- s8.17 %>% select(ACI_Midrange, Date, Time)

#Merging dataframes matching on date and time
ACI_MF <- merge(ACI_MF_32, ACI_MF_35, by = c('Date', 'Time'))
ACI_MF <- merge(ACI_MF, ACI_MF_40, by = c('Date', 'Time'))
ACI_MF <- merge(ACI_MF, ACI_MF_8, by = c('Date', 'Time'))
ACI_MF <- merge(ACI_MF, ACI_MF_5, by = c('Date', 'Time'))

#renaming columns
names(ACI_MF) <- c("Date", "Time", "32", "35", "40", "8", "5")

ACI_MF17 <- ACI_MF

#2018
#pulling columns before merge
ACI_MF_32 <- s32.18 %>% select(ACI_Midrange, Date, Time)
ACI_MF_35 <- s35.18 %>% select(ACI_Midrange, Date, Time)
ACI_MF_40 <- s40.18 %>% select(ACI_Midrange, Date, Time)
ACI_MF_5 <- s5.18 %>% select(ACI_Midrange, Date, Time)
ACI_MF_8 <- s8.18 %>% select(ACI_Midrange, Date, Time)

#Merging dataframes matching on date and time
ACI_MF <- merge(ACI_MF_32, ACI_MF_35, by = c('Date', 'Time'))
ACI_MF <- merge(ACI_MF, ACI_MF_40, by = c('Date', 'Time'))
ACI_MF <- merge(ACI_MF, ACI_MF_8, by = c('Date', 'Time'))
ACI_MF <- merge(ACI_MF, ACI_MF_5, by = c('Date', 'Time'))

#renaming columns
names(ACI_MF) <- c("Date", "Time", "32", "35", "40", "8", "5")

ACI_MF18 <- ACI_MF


## Broadband SPL #####
#pulling columns before merge
SPL_BB_32 <- s32.17 %>% select(SPL_BB, Date, Time)
SPL_BB_35 <- s35.17 %>% select(SPL_BB, Date, Time)
SPL_BB_40 <- s40.17 %>% select(SPL_BB, Date, Time)
SPL_BB_5 <- s5.17 %>% select(SPL_BB, Date, Time)
SPL_BB_8 <- s8.17 %>% select(SPL_BB, Date, Time)

#Merging dataframes matching on date and time
SPL_BB <- merge(SPL_BB_32, SPL_BB_35, by = c('Date', 'Time'))
SPL_BB <- merge(SPL_BB, SPL_BB_40, by = c('Date', 'Time'))
SPL_BB <- merge(SPL_BB, SPL_BB_8, by = c('Date', 'Time'))
SPL_BB <- merge(SPL_BB, SPL_BB_5, by = c('Date', 'Time'))

#renaming columns
names(SPL_BB) <- c("Date", "Time", "32", "35", "40", "8", "5")

SPL_BB17 <- SPL_BB

#2018
#pulling columns before merge
SPL_BB_32 <- s32.18 %>% select(SPL_BB, Date, Time)
SPL_BB_35 <- s35.18 %>% select(SPL_BB, Date, Time)
SPL_BB_40 <- s40.18 %>% select(SPL_BB, Date, Time)
SPL_BB_5 <- s5.18 %>% select(SPL_BB, Date, Time)
SPL_BB_8 <- s8.18 %>% select(SPL_BB, Date, Time)

#Merging dataframes matching on date and time
SPL_BB <- merge(SPL_BB_32, SPL_BB_35, by = c('Date', 'Time'))
SPL_BB <- merge(SPL_BB, SPL_BB_40, by = c('Date', 'Time'))
SPL_BB <- merge(SPL_BB, SPL_BB_8, by = c('Date', 'Time'))
SPL_BB <- merge(SPL_BB, SPL_BB_5, by = c('Date', 'Time'))

#renaming columns
names(SPL_BB) <- c("Date", "Time", "32", "35", "40", "8", "5")

SPL_BB18 <- SPL_BB

## HF SPL ####
#pulling columns before merge
SPL_HF_32 <- s32.17 %>% select(SPL_HF, Date, Time)
SPL_HF_35 <- s35.17 %>% select(SPL_HF, Date, Time)
SPL_HF_40 <- s40.17 %>% select(SPL_HF, Date, Time)
SPL_HF_5 <- s5.17 %>% select(SPL_HF, Date, Time)
SPL_HF_8 <- s8.17 %>% select(SPL_HF, Date, Time)

#Merging dataframes matching on date and time
SPL_HF <- merge(SPL_HF_32, SPL_HF_35, by = c('Date', 'Time'))
SPL_HF <- merge(SPL_HF, SPL_HF_40, by = c('Date', 'Time'))
SPL_HF <- merge(SPL_HF, SPL_HF_8, by = c('Date', 'Time'))
SPL_HF <- merge(SPL_HF, SPL_HF_5, by = c('Date', 'Time'))

#renaming columns
names(SPL_HF) <- c("Date", "Time", "32", "35", "40", "8", "5")

SPL_HF17 <- SPL_HF

#2018
#pulling columns before merge
SPL_HF_32 <- s32.18 %>% select(SPL_HF, Date, Time)
SPL_HF_35 <- s35.18 %>% select(SPL_HF, Date, Time)
SPL_HF_40 <- s40.18 %>% select(SPL_HF, Date, Time)
SPL_HF_5 <- s5.18 %>% select(SPL_HF, Date, Time)
SPL_HF_8 <- s8.18 %>% select(SPL_HF, Date, Time)

#Merging dataframes matching on date and time
SPL_HF <- merge(SPL_HF_32, SPL_HF_35, by = c('Date', 'Time'))
SPL_HF <- merge(SPL_HF, SPL_HF_40, by = c('Date', 'Time'))
SPL_HF <- merge(SPL_HF, SPL_HF_8, by = c('Date', 'Time'))
SPL_HF <- merge(SPL_HF, SPL_HF_5, by = c('Date', 'Time'))

#renaming columns
names(SPL_HF) <- c("Date", "Time", "32", "35", "40", "8", "5")

SPL_HF18 <- SPL_HF



## MF SPL ####
#pulling columns before merge
SPL_MF_32 <- s32.17 %>% select(SPL_Midrange, Date, Time)
SPL_MF_35 <- s35.17 %>% select(SPL_Midrange, Date, Time)
SPL_MF_40 <- s40.17 %>% select(SPL_Midrange, Date, Time)
SPL_MF_5 <- s5.17 %>% select(SPL_Midrange, Date, Time)
SPL_MF_8 <- s8.17 %>% select(SPL_Midrange, Date, Time)

#Merging dataframes matching on date and time
SPL_MF <- merge(SPL_MF_32, SPL_MF_35, by = c('Date', 'Time'))
SPL_MF <- merge(SPL_MF, SPL_MF_40, by = c('Date', 'Time'))
SPL_MF <- merge(SPL_MF, SPL_MF_8, by = c('Date', 'Time'))
SPL_MF <- merge(SPL_MF, SPL_MF_5, by = c('Date', 'Time'))

#renaming columns
names(SPL_MF) <- c("Date", "Time", "32", "35", "40", "8", "5")

SPL_MF17 <- SPL_MF

#2018
#pulling columns before merge
SPL_MF_32 <- s32.18 %>% select(SPL_Midrange, Date, Time)
SPL_MF_35 <- s35.18 %>% select(SPL_Midrange, Date, Time)
SPL_MF_40 <- s40.18 %>% select(SPL_Midrange, Date, Time)
SPL_MF_5 <- s5.18 %>% select(SPL_Midrange, Date, Time)
SPL_MF_8 <- s8.18 %>% select(SPL_Midrange, Date, Time)

#Merging dataframes matching on date and time
SPL_MF <- merge(SPL_MF_32, SPL_MF_35, by = c('Date', 'Time'))
SPL_MF <- merge(SPL_MF, SPL_MF_40, by = c('Date', 'Time'))
SPL_MF <- merge(SPL_MF, SPL_MF_8, by = c('Date', 'Time'))
SPL_MF <- merge(SPL_MF, SPL_MF_5, by = c('Date', 'Time'))

#renaming columns
names(SPL_MF) <- c("Date", "Time", "32", "35", "40", "8", "5")

SPL_MF18 <- SPL_MF


#### Adding one column for year to each of my new dataframes ####
ACI_BB17$Year <- "2017"
ACI_HF17$Year <- "2017"
ACI_MF17$Year <- "2017"

SPL_BB17$Year <- "2017"
SPL_HF17$Year <- "2017"
SPL_MF17$Year <- "2017"

#2018

ACI_BB18$Year <- "2018"
ACI_HF18$Year <- "2018"
ACI_MF18$Year <- "2018"

SPL_BB18$Year <- "2018"
SPL_HF18$Year <- "2018"
SPL_MF18$Year <- "2018"


#### Turning each of my new dataframes into an .Rdata file ####
save(ACI_BB17, file="Raw_Data/ACI_BB17.Rdata")
save(ACI_HF17, file="Raw_Data/ACI_HF17.Rdata")
save(ACI_MF17, file="Raw_Data/ACI_MF17.Rdata")

save(SPL_BB17, file="Raw_Data/SPL_BB17.Rdata")
save(SPL_HF17, file="Raw_Data/SPL_HF17.Rdata")
save(SPL_MF17, file="Raw_Data/SPL_MF17.Rdata")

#2018
save(ACI_BB18, file="Raw_Data/ACI_BB18.Rdata")
save(ACI_HF18, file="Raw_Data/ACI_HF18.Rdata")
save(ACI_MF18, file="Raw_Data/ACI_MF18.Rdata")

save(SPL_BB18, file="Raw_Data/SPL_BB18.Rdata")
save(SPL_HF18, file="Raw_Data/SPL_HF18.Rdata")
save(SPL_MF18, file="Raw_Data/SPL_MF18.Rdata")

#writing them as .csv files
#write.csv(ACI_BB17, file = "Raw_Data/ACI_BB17.csv")

#### Averaging each site by hour ####
#renaming my columns
names(ACI_BB17) <- c("Date", "T", "s32", "s35", "s40", "s8", "s5", "Year")
names(ACI_BB18) <- c("Date", "T", "s32", "s35", "s40", "s8", "s5", "Year")
names(ACI_HF17) <- c("Date", "T", "s32", "s35", "s40", "s8", "s5", "Year")
names(ACI_HF18) <- c("Date", "T", "s32", "s35", "s40", "s8", "s5", "Year")
names(ACI_MF17) <- c("Date", "T", "s32", "s35", "s40", "s8", "s5", "Year")
names(ACI_MF18) <- c("Date", "T", "s32", "s35", "s40", "s8", "s5", "Year")

names(SPL_BB17) <- c("Date", "T", "s32", "s35", "s40", "s8", "s5", "Year")
names(SPL_BB18) <- c("Date", "T", "s32", "s35", "s40", "s8", "s5", "Year")
names(SPL_HF17) <- c("Date", "T", "s32", "s35", "s40", "s8", "s5", "Year")
names(SPL_HF18) <- c("Date", "T", "s32", "s35", "s40", "s8", "s5", "Year")
names(SPL_MF17) <- c("Date", "T", "s32", "s35", "s40", "s8", "s5", "Year")
names(SPL_MF18) <- c("Date", "T", "s32", "s35", "s40", "s8", "s5", "Year")

#seperating time back into hour and minute
ACI_BB17 <- ACI_BB17 %>% separate(T, into = c("Hour", "Minute"), sep = ":")
ACI_HF17 <- ACI_HF17 %>% separate(T, into = c("Hour", "Minute"), sep = ":")
ACI_MF17 <- ACI_MF17 %>% separate(T, into = c("Hour", "Minute"), sep = ":")

ACI_BB18 <- ACI_BB18 %>% separate(T, into = c("Hour", "Minute"), sep = ":")
ACI_HF18 <- ACI_HF18 %>% separate(T, into = c("Hour", "Minute"), sep = ":")
ACI_MF18 <- ACI_MF18 %>% separate(T, into = c("Hour", "Minute"), sep = ":")

SPL_BB17 <- SPL_BB17 %>% separate(T, into = c("Hour", "Minute"), sep = ":")
SPL_HF17 <- SPL_HF17 %>% separate(T, into = c("Hour", "Minute"), sep = ":")
SPL_MF17 <- SPL_MF17 %>% separate(T, into = c("Hour", "Minute"), sep = ":")

SPL_BB18 <- SPL_BB18 %>% separate(T, into = c("Hour", "Minute"), sep = ":")
SPL_HF18 <- SPL_HF18 %>% separate(T, into = c("Hour", "Minute"), sep = ":")
SPL_MF18 <- SPL_MF18 %>% separate(T, into = c("Hour", "Minute"), sep = ":")

#aggregating by averaging all days by the hour
ACI_BB17.hr <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Hour, data=ACI_BB17, FUN=mean)
ACI_HF17.hr <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Hour, data=ACI_HF17, FUN=mean)
ACI_MF17.hr <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Hour, data=ACI_MF17, FUN=mean)

ACI_BB18.hr <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Hour, data=ACI_BB17, FUN=mean)
ACI_HF18.hr <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Hour, data=ACI_HF17, FUN=mean)
ACI_MF18.hr <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Hour, data=ACI_MF17, FUN=mean)

SPL_BB17.hr <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Hour, data=ACI_BB17, FUN=mean)
SPL_HF17.hr <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Hour, data=ACI_HF17, FUN=mean)
SPL_MF17.hr <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Hour, data=ACI_MF17, FUN=mean)

SPL_BB18.hr <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Hour, data=ACI_BB17, FUN=mean)
SPL_HF18.hr <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Hour, data=ACI_HF17, FUN=mean)
SPL_MF18.hr <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Hour, data=ACI_MF17, FUN=mean)

#saving the aggregated files
save(ACI_BB17.hr, file="Raw_Data/ACI_BB17hr.Rdata")
save(ACI_HF17.hr, file="Raw_Data/ACI_HF17hr.Rdata")
save(ACI_MF17.hr, file="Raw_Data/ACI_MF17hr.Rdata")

save(SPL_BB17.hr, file="Raw_Data/SPL_BB17hr.Rdata")
save(SPL_HF17.hr, file="Raw_Data/SPL_HF17hr.Rdata")
save(SPL_MF17.hr, file="Raw_Data/SPL_MF17hr.Rdata")

#2018
save(ACI_BB18.hr, file="Raw_Data/ACI_BB18hr.Rdata")
save(ACI_HF18.hr, file="Raw_Data/ACI_HF18hr.Rdata")
save(ACI_MF18.hr, file="Raw_Data/ACI_MF18hr.Rdata")

save(SPL_BB18.hr, file="Raw_Data/SPL_BB18hr.Rdata")
save(SPL_HF18.hr, file="Raw_Data/SPL_HF18hr.Rdata")
save(SPL_MF18.hr, file="Raw_Data/SPL_MF18hr.Rdata")

#### Averaging each site by day ####
#aggregating by averaging all days by the hour
ACI_BB17.day <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Date, data=ACI_BB17, FUN=mean)
ACI_HF17.day <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Date, data=ACI_HF17, FUN=mean)
ACI_MF17.day <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Date, data=ACI_MF17, FUN=mean)

ACI_BB18.day <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Date, data=ACI_BB17, FUN=mean)
ACI_HF18.day <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Date, data=ACI_HF17, FUN=mean)
ACI_MF18.day <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Date, data=ACI_MF17, FUN=mean)
 
SPL_BB17.day <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Date, data=ACI_BB17, FUN=mean)
SPL_HF17.day <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Date, data=ACI_HF17, FUN=mean)
SPL_MF17.day <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Date, data=ACI_MF17, FUN=mean)
 
SPL_BB18.day <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Date, data=ACI_BB17, FUN=mean)
SPL_HF18.day <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Date, data=ACI_HF17, FUN=mean)
SPL_MF18.day <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Date, data=ACI_MF17, FUN=mean)

#saving the aggregated files
save(ACI_BB17.day, file="Raw_Data/ACI_BB17day.Rdata")
save(ACI_HF17.day, file="Raw_Data/ACI_HF17day.Rdata")
save(ACI_MF17.day, file="Raw_Data/ACI_MF17day.Rdata")

save(SPL_BB17.day, file="Raw_Data/SPL_BB17day.Rdata")
save(SPL_HF17.day, file="Raw_Data/SPL_HF17day.Rdata")
save(SPL_MF17.day, file="Raw_Data/SPL_MF17day.Rdata")

#2018
save(ACI_BB18.day, file="Raw_Data/ACI_BB18day.Rdata")
save(ACI_HF18.day, file="Raw_Data/ACI_HF18day.Rdata")
save(ACI_MF18.day, file="Raw_Data/ACI_MF18day.Rdata")
 
save(SPL_BB18.day, file="Raw_Data/SPL_BB18day.Rdata")
save(SPL_HF18.day, file="Raw_Data/SPL_HF18day.Rdata")
save(SPL_MF18.day, file="Raw_Data/SPL_MF18day.Rdata")
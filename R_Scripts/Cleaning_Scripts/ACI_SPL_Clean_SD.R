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

#saving all of these dataframes
#save(s32.17, file="Raw_Data/s32.17df.Rdata")
#save(s35.17, file="Raw_Data/s35.17df.Rdata")
#save(s40.17, file="Raw_Data/s40.17df.Rdata")
#save(s8.17, file="Raw_Data/s8.17df.Rdata")
#save(s5.17, file="Raw_Data/s5.17df.Rdata")

#save(s32.18, file="Raw_Data/s32.18df.Rdata")
#save(s35.18, file="Raw_Data/s35.18df.Rdata")
#save(s40.18, file="Raw_Data/s40.18df.Rdata")
#save(s8.18, file="Raw_Data/s8.18df.Rdata")
#save(s5.18, file="Raw_Data/s5.18df.Rdata")


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

#renaming columns
names(SPL_BB17) <- c("Date", "Time", "s32", "s35", "s40", "s8", "s5")

#splitting the wide dataframe into several dataframes so that I can make a long form dataframe
SPL_BB32 <- select(SPL_BB17, Date, Time, s32)
SPL_BB35 <- select(SPL_BB17, Date, Time, s35)
SPL_BB40 <- select(SPL_BB17, Date, Time, s40)
SPL_BB5 <- select(SPL_BB17, Date, Time, s5)
SPL_BB8 <- select(SPL_BB17, Date, Time, s8)

#adding site column to each dataframe
SPL_BB32$Site <- 32
SPL_BB35$Site <- 35
SPL_BB40$Site <- 40
SPL_BB5$Site <- 5
SPL_BB8$Site <- 8

#matching column names for all
names(SPL_BB32) <- c("Date", "Time", "SPL_BB", "Site")
names(SPL_BB35) <- c("Date", "Time", "SPL_BB", "Site")
names(SPL_BB40) <- c("Date", "Time", "SPL_BB", "Site")
names(SPL_BB5) <- c("Date", "Time", "SPL_BB", "Site")
names(SPL_BB8) <- c("Date", "Time", "SPL_BB", "Site")

#rbinding everything
SPLBB17.long <- rbind(SPL_BB32, SPL_BB35, SPL_BB40, SPL_BB5, SPL_BB8)

#re-adding year
SPLBB17.long$Date <- paste0(SPLBB17.long$Date, "-2017")

#Creating datetime object
SPLBB17.long$datetime <- as.POSIXct(paste(SPLBB17.long$Date, SPLBB17.long$Time), format = "%d-%m-%Y %H:%M")

#re-adding year
SPL_BB17$Date <- paste0(SPL_BB17$Date, "-2017")

#Creating datetime object
SPL_BB17$datetime <- as.POSIXct(paste(SPL_BB17$Date, SPL_BB17$Time), format = "%d-%m-%Y %H:%M")



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


#renaming columns
names(SPL_BB18) <- c("Date", "Time", "s32", "s35", "s40", "s8", "s5")

#splitting the wide dataframe into several dataframes so that I can make a long form dataframe
SPL_BB32 <- select(SPL_BB18, Date, Time, s32)
SPL_BB35 <- select(SPL_BB18, Date, Time, s35)
SPL_BB40 <- select(SPL_BB18, Date, Time, s40)
SPL_BB5 <- select(SPL_BB18, Date, Time, s5)
SPL_BB8 <- select(SPL_BB18, Date, Time, s8)

#adding site column to each dataframe
SPL_BB32$Site <- 32
SPL_BB35$Site <- 35
SPL_BB40$Site <- 40
SPL_BB5$Site <- 5
SPL_BB8$Site <- 8

#matching column names for all
names(SPL_BB32) <- c("Date", "Time", "SPL_BB", "Site")
names(SPL_BB35) <- c("Date", "Time", "SPL_BB", "Site")
names(SPL_BB40) <- c("Date", "Time", "SPL_BB", "Site")
names(SPL_BB5) <- c("Date", "Time", "SPL_BB", "Site")
names(SPL_BB8) <- c("Date", "Time", "SPL_BB", "Site")

#rbinding everything
SPLBB18.long <- rbind(SPL_BB32, SPL_BB35, SPL_BB40, SPL_BB5, SPL_BB8)

#re-adding year
SPLBB18.long$Date <- paste0(SPLBB18.long$Date, "-2018")

#Creating datetime object
SPLBB18.long$datetime <- as.POSIXct(paste(SPLBB18.long$Date, SPLBB18.long$Time), format = "%d-%m-%Y %H:%M")

#re-adding year and creating datetime column in SPL_BB18

#re-adding year
SPL_BB18$Date <- paste0(SPL_BB18$Date, "-2018")

#Creating datetime object
SPL_BB18$datetime <- as.POSIXct(paste(SPL_BB18$Date, SPL_BB18$Time), format = "%d-%m-%Y %H:%M")



save(SPL_BB17, file = "Raw_Data/SPL_BB17.Rdata")
save(SPL_BB18, file = "Raw_Data/SPL_BB18.Rdata")

save(SPLBB17.long, file = "Raw_Data/SPLBB17long.Rdata")
save(SPLBB18.long, file = "Raw_Data/SPLBB18long.Rdata")

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

#renaming columns
names(SPL_HF17) <- c("Date", "Time", "s32", "s35", "s40", "s8", "s5")

#splitting the wide dataframe into several dataframes so that I can make a long form dataframe
SPL_HF32 <- select(SPL_HF17, Date, Time, s32)
SPL_HF35 <- select(SPL_HF17, Date, Time, s35)
SPL_HF40 <- select(SPL_HF17, Date, Time, s40)
SPL_HF5 <- select(SPL_HF17, Date, Time, s5)
SPL_HF8 <- select(SPL_HF17, Date, Time, s8)

#adding site column to each dataframe
SPL_HF32$Site <- 32
SPL_HF35$Site <- 35
SPL_HF40$Site <- 40
SPL_HF5$Site <- 5
SPL_HF8$Site <- 8

#matching column names for all
names(SPL_HF32) <- c("Date", "Time", "SPL_HF", "Site")
names(SPL_HF35) <- c("Date", "Time", "SPL_HF", "Site")
names(SPL_HF40) <- c("Date", "Time", "SPL_HF", "Site")
names(SPL_HF5) <- c("Date", "Time", "SPL_HF", "Site")
names(SPL_HF8) <- c("Date", "Time", "SPL_HF", "Site")

#rbinding everything
SPLHF17.long <- rbind(SPL_HF32, SPL_HF35, SPL_HF40, SPL_HF5, SPL_HF8)

#re-adding year
SPLHF17.long$Date <- paste0(SPLHF17.long$Date, "-2017")

#Creating datetime object
SPLHF17.long$datetime <- as.POSIXct(paste(SPLHF17.long$Date, SPLHF17.long$Time), format = "%d-%m-%Y %H:%M")

#re-adding year
SPL_HF17$Date <- paste0(SPL_HF17$Date, "-2017")

#Creating datetime object
SPL_HF17$datetime <- as.POSIXct(paste(SPL_HF17$Date, SPL_HF17$Time), format = "%d-%m-%Y %H:%M")



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

#renaming columns
names(SPL_HF18) <- c("Date", "Time", "s32", "s35", "s40", "s8", "s5")

#splitting the wide dataframe into several dataframes so that I can make a long form dataframe
SPL_HF32 <- select(SPL_HF18, Date, Time, s32)
SPL_HF35 <- select(SPL_HF18, Date, Time, s35)
SPL_HF40 <- select(SPL_HF18, Date, Time, s40)
SPL_HF5 <- select(SPL_HF18, Date, Time, s5)
SPL_HF8 <- select(SPL_HF18, Date, Time, s8)

#adding site column to each dataframe
SPL_HF32$Site <- 32
SPL_HF35$Site <- 35
SPL_HF40$Site <- 40
SPL_HF5$Site <- 5
SPL_HF8$Site <- 8

#matching column names for all
names(SPL_HF32) <- c("Date", "Time", "SPL_HF", "Site")
names(SPL_HF35) <- c("Date", "Time", "SPL_HF", "Site")
names(SPL_HF40) <- c("Date", "Time", "SPL_HF", "Site")
names(SPL_HF5) <- c("Date", "Time", "SPL_HF", "Site")
names(SPL_HF8) <- c("Date", "Time", "SPL_HF", "Site")

#rbinding everything
SPLHF18.long <- rbind(SPL_HF32, SPL_HF35, SPL_HF40, SPL_HF5, SPL_HF8)

#re-adding year
SPLHF18.long$Date <- paste0(SPLHF18.long$Date, "-2018")

#Creating datetime object
SPLHF18.long$datetime <- as.POSIXct(paste(SPLHF18.long$Date, SPLHF18.long$Time), format = "%d-%m-%Y %H:%M")

#re-adding year
SPL_HF18$Date <- paste0(SPL_HF18$Date, "-2018")

#Creating datetime object
SPL_HF18$datetime <- as.POSIXct(paste(SPL_HF18$Date, SPL_HF18$Time), format = "%d-%m-%Y %H:%M")


#combining dataframes into one long dataframe
SPLHF.long <- rbind(SPLHF17.long, SPLHF18.long)


#saving dataframes
save(SPLHF17.long, file = "Raw_Data/SPLHF17long.Rdata")
save(SPLHF18.long, file = "Raw_Data/SPLHF18long.Rdata")

save(SPLHF.long, file = "Raw_Data/SPLHFlong.Rdata")
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

#renaming columns
names(SPL_MF17) <- c("Date", "Time", "s32", "s35", "s40", "s8", "s5")

#splitting the wide dataframe into several dataframes so that I can make a long form dataframe
SPL_MF32 <- select(SPL_MF17, Date, Time, s32)
SPL_MF35 <- select(SPL_MF17, Date, Time, s35)
SPL_MF40 <- select(SPL_MF17, Date, Time, s40)
SPL_MF5 <- select(SPL_MF17, Date, Time, s5)
SPL_MF8 <- select(SPL_MF17, Date, Time, s8)

#adding site column to each dataframe
SPL_MF32$Site <- 32
SPL_MF35$Site <- 35
SPL_MF40$Site <- 40
SPL_MF5$Site <- 5
SPL_MF8$Site <- 8

#matching column names for all
names(SPL_MF32) <- c("Date", "Time", "SPL_MF", "Site")
names(SPL_MF35) <- c("Date", "Time", "SPL_MF", "Site")
names(SPL_MF40) <- c("Date", "Time", "SPL_MF", "Site")
names(SPL_MF5) <- c("Date", "Time", "SPL_MF", "Site")
names(SPL_MF8) <- c("Date", "Time", "SPL_MF", "Site")

#rbinding everything
SPLMF17.long <- rbind(SPL_MF32, SPL_MF35, SPL_MF40, SPL_MF5, SPL_MF8)

#re-adding year
SPLMF17.long$Date <- paste0(SPLMF17.long$Date, "-2017")

#Creating datetime object
SPLMF17.long$datetime <- as.POSIXct(paste(SPLMF17.long$Date, SPLMF17.long$Time), format = "%d-%m-%Y %H:%M")

#re-adding year
SPL_MF17$Date <- paste0(SPL_MF17$Date, "-2017")

#Creating datetime object
SPL_MF17$datetime <- as.POSIXct(paste(SPL_MF17$Date, SPL_MF17$Time), format = "%d-%m-%Y %H:%M")



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

#renaming columns
names(SPL_MF18) <- c("Date", "Time", "s32", "s35", "s40", "s8", "s5")

#splitting the wide dataframe into several dataframes so that I can make a long form dataframe
SPL_MF32 <- select(SPL_MF18, Date, Time, s32)
SPL_MF35 <- select(SPL_MF18, Date, Time, s35)
SPL_MF40 <- select(SPL_MF18, Date, Time, s40)
SPL_MF5 <- select(SPL_MF18, Date, Time, s5)
SPL_MF8 <- select(SPL_MF18, Date, Time, s8)

#adding site column to each dataframe
SPL_MF32$Site <- 32
SPL_MF35$Site <- 35
SPL_MF40$Site <- 40
SPL_MF5$Site <- 5
SPL_MF8$Site <- 8

#matching column names for all
names(SPL_MF32) <- c("Date", "Time", "SPL_MF", "Site")
names(SPL_MF35) <- c("Date", "Time", "SPL_MF", "Site")
names(SPL_MF40) <- c("Date", "Time", "SPL_MF", "Site")
names(SPL_MF5) <- c("Date", "Time", "SPL_MF", "Site")
names(SPL_MF8) <- c("Date", "Time", "SPL_MF", "Site")

#rbinding everything
SPLMF18.long <- rbind(SPL_MF32, SPL_MF35, SPL_MF40, SPL_MF5, SPL_MF8)

#re-adding year
SPLMF18.long$Date <- paste0(SPLMF18.long$Date, "-2018")

#Creating datetime object
SPLMF18.long$datetime <- as.POSIXct(paste(SPLMF18.long$Date, SPLMF18.long$Time), format = "%d-%m-%Y %H:%M")

#re-adding year
SPL_MF18$Date <- paste0(SPL_MF18$Date, "-2018")

#Creating datetime object
SPL_MF18$datetime <- as.POSIXct(paste(SPL_MF18$Date, SPL_MF18$Time), format = "%d-%m-%Y %H:%M")

#combining dataframes into one long dataframe
SPLMF.long <- rbind(SPLMF17.long, SPLMF18.long)


#saving dataframes
save(SPLMF17.long, file = "Raw_Data/SPLMF17long.Rdata")
save(SPLMF18.long, file = "Raw_Data/SPLMF18long.Rdata")

save(SPLMF.long, file = "Raw_Data/SPLMFlong.Rdata")

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
#save(ACI_BB17, file="Raw_Data/ACI_BB17.Rdata")
#save(ACI_HF17, file="Raw_Data/ACI_HF17.Rdata")
#save(ACI_MF17, file="Raw_Data/ACI_MF17.Rdata")

#save(SPL_BB17, file="Raw_Data/SPL_BB17.Rdata")
#save(SPL_HF17, file="Raw_Data/SPL_HF17.Rdata")
#save(SPL_MF17, file="Raw_Data/SPL_MF17.Rdata")

#2018
#save(ACI_BB18, file="Raw_Data/ACI_BB18.Rdata")
#save(ACI_HF18, file="Raw_Data/ACI_HF18.Rdata")
#save(ACI_MF18, file="Raw_Data/ACI_MF18.Rdata")

#save(SPL_BB18, file="Raw_Data/SPL_BB18.Rdata")
#save(SPL_HF18, file="Raw_Data/SPL_HF18.Rdata")
#save(SPL_MF18, file="Raw_Data/SPL_MF18.Rdata")

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

ACI_BB18.hr <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Hour, data=ACI_BB18, FUN=mean)
ACI_HF18.hr <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Hour, data=ACI_HF18, FUN=mean)
ACI_MF18.hr <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Hour, data=ACI_MF18, FUN=mean)

SPL_BB17.hr <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Hour, data=SPL_BB17, FUN=mean)
SPL_HF17.hr <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Hour, data=SPL_HF17, FUN=mean)
SPL_MF17.hr <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Hour, data=SPL_MF17, FUN=mean)

SPL_BB18.hr <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Hour, data=SPL_BB18, FUN=mean)
SPL_HF18.hr <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Hour, data=SPL_HF18, FUN=mean)
SPL_MF18.hr <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Hour, data=SPL_MF18, FUN=mean)

#saving the aggregated files
#save(ACI_BB17.hr, file="Raw_Data/ACI_BB17hr.Rdata")
#save(ACI_HF17.hr, file="Raw_Data/ACI_HF17hr.Rdata")
#save(ACI_MF17.hr, file="Raw_Data/ACI_MF17hr.Rdata")

#save(SPL_BB17.hr, file="Raw_Data/SPL_BB17hr.Rdata")
#save(SPL_HF17.hr, file="Raw_Data/SPL_HF17hr.Rdata")
#save(SPL_MF17.hr, file="Raw_Data/SPL_MF17hr.Rdata")

#2018
#save(ACI_BB18.hr, file="Raw_Data/ACI_BB18hr.Rdata")
#save(ACI_HF18.hr, file="Raw_Data/ACI_HF18hr.Rdata")
#save(ACI_MF18.hr, file="Raw_Data/ACI_MF18hr.Rdata")

#save(SPL_BB18.hr, file="Raw_Data/SPL_BB18hr.Rdata")
#save(SPL_HF18.hr, file="Raw_Data/SPL_HF18hr.Rdata")
#save(SPL_MF18.hr, file="Raw_Data/SPL_MF18hr.Rdata")

#### Averaging each site by day ####
#aggregating by averaging all days by the hour
ACI_BB17.day <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Date, data=ACI_BB17, FUN=mean)
ACI_HF17.day <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Date, data=ACI_HF17, FUN=mean)
ACI_MF17.day <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Date, data=ACI_MF17, FUN=mean)

ACI_BB18.day <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Date, data=SPL_BB17, FUN=mean)
ACI_HF18.day <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Date, data=SPL_HF17, FUN=mean)
ACI_MF18.day <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Date, data=SPL_MF17, FUN=mean)
 
SPL_BB17.day <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Date, data=SPL_BB17, FUN=mean)
SPL_HF17.day <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Date, data=SPL_HF17, FUN=mean)
SPL_MF17.day <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Date, data=SPL_MF17, FUN=mean)
 
SPL_BB18.day <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Date, data=SPL_BB17, FUN=mean)
SPL_HF18.day <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Date, data=SPL_HF17, FUN=mean)
SPL_MF18.day <- aggregate(cbind(s32,s35,s40,s8,s5) ~ Date, data=SPL_MF17, FUN=mean)

#saving the aggregated files
#save(ACI_BB17.day, file="Raw_Data/ACI_BB17day.Rdata")
#save(ACI_HF17.day, file="Raw_Data/ACI_HF17day.Rdata")
#save(ACI_MF17.day, file="Raw_Data/ACI_MF17day.Rdata")

#save(SPL_BB17.day, file="Raw_Data/SPL_BB17day.Rdata")
#save(SPL_HF17.day, file="Raw_Data/SPL_HF17day.Rdata")
#save(SPL_MF17.day, file="Raw_Data/SPL_MF17day.Rdata")

#2018
#save(ACI_BB18.day, file="Raw_Data/ACI_BB18day.Rdata")
#save(ACI_HF18.day, file="Raw_Data/ACI_HF18day.Rdata")
#save(ACI_MF18.day, file="Raw_Data/ACI_MF18day.Rdata")
 
#save(SPL_BB18.day, file="Raw_Data/SPL_BB18day.Rdata")
#save(SPL_HF18.day, file="Raw_Data/SPL_HF18day.Rdata")
#save(SPL_MF18.day, file="Raw_Data/SPL_MF18day.Rdata")

## Creating a dataframe that has all sites in one row with new column seperating by sites ####


 ## ACI ##



##Broadband ##

#Seperating each dataframe into 5 seperate ones so that I can rebind them together
acibb32.17 <- select(ACI_BB17.hr, Hour, s32)
acibb35.17 <- select(ACI_BB17.hr, Hour, s35)
acibb40.17 <- select(ACI_BB17.hr, Hour, s40)
acibb5.17 <- select(ACI_BB17.hr, Hour, s5)
acibb8.17 <- select(ACI_BB17.hr, Hour, s8)

#2018
acibb32.18 <- select(ACI_BB18.hr, Hour, s32)
acibb35.18 <- select(ACI_BB18.hr, Hour, s35)
acibb40.18 <- select(ACI_BB18.hr, Hour, s40)
acibb5.18 <- select(ACI_BB18.hr, Hour, s5)
acibb8.18 <- select(ACI_BB18.hr, Hour, s8)
#adding new column for site to all dataframes
acibb32.17$Site <- 32
acibb35.17$Site <- 35
acibb40.17$Site <- 40
acibb5.17$Site <- 5
acibb8.17$Site <- 8

#2018
acibb32.18$Site <- 32
acibb35.18$Site <- 35
acibb40.18$Site <- 40
acibb5.18$Site <- 5
acibb8.18$Site <- 8

#rbinding all of the dataframes together to get one big dataframe
#renaming columns in all dataframes
names(acibb32.17) <- c("Hour", "Broadband_ACI", "Site")
names(acibb35.17) <- c("Hour", "Broadband_ACI", "Site")
names(acibb40.17) <- c("Hour", "Broadband_ACI", "Site")
names(acibb5.17) <- c("Hour", "Broadband_ACI", "Site")
names(acibb8.17) <- c("Hour", "Broadband_ACI", "Site")

#2018
names(acibb32.18) <- c("Hour", "Broadband_ACI", "Site")
names(acibb35.18) <- c("Hour", "Broadband_ACI", "Site")
names(acibb40.18) <- c("Hour", "Broadband_ACI", "Site")
names(acibb5.18) <- c("Hour", "Broadband_ACI", "Site")
names(acibb8.18) <- c("Hour", "Broadband_ACI", "Site")
#creating a list of names
df_names.17 <- c("acibb32.17", "acibb35.17", "acibb40.17", "acibb5.17", "acibb8.17")
df_names.17
#rbinding everything together
lapply(df_names.17, get)
ACI_BB17.hr.long <- do.call(rbind, lapply(df_names.17, get))
#str(ACI_BB17.hr.long)

#2018
#creating a list of names
df_names.18 <- c("acibb32.18", "acibb35.18", "acibb40.18", "acibb5.18", "acibb8.18")
df_names.18
#rbinding everything together
lapply(df_names.18, get)
ACI_BB18.hr.long <- do.call(rbind, lapply(df_names.18, get))
str(ACI_BB18.hr.long)


## HF ##


#Seperating each dataframe into 5 seperate ones so that I can rebind them together
acihf32.17 <- select(ACI_HF17.hr, Hour, s32)
acihf35.17 <- select(ACI_HF17.hr, Hour, s35)
acihf40.17 <- select(ACI_HF17.hr, Hour, s40)
acihf5.17 <- select(ACI_HF17.hr, Hour, s5)
acihf8.17 <- select(ACI_HF17.hr, Hour, s8)

#2018
acihf32.18 <- select(ACI_HF18.hr, Hour, s32)
acihf35.18 <- select(ACI_HF18.hr, Hour, s35)
acihf40.18 <- select(ACI_HF18.hr, Hour, s40)
acihf5.18 <- select(ACI_HF18.hr, Hour, s5)
acihf8.18 <- select(ACI_HF18.hr, Hour, s8)
#adding new column for site to all dataframes
acihf32.17$Site <- 32
acihf35.17$Site <- 35
acihf40.17$Site <- 40
acihf5.17$Site <- 5
acihf8.17$Site <- 8

#2018
acihf32.18$Site <- 32
acihf35.18$Site <- 35
acihf40.18$Site <- 40
acihf5.18$Site <- 5
acihf8.18$Site <- 8

#rbinding all of the dataframes together to get one big dataframe
#renaming columns in all dataframes
names(acihf32.17) <- c("Hour", "HF_ACI", "Site")
names(acihf35.17) <- c("Hour", "HF_ACI", "Site")
names(acihf40.17) <- c("Hour", "HF_ACI", "Site")
names(acihf5.17) <- c("Hour", "HF_ACI", "Site")
names(acihf8.17) <- c("Hour", "HF_ACI", "Site")

#2018
names(acihf32.18) <- c("Hour", "HF_ACI", "Site")
names(acihf35.18) <- c("Hour", "HF_ACI", "Site")
names(acihf40.18) <- c("Hour", "HF_ACI", "Site")
names(acihf5.18) <- c("Hour", "HF_ACI", "Site")
names(acihf8.18) <- c("Hour", "HF_ACI", "Site")
#creating a list of names
df_names.17 <- c("acihf32.17", "acihf35.17", "acihf40.17", "acihf5.17", "acihf8.17")
df_names.17
#rbinding everything together
lapply(df_names.17, get)
ACI_HF17.hr.long <- do.call(rbind, lapply(df_names.17, get))
str(ACI_HF17.hr.long)

#2018
#creating a list of names
df_names.18 <- c("acihf32.18", "acihf35.18", "acihf40.18", "acihf5.18", "acihf8.18")
df_names.18
#rbinding everything together
lapply(df_names.18, get)
ACI_HF18.hr.long <- do.call(rbind, lapply(df_names.18, get))
str(ACI_HF18.hr.long)


## MF ##



#Seperating each dataframe into 5 seperate ones so that I can rebind them together
acimf32.17 <- select(ACI_MF17.hr, Hour, s32)
acimf35.17 <- select(ACI_MF17.hr, Hour, s35)
acimf40.17 <- select(ACI_MF17.hr, Hour, s40)
acimf5.17 <- select(ACI_MF17.hr, Hour, s5)
acimf8.17 <- select(ACI_MF17.hr, Hour, s8)

#2018
acimf32.18 <- select(ACI_MF18.hr, Hour, s32)
acimf35.18 <- select(ACI_MF18.hr, Hour, s35)
acimf40.18 <- select(ACI_MF18.hr, Hour, s40)
acimf5.18 <- select(ACI_MF18.hr, Hour, s5)
acimf8.18 <- select(ACI_MF18.hr, Hour, s8)
#adding new column for site to all dataframes
acimf32.17$Site <- 32
acimf35.17$Site <- 35
acimf40.17$Site <- 40
acimf5.17$Site <- 5
acimf8.17$Site <- 8

#2018
acimf32.18$Site <- 32
acimf35.18$Site <- 35
acimf40.18$Site <- 40
acimf5.18$Site <- 5
acimf8.18$Site <- 8

#rbinding all of the dataframes together to get one big dataframe
#renaming columns in all dataframes
names(acimf32.17) <- c("Hour", "MF_ACI", "Site")
names(acimf35.17) <- c("Hour", "MF_ACI", "Site")
names(acimf40.17) <- c("Hour", "MF_ACI", "Site")
names(acimf5.17) <- c("Hour", "MF_ACI", "Site")
names(acimf8.17) <- c("Hour", "MF_ACI", "Site")

#2018
names(acimf32.18) <- c("Hour", "MF_ACI", "Site")
names(acimf35.18) <- c("Hour", "MF_ACI", "Site")
names(acimf40.18) <- c("Hour", "MF_ACI", "Site")
names(acimf5.18) <- c("Hour", "MF_ACI", "Site")
names(acimf8.18) <- c("Hour", "MF_ACI", "Site")
#creating a list of names
df_names.17 <- c("acimf32.17", "acimf35.17", "acimf40.17", "acimf5.17", "acimf8.17")
df_names.17
#rbinding everything together
lapply(df_names.17, get)
ACI_MF17.hr.long <- do.call(rbind, lapply(df_names.17, get))
str(ACI_MF17.hr.long)

#2018
#creating a list of names
df_names.18 <- c("acimf32.18", "acimf35.18", "acimf40.18", "acimf5.18", "acimf8.18")
df_names.18
#rbinding everything together
lapply(df_names.18, get)
ACI_MF18.hr.long <- do.call(rbind, lapply(df_names.18, get))
str(ACI_MF18.hr.long)

#saving the long files
#save(ACI_BB17.hr.long, file="Raw_Data/ACI_BB17hrlong.Rdata")
#save(ACI_HF17.hr.long, file="Raw_Data/ACI_HF17hrlong.Rdata")
#save(ACI_MF17.hr.long, file="Raw_Data/ACI_MF17hrlong.Rdata")
#save(ACI_BB18.hr.long, file="Raw_Data/ACI_BB18hrlong.Rdata")
#save(ACI_HF18.hr.long, file="Raw_Data/ACI_HF18hrlong.Rdata")
#save(ACI_MF18.hr.long, file="Raw_Data/ACI_MF18hrlong.Rdata")


# Combining the years

## Creating new column for year
ACI_BB17.hr.long$Year <- 2017
ACI_BB18.hr.long$Year <- 2018

ACI_HF17.hr.long$Year <- 2017
ACI_HF18.hr.long$Year <- 2018

ACI_MF17.hr.long$Year <- 2017
ACI_MF18.hr.long$Year <- 2018

##Combining dataframes

ACI_BB.hr.long <- rbind(ACI_BB17.hr.long, ACI_BB18.hr.long)
ACI_HF.hr.long <- rbind(ACI_HF17.hr.long, ACI_HF18.hr.long)
ACI_MF.hr.long <- rbind(ACI_MF17.hr.long, ACI_MF18.hr.long)

#Changing site to character
ACI_BB.hr.long$Site <- as.character(ACI_BB.hr.long$Site)
ACI_HF.hr.long$Site <- as.character(ACI_HF.hr.long$Site)
ACI_MF.hr.long$Site <- as.character(ACI_MF.hr.long$Site)

#saving these long files
#save(ACI_BB.hr.long, file="Raw_Data/ACI_BBhrlong.Rdata")
#save(ACI_HF.hr.long, file="Raw_Data/ACI_HFhrlong.Rdata")
#save(ACI_MF.hr.long, file="Raw_Data/ACI_MFhrlong.Rdata")


#Averaging sites between years

#creating a column combining hour and site
ACI_BB.hr.long$h.s <- paste(ACI_BB.hr.long$Hour,ACI_BB.hr.long$Site, sep= "_")
ACI_HF.hr.long$h.s <- paste(ACI_HF.hr.long$Hour,ACI_HF.hr.long$Site, sep= "_")
ACI_MF.hr.long$h.s <- paste(ACI_MF.hr.long$Hour,ACI_MF.hr.long$Site, sep= "_")

#aggregating by h.s id so that I get an average for each hour at each site between years
ACI_BB.hr.av <- aggregate(Broadband_ACI ~ h.s, data=ACI_BB.hr.long, FUN=mean)
ACI_HF.hr.av <- aggregate(HF_ACI ~ h.s, data=ACI_HF.hr.long, FUN=mean)
ACI_MF.hr.av <- aggregate(MF_ACI ~ h.s, data=ACI_MF.hr.long, FUN=mean)

#separating hour and site
ACI_BB.hr.av <- ACI_BB.hr.av %>% separate(h.s, into = c("Hour", "Site"), sep = "_")
ACI_MF.hr.av <- ACI_MF.hr.av %>% separate(h.s, into = c("Hour", "Site"), sep = "_")
ACI_HF.hr.av <- ACI_HF.hr.av %>% separate(h.s, into = c("Hour", "Site"), sep = "_")


#saving new dataframes
save(ACI_BB.hr.av, file="Raw_Data/ACI_BBhr_av.Rdata")
save(ACI_HF.hr.av, file="Raw_Data/ACI_HFhr_av.Rdata")
save(ACI_MF.hr.av, file="Raw_Data/ACI_MFhr_av.Rdata")




 ### SPL ###








##Broadband ##

#Seperating each dataframe into 5 seperate ones so that I can rebind them together
splbb32.17 <- select(SPL_BB17.hr, Hour, s32)
splbb35.17 <- select(SPL_BB17.hr, Hour, s35)
splbb40.17 <- select(SPL_BB17.hr, Hour, s40)
splbb5.17 <- select(SPL_BB17.hr, Hour, s5)
splbb8.17 <- select(SPL_BB17.hr, Hour, s8)

#2018
splbb32.18 <- select(SPL_BB18.hr, Hour, s32)
splbb35.18 <- select(SPL_BB18.hr, Hour, s35)
splbb40.18 <- select(SPL_BB18.hr, Hour, s40)
splbb5.18 <- select(SPL_BB18.hr, Hour, s5)
splbb8.18 <- select(SPL_BB18.hr, Hour, s8)
#adding new column for site to all dataframes
splbb32.17$Site <- 32
splbb35.17$Site <- 35
splbb40.17$Site <- 40
splbb5.17$Site <- 5
splbb8.17$Site <- 8

#2018
splbb32.18$Site <- 32
splbb35.18$Site <- 35
splbb40.18$Site <- 40
splbb5.18$Site <- 5
splbb8.18$Site <- 8

#rbinding all of the dataframes together to get one big dataframe
#renaming columns in all dataframes
names(splbb32.17) <- c("Hour", "Broadband_SPL", "Site")
names(splbb35.17) <- c("Hour", "Broadband_SPL", "Site")
names(splbb40.17) <- c("Hour", "Broadband_SPL", "Site")
names(splbb5.17) <- c("Hour", "Broadband_SPL", "Site")
names(splbb8.17) <- c("Hour", "Broadband_SPL", "Site")

#2018
names(splbb32.18) <- c("Hour", "Broadband_SPL", "Site")
names(splbb35.18) <- c("Hour", "Broadband_SPL", "Site")
names(splbb40.18) <- c("Hour", "Broadband_SPL", "Site")
names(splbb5.18) <- c("Hour", "Broadband_SPL", "Site")
names(splbb8.18) <- c("Hour", "Broadband_SPL", "Site")
#creating a list of names
df_names.17 <- c("splbb32.17", "splbb35.17", "splbb40.17", "splbb5.17", "splbb8.17")
df_names.17
#rbinding everything together
lapply(df_names.17, get)
SPL_BB17.hr.long <- do.call(rbind, lapply(df_names.17, get))
#str(ACI_BB17.hr.long)

#2018
#creating a list of names
df_names.18 <- c("splbb32.18", "splbb35.18", "splbb40.18", "splbb5.18", "splbb8.18")
df_names.18
#rbinding everything together
lapply(df_names.18, get)
SPL_BB18.hr.long <- do.call(rbind, lapply(df_names.18, get))
str(SPL_BB18.hr.long)


## HF ##


#Seperating each dataframe into 5 seperate ones so that I can rebind them together
splhf32.17 <- select(SPL_HF17.hr, Hour, s32)
splhf35.17 <- select(SPL_HF17.hr, Hour, s35)
splhf40.17 <- select(SPL_HF17.hr, Hour, s40)
splhf5.17 <- select(SPL_HF17.hr, Hour, s5)
splhf8.17 <- select(SPL_HF17.hr, Hour, s8)

#2018
splhf32.18 <- select(SPL_HF18.hr, Hour, s32)
splhf35.18 <- select(SPL_HF18.hr, Hour, s35)
splhf40.18 <- select(SPL_HF18.hr, Hour, s40)
splhf5.18 <- select(SPL_HF18.hr, Hour, s5)
splhf8.18 <- select(SPL_HF18.hr, Hour, s8)
#adding new column for site to all dataframes
splhf32.17$Site <- 32
splhf35.17$Site <- 35
splhf40.17$Site <- 40
splhf5.17$Site <- 5
splhf8.17$Site <- 8

#2018
splhf32.18$Site <- 32
splhf35.18$Site <- 35
splhf40.18$Site <- 40
splhf5.18$Site <- 5
splhf8.18$Site <- 8

#rbinding all of the dataframes together to get one big dataframe
#renaming columns in all dataframes
names(splhf32.17) <- c("Hour", "HF_SPL", "Site")
names(splhf35.17) <- c("Hour", "HF_SPL", "Site")
names(splhf40.17) <- c("Hour", "HF_SPL", "Site")
names(splhf5.17) <- c("Hour", "HF_SPL", "Site")
names(splhf8.17) <- c("Hour", "HF_SPL", "Site")

#2018
names(splhf32.18) <- c("Hour", "HF_SPL", "Site")
names(splhf35.18) <- c("Hour", "HF_SPL", "Site")
names(splhf40.18) <- c("Hour", "HF_SPL", "Site")
names(splhf5.18) <- c("Hour", "HF_SPL", "Site")
names(splhf8.18) <- c("Hour", "HF_SPL", "Site")
#creating a list of names
df_names.17 <- c("splhf32.17", "splhf35.17", "splhf40.17", "splhf5.17", "splhf8.17")
df_names.17
#rbinding everything together
lapply(df_names.17, get)
SPL_HF17.hr.long <- do.call(rbind, lapply(df_names.17, get))
str(SPL_HF17.hr.long)

#2018
#creating a list of names
df_names.18 <- c("splhf32.18", "splhf35.18", "splhf40.18", "splhf5.18", "splhf8.18")
df_names.18
#rbinding everything together
lapply(df_names.18, get)
SPL_HF18.hr.long <- do.call(rbind, lapply(df_names.18, get))
str(SPL_HF18.hr.long)


## MF ##



#Seperating each dataframe into 5 seperate ones so that I can rebind them together
splmf32.17 <- select(SPL_MF17.hr, Hour, s32)
splmf35.17 <- select(SPL_MF17.hr, Hour, s35)
splmf40.17 <- select(SPL_MF17.hr, Hour, s40)
splmf5.17 <- select(SPL_MF17.hr, Hour, s5)
splmf8.17 <- select(SPL_MF17.hr, Hour, s8)

#2018
splmf32.18 <- select(SPL_MF18.hr, Hour, s32)
splmf35.18 <- select(SPL_MF18.hr, Hour, s35)
splmf40.18 <- select(SPL_MF18.hr, Hour, s40)
splmf5.18 <- select(SPL_MF18.hr, Hour, s5)
splmf8.18 <- select(SPL_MF18.hr, Hour, s8)
#adding new column for site to all dataframes
splmf32.17$Site <- 32
splmf35.17$Site <- 35
splmf40.17$Site <- 40
splmf5.17$Site <- 5
splmf8.17$Site <- 8

#2018
splmf32.18$Site <- 32
splmf35.18$Site <- 35
splmf40.18$Site <- 40
splmf5.18$Site <- 5
splmf8.18$Site <- 8

#rbinding all of the dataframes together to get one big dataframe
#renaming columns in all dataframes
names(splmf32.17) <- c("Hour", "MF_SPL", "Site")
names(splmf35.17) <- c("Hour", "MF_SPL", "Site")
names(splmf40.17) <- c("Hour", "MF_SPL", "Site")
names(splmf5.17) <- c("Hour", "MF_SPL", "Site")
names(splmf8.17) <- c("Hour", "MF_SPL", "Site")

#2018
names(splmf32.18) <- c("Hour", "MF_SPL", "Site")
names(splmf35.18) <- c("Hour", "MF_SPL", "Site")
names(splmf40.18) <- c("Hour", "MF_SPL", "Site")
names(splmf5.18) <- c("Hour", "MF_SPL", "Site")
names(splmf8.18) <- c("Hour", "MF_SPL", "Site")
#creating a list of names
df_names.17 <- c("splmf32.17", "splmf35.17", "splmf40.17", "splmf5.17", "splmf8.17")
df_names.17
#rbinding everything together
lapply(df_names.17, get)
SPL_MF17.hr.long <- do.call(rbind, lapply(df_names.17, get))
str(SPL_MF17.hr.long)

#2018
#creating a list of names
df_names.18 <- c("splmf32.18", "splmf35.18", "splmf40.18", "splmf5.18", "splmf8.18")
df_names.18
#rbinding everything together
lapply(df_names.18, get)
SPL_MF18.hr.long <- do.call(rbind, lapply(df_names.18, get))
str(SPL_MF18.hr.long)

#saving the long files
#save(SPL_BB17.hr.long, file="Raw_Data/SPL_BB17hrlong.Rdata")
#save(SPL_HF17.hr.long, file="Raw_Data/SPL_HF17hrlong.Rdata")
#save(SPL_MF17.hr.long, file="Raw_Data/SPL_MF17hrlong.Rdata")
#save(SPL_BB18.hr.long, file="Raw_Data/SPL_BB18hrlong.Rdata")
#save(SPL_HF18.hr.long, file="Raw_Data/SPL_HF18hrlong.Rdata")
#save(SPL_MF18.hr.long, file="Raw_Data/SPL_MF18hrlong.Rdata")



# Combining the years
## Creating new column for year
SPL_BB17.hr.long$Year <- 2017
SPL_BB18.hr.long$Year <- 2018

SPL_HF17.hr.long$Year <- 2017
SPL_HF18.hr.long$Year <- 2018

SPL_MF17.hr.long$Year <- 2017
SPL_MF18.hr.long$Year <- 2018



##Combining dataframes

SPL_BB.hr.long <- rbind(SPL_BB17.hr.long, SPL_BB18.hr.long)
SPL_HF.hr.long <- rbind(SPL_HF17.hr.long, SPL_HF18.hr.long)
SPL_MF.hr.long <- rbind(SPL_MF17.hr.long, SPL_MF18.hr.long)

#Changing site to character
SPL_BB.hr.long$Site <- as.character(SPL_BB.hr.long$Site)
SPL_HF.hr.long$Site <- as.character(SPL_HF.hr.long$Site)
SPL_MF.hr.long$Site <- as.character(SPL_MF.hr.long$Site)

#saving these long files
#save(SPL_BB.hr.long, file="Raw_Data/SPL_BBhrlong.Rdata")
#save(SPL_HF.hr.long, file="Raw_Data/SPL_HFhrlong.Rdata")
#save(SPL_MF.hr.long, file="Raw_Data/SPL_MFhrlong.Rdata")

#Averaging sites between years

#creating a column combining hour and site
SPL_BB.hr.long$h.s <- paste(SPL_BB.hr.long$Hour,SPL_BB.hr.long$Site, sep= "_")
SPL_HF.hr.long$h.s <- paste(SPL_HF.hr.long$Hour,SPL_HF.hr.long$Site, sep= "_")
SPL_MF.hr.long$h.s <- paste(SPL_MF.hr.long$Hour,SPL_MF.hr.long$Site, sep= "_")

#aggregating by h.s id so that I get an average for each hour at each site between years
SPL_BB.hr.av <- aggregate(Broadband_SPL ~ h.s, data=SPL_BB.hr.long, FUN=mean)
SPL_HF.hr.av <- aggregate(HF_SPL ~ h.s, data=SPL_HF.hr.long, FUN=mean)
SPL_MF.hr.av <- aggregate(MF_SPL ~ h.s, data=SPL_MF.hr.long, FUN=mean)

#separating hour and site
SPL_BB.hr.av <- SPL_BB.hr.av %>% separate(h.s, into = c("Hour", "Site"), sep = "_")
SPL_MF.hr.av <- SPL_MF.hr.av %>% separate(h.s, into = c("Hour", "Site"), sep = "_")
SPL_HF.hr.av <- SPL_HF.hr.av %>% separate(h.s, into = c("Hour", "Site"), sep = "_")


#saving new dataframes
#save(SPL_BB.hr.av, file="Raw_Data/SPL_BBhr_av.Rdata")
#save(SPL_HF.hr.av, file="Raw_Data/SPL_HFhr_av.Rdata")
#save(SPL_MF.hr.av, file="Raw_Data/SPL_MFhr_av.Rdata")


##### Creating new dataframe that includes date and lunar phase ####
#2018 - because I found this first (woops)
#creating vectors for date and lunar phase
Day <- c(17:29)
LP <- c("NM", "NM", "NM", "NM", "First Quarter", "FQ", "FQ", "FQ", "FQ", "FQ", "FQ", "Full Moon", "FM")
Month <- 06
#combining into dataframe
lp2018 <- data.frame(Month, Day, LP)
#combining month and date columns - so taht I can match these with other dataframes
lp2018$Date <- paste(lp2018$Day,lp2018$Month, sep= "-0")

#2017
#creating vectors for date and lunar phase
Day <- c(10:26)
LP <- c("FM", "FM", "FM", "FM", "FM", "FM", "FM", "Third Quarter", "TQ", "TQ", "TQ", "TQ", "TQ", "New Moon", "NM", 
      "NM", "NM")
Month <- 07

#combining into dataframe
lp2017 <- data.frame(Month,Day, LP)
#combining month and date columns - so that I can match these with other dataframes
lp2017$Date <- paste(lp2017$Day,lp2017$Month, sep= "-0")

#saving these dataframes
##save(lp2017, file="Raw_Data/LunarPhase2017.Rdata")
#save(lp2018, file="Raw_Data/LunarPhase2018.Rdata")

##### 
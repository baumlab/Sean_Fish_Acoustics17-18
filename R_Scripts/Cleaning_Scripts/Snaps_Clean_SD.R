#2017-2018 Snap Data Cleaning Script
##The purpose of this script is to reorganize the data into more manageable dataframes
##There will be 2 dataframes, 1 for each year with a site/date id

library(tidyr)
library(dplyr)
#reading in all raw data

#2018
sn5.18 <- read.csv("Raw_Data/5_Snaps_2018.csv")
sn8.18 <- read.csv("Raw_Data/8_Snaps_2018.csv")
sn32.18 <- read.csv("Raw_Data/32_Snaps_2018.csv")
sn35.18 <- read.csv("Raw_Data/35_Snaps_2018.csv")
sn40.18 <- read.csv("Raw_Data/40_Snaps_2018.csv")

#2017
sn5.17 <- read.csv("Raw_Data/Site5_Snaps_2017rev.csv")
sn8.17 <- read.csv("Raw_Data/Site8_Snaps_2017.csv")
sn32.17 <- read.csv("Raw_Data/Site32_Snaps_2017.csv")
sn35.17 <- read.csv("Raw_Data/Site35_Snaps_2017rev.csv")
sn40.17 <- read.csv("Raw_Data/Site40_Snaps_2017rev.csv")

#Total Dataframe
load("Raw_Data/AC.DF.Rdata")

#### 2018 Data ####

### Making 1 long form dataframe

#Creating a column for the site
sn5.18$Site <- 5
sn8.18$Site <- 8
sn32.18$Site <- 32
sn35.18$Site <- 35
sn40.18$Site <- 40

#stacking the dataframes on top of eachother
snap.18 <- rbind(sn5.18, sn8.18, sn32.18, sn35.18, sn40.18)

#adding a year to the entire dataframe
snap.18$yr <- 18

#adding leading zeroes to months with one digit to match format of AC.DF dataframe
snap.18$Month <- sprintf("%02d", snap.18$Month)

#Pasting date together in a format that matches AC.DF st.id column format
snap.18$st.id <- paste(snap.18$Day,snap.18$Month, sep= "_")

snap.18$st.id <- paste(snap.18$st.id, snap.18$yr, sep= "_")

snap.18$st.id <- paste(snap.18$st.id, snap.18$Hour, sep= "-")

snap.18$st.id <- paste(snap.18$st.id, snap.18$Site, sep= "_")

snap.181 <- snap.18
#removing all rows with minutes = not 0
attach(snap.18)
snap.18 <- snap.18[which(Minute=="0"),]
detach(snap.18)

#2018 is now ready to match with the AC.DF dataframe


#dropping useless columns
colnames(snap.181)
drop <- c("st.id", "yr")
snap.181 = snap.181[,!names(snap.181) %in% drop]
colnames(snap.181)

#renaming columns
names(snap.181) <- c("Year", "Month", "Day", "Hour", "Minute", "Date", "Time", "Snaps", "Site")

#setting up date column for POSIX format
snap.181$Date1 <- paste(snap.181$Day, snap.181$Month, sep = "-")

snap.181$Date1 <- paste(snap.181$Date1, snap.181$Year, sep = "-")

#setting up time column for POSIX format

#adding leading zeroes to minutes and hours with one digit to match format of AC.DF dataframe
snap.181$Minute <- sprintf("%02d", snap.181$Minute)

snap.181$Hour <- sprintf("%02d", snap.181$Hour)


snap.181$Time1 <- paste(snap.181$Hour, snap.181$Minute, sep = ":")


snap.181$datetime <- as.POSIXct(paste(snap.181$Date1, snap.181$Time1), format = "%d-%m-%Y %H:%M")

#save(snap.181, file="Raw_Data/snap18long.Rdata")

##### 2017 Data ####

#adding site to each datafile
sn5.17$Site <- 5
sn8.17$Site <- 8
sn32.17$Site <- 32
sn35.17$Site <- 35
sn40.17$Site <- 40

#renaming the first column in sites 40,35, and 5 so that I can stack the columns
names(sn40.17) <- c("File", "Snaps", "Site")
names(sn35.17) <- c("File", "Snaps", "Site")
names(sn5.17) <- c("File", "Snaps", "Site")

#stacking all of the dataframes into 1 so that it is easier to handle
snap.17 <- rbind(sn5.17, sn8.17, sn32.17, sn35.17, sn40.17)

#Separating the file name into two columns
snap.17 <- snap.17 %>% separate(File, into = c("FN", "Time"), sep = 11)

#Separating time column into two columns - removing the .wav
snap.17 <- snap.17 %>% separate(Time, into = c("Time", ".wav"), sep = 12)

#removing two useless columns
colnames(snap.17)
drop <- c("FN", ".wav")
snap.17 = snap.17[,!names(snap.17) %in% drop]
colnames(snap.17)

#Separating time column into years and the rest of time
snap.17 <- snap.17 %>% separate(Time, into = c("Year", "Time"), sep = 2)

#Separating time column into months and the rest of time
snap.17 <- snap.17 %>% separate(Time, into = c("Month", "Time"), sep = 2)

#Separating time column into day and the rest of the time
snap.17 <- snap.17 %>% separate(Time, into = c("Day", "Time"), sep = 2)

#Separating time column into hour and the rest of the time
snap.17 <- snap.17 %>% separate(Time, into = c("Hour", "Time"), sep = 2)

#Separating time column into hour and the rest of the time
snap.17 <- snap.17 %>% separate(Time, into = c("Minute", "Seconds"), sep = 2)

#copying dataframe for later use
snap.171 <- snap.17
#removing all but the recordings on the hour
attach(snap.17)
snap.17 <- snap.17[which(Minute=="00"),]
detach(snap.17)

#removing useless columns
colnames(snap.17)
drop <- c("Minute", "Seconds")
snap.17 = snap.17[,!names(snap.17) %in% drop]
colnames(snap.17)

#pasting everything into an st.id that is the same format
snap.17$st.id <- paste(snap.17$Day,snap.17$Month, sep= "_")

snap.17$st.id <- paste(snap.17$st.id, snap.17$Year, sep= "_")

#removing leading zeroes in hour with a single digit to match the AC.DF
snap.17$Hour <- gsub("(?<![0-9])0+", "", snap.17$Hour, perl = TRUE)

#pasting hour to the st.id
snap.17$st.id <- paste(snap.17$st.id, snap.17$Hour, sep= "-")

#pasting site to the st.id
snap.17$st.id <- paste(snap.17$st.id, snap.17$Site, sep= "_")




## Prepping 2017 Snap to match with SPLHF long dataframe
#adding new column with the correct year format
snap.171$Year1 <- 2017

#setting up date column for POSIX format
snap.171$Date1 <- paste(snap.171$Day, snap.171$Month, sep = "-")

snap.171$Date1 <- paste(snap.171$Date1, snap.171$Year1, sep = "-")

#setting up time column for POSIX format

snap.171$Time <- paste(snap.171$Hour, snap.171$Minute, sep = ":")


snap.171$datetime <- as.POSIXct(paste(snap.171$Date1, snap.171$Time), format = "%d-%m-%Y %H:%M")

#save(snap.171, file="Raw_Data/snap17long.Rdata")


##### Combining 2017 and 2018 Data ####
snap.17 <- snap.17 %>% dplyr::select(st.id, Snaps)
snap.18 <- snap.18 %>% dplyr::select(st.id, Snaps)

##### Merge 2017 and 2018 with AC.DF ####
snaps <- rbind(snap.17, snap.18)

##### Merge snaps and AC.DF ####
AC.DF1 <- merge(AC.DF, snaps, by = "st.id")

#save AC.DF1 as a datafile
#save(AC.DF1, file="Raw_Data/AC.DF1.Rdata")


# I am losing rows here - 113 of them, so I gotta figure out why this is
## its happening in 2017 snap files - I only have 2000 compared to almost 20,000 in 2018 - fixed this with above step - needed to fix Month format in 2018

##figuring out which 3 files are missing from 2017
#difs <- setdiff(AC.DF$st.id, snap.17$st.id)
#difs
#
##making a list of the three files
#dm <- c("14_07_17-15_35", "19_07_17-15_40", "21_07_17-15_5")
#
##checking these three files in my larger dataframes
##selecting files surrounding the missing file
#missing.snaps1<- sn35.17[which(sn35.17$File == "1677987850.170714145002.wav" ), ]
#missing.snaps2<- sn35.17[which(sn35.17$File == "1677987850.170714150002.wav" ), ]
#missing.snaps3<- sn35.17[which(sn35.17$File == "1677987850.170714151002.wav" ), ]
#
##binding site 35 sites together
#ms35 <- rbind(missing.snaps1, missing.snaps2, missing.snaps3)
#ms35$Site <- 35
#
##selecting files surrounding the missing file
#missing.snaps4<- sn40.17[which(sn40.17$File == "1678278673.170719145002.wav" ), ]
#missing.snaps5<- sn40.17[which(sn40.17$File == "1678278673.170719151002.wav" ), ]
#
##binding site 40 files together
#ms40 <- rbind(missing.snaps4, missing.snaps5)
#ms40$Site <- 40
#
##selecting files surrounding the missing file
#missing.snaps5<- sn5.17[which(sn5.17$File == "1677987881.170721145002.wav" ), ]
#missing.snaps6<- sn5.17[which(sn5.17$File == "1677987881.170721151002.wav" ), ]
#
##binding site 5 files together
#ms5 <- rbind(missing.snaps5, missing.snaps6)
#ms5$Site <- 5
#
##binding all missing files together
#missing.snaps <- rbind(ms35, ms40, ms5)
#
#write.csv(missing.snaps, "Raw_Data/MissingFiles.csv")
#
#### Merge snaps long and High Frequency SPL **and high frequency ACI ####
load("Raw_Data/SPLHF17long.Rdata")
load("Raw_Data/SPLHF18long.Rdata")
load("Raw_Data/ACI_HF_long.Rdata")

#creating new column in each dataframe that includes date/time and site together to match with
snap.171$ds.id <- paste(snap.171$datetime, snap.171$Site, sep = "_")
SPLHF17.long$ds.id <- paste(SPLHF17.long$datetime, SPLHF17.long$Site, sep = "_")


snap.181$ds.id <- paste(snap.181$datetime, snap.181$Site, sep = "_")
SPLHF18.long$ds.id <- paste(SPLHF18.long$datetime, SPLHF18.long$Site, sep = "_")

Snap.HF17 <- merge(snap.171, SPLHF17.long, by = "ds.id")
Snap.HF18 <- merge(snap.181, SPLHF18.long, by = "ds.id")

#removing useless columns


#saving my new dataframes

#save(Snap.HF17, file="Raw_Data/Snap.HF17.Rdata")
#save(Snap.HF18, file="Raw_Data/Snap.HF18.Rdata")

#stacking these so that I get one total dataframe

#removing unnecessary columns
drop <- c("Date.y", "Time.y", "Site.y", "datetime.y", "Year", "Month", "Day", "Hour", "Minute", "Seconds","Date1")
Snap.HF17 <- Snap.HF17[,!names(Snap.HF17)%in%drop]

drop1 <- c("Date.y", "Time.y", "Site.y", "datetime.y", "Month", "Day", "Hour", "Minute","Date1","Time1")
Snap.HF18 <- Snap.HF18[,!names(Snap.HF18)%in%drop1]

#reordering columns so they match between dataframes
Snap.HF17 <- Snap.HF17[,c("datetime.x", "Site.x", "Date", "Time.x", "Year1", "ds.id", "Snaps", "SPL_HF")]
Snap.HF18 <- Snap.HF18[,c("datetime.x", "Site.x", "Date.x", "Time.x", "Year", "ds.id", "Snaps", "SPL_HF")]

#renaming columns the same thing
names(Snap.HF17) <- c("datetime", "Site", "Date", "Time", "Year", "ds.id", "Snaps", "SPL_HF")
names(Snap.HF18) <- c("datetime", "Site", "Date", "Time", "Year", "ds.id", "Snaps", "SPL_HF")

#making time only 4 digits long in 2018 to match with 2017
Snap.HF18 <- Snap.HF18 %>% separate(Time, into = c("Hour", "Minute", "Seconds"), sep = ":")

Snap.HF18$Time <- paste(Snap.HF18$Hour, Snap.HF18$Minute, sep = ":")

#removing extra columns
drop3 <- c("Hour", "Minute", "Seconds")
Snap.HF18 <- Snap.HF18[,!names(Snap.HF18)%in%drop3]

#rbinding these together
Snap.HF <- rbind(Snap.HF17, Snap.HF18)

#making site a character
Snap.HF$Site <- as.character(Snap.HF$Site)

#making new column that takes hour and makes it continuous

Snap.HF$Time2 <- sub(":", "", Snap.HF$Time)
  
Snap.HF <- Snap.HF %>% separate(Time, into = c("Hour", "Minutes"), sep = ":")

Snap.HF$Hour <- as.numeric(Snap.HF$Hour)

#making time2 a numeric
Snap.HF$Time2 <- as.numeric(Snap.HF$Time2)




#binning time to create different categories of time
#1st attempt - split into standard quarters at 6, 12, 18, 24 Hr

Time1.1 <- 0:920
Time1.2 <- 2141:2400
Time2 <- 921:2140


Early <- 0:5
Morning <- 6:11
Afternoon <- 12:17
Evening <- 18:23

Night1 <- 0:5
Night2 <- 19:23
Day <- 6:18

split1.1 <- 0:3
split1.2 <- 22:23
split2 <- 4:9
split3 <- 10:15
split4 <- 16:21

Snap.HF$t12[Snap.HF$Time2 %in% Time1.1] <- "High"
Snap.HF$t12[Snap.HF$Time2 %in% Time1.2] <- "High"
Snap.HF$t12[Snap.HF$Time2 %in% Time2] <- "Low"

Snap.HF$tg[Snap.HF$Hour %in% Early] <- "Early"
Snap.HF$tg[Snap.HF$Hour %in% Morning] <- "Morning"
Snap.HF$tg[Snap.HF$Hour %in% Afternoon] <- "Afternoon"
Snap.HF$tg[Snap.HF$Hour %in% Evening] <- "Evening"

Snap.HF$dn[Snap.HF$Hour %in% Night1] <- "Night"
Snap.HF$dn[Snap.HF$Hour %in% Night2] <- "Night"
Snap.HF$dn[Snap.HF$Hour %in% Day] <- "Day"

Snap.HF$ns[Snap.HF$Hour %in% split1.1] <- "9PM-3AM"
Snap.HF$ns[Snap.HF$Hour %in% split1.2] <- "9PM-3AM"
Snap.HF$ns[Snap.HF$Hour %in% split2] <- "3AM-9AM"
Snap.HF$ns[Snap.HF$Hour %in% split3] <- "9AM-3PM"
Snap.HF$ns[Snap.HF$Hour %in% split4] <- "9PM-3AM"

#matching ACI dataframe to Snap.HF 
Snap.HF <- merge(Snap.HF, ACI_HF_long, by = c("ds.id", "ds.id"))
#removing extra columns
drop2 <- c("Date.y", "Time", "Site.y", "Year.y", "datetime.y")
Snap.HF <- Snap.HF[,!names(Snap.HF)%in%drop2]

#renaming columns
names(Snap.HF) <- c("ds.id", "datetime", "Site", "Date", "Hour", "Minutes", "Year", "Snaps", "SPL_HF", "Time2", "t12", "tg", "dn", "ns", "ACI_HF")

save(Snap.HF, file="Raw_Data/Snap.HF.Rdata")


###################################
#
#
#
#### Adding Wind to my SPL HF and MF dataframes ####
#
#
#
###################################


#adding in wind to Snap.HF
load("Raw_Data/Windspeed.Rdata")

Snap.HF <- merge(Snap.HF, wind.sp, by = "datetime")

#removing columns that aren't helpful
col.drop <- c("Identification", "Latitude", "Longitude", "Date.y", "Hour", "Minute", "Time.y")

Snap.HF = Snap.HF[,!names(Snap.HF) %in% col.drop]
colnames(Snap.HF)

#renaming columns
names(Snap.HF) <- c("datetime", "Site", "Date", "Time", "Year", "ds.id", "Snaps", "SPL_HF", "Wind.Direction", "Wind.Speed")
colnames(Snap.HF)

#Saving the combined dataframe
save(Snap.HF, file= "Raw_Data/Snap.HF.Rdata")

#merging with the MF SPL Data
load("Raw_Data/SPLMFlong.Rdata")

SPLMF.long.wind <- merge(SPLMF.long, wind.sp, by = "datetime")

#removing columns that aren't helpful
col.drop <- c("Identification", "Latitude", "Longitude", "Date.y", "Hour", "Minute", "Time.y")
SPLMF.long.wind = SPLMF.long.wind[,!names(SPLMF.long.wind) %in% col.drop]
colnames(SPLMF.long.wind)

#renaming columns
names(SPLMF.long.wind) <- c("datetime", "Date", "Time", "SPL_MF", "Site", "Wind.Direction", "Wind.Speed")
colnames(SPLMF.long.wind)

#saving new dataframe
save(SPLMF.long.wind, file = "Raw_Data/SPLMF.long.wind.Rdata")

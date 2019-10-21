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
sn5.17 <- read.csv("Raw_Data/Site5_Snaps_2017.csv")
sn8.17 <- read.csv("Raw_Data/Site8_Snaps_2017.csv")
sn32.17 <- read.csv("Raw_Data/Site32_Snaps_2017.csv")
sn35.17 <- read.csv("Raw_Data/Site35_Snaps_2017.csv")
sn40.17 <- read.csv("Raw_Data/Site40_Snaps_2017.csv")

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

#removing all rows with minutes = not 0
attach(snap.18)
snap.18 <- snap.18[which(Minute=="0"),]
detach(snap.18)

#2018 is now ready to match with the AC.DF dataframe

##### 2017 Data ####

#adding site to each datafile
sn5.17$Site <- 5
sn8.17$Site <- 8
sn32.17$Site <- 32
sn35.17$Site <- 35
sn40.17$Site <- 40

#renaming the first column in site 40 so that I can stack the columns
names(sn40.17) <- c("File", "Snaps", "Site")

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




##### Combining 2017 and 2018 Data ####
snap.17 <- snap.17 %>% select(st.id, Snaps)
snap.18 <- snap.18 %>% select(st.id, Snaps)

##### Merge 2017 and 2018 with AC.DF ####
snaps <- rbind(snap.17, snap.18)

##### Merge snaps and AC.DF ####
AC.DF1 <- merge(AC.DF, snaps, by = "st.id")


# I am losing rows here - 113 of them, so I gotta figure out why this is
## its happening in 2017 snap files - I only have 2000 compared to almost 20,000 in 2018 - fixed this with above step - needed to fix Month format in 2018

#figuring out which 3 files are missing from 2017
difs <- setdiff(AC.DF$st.id, snap.17$st.id)
difs

#making a list of the three files
dm <- c("14_07_17-15_35", "19_07_17-15_40", "21_07_17-15_5")

#checking these three files in my larger dataframes
#selecting files surrounding the missing file
missing.snaps1<- sn35.17[which(sn35.17$File == "1677987850.170714145002.wav" ), ]
missing.snaps2<- sn35.17[which(sn35.17$File == "1677987850.170714150002.wav" ), ]
missing.snaps3<- sn35.17[which(sn35.17$File == "1677987850.170714151002.wav" ), ]

#binding site 35 sites together
ms35 <- rbind(missing.snaps1, missing.snaps2, missing.snaps3)
ms35$Site <- 35

#selecting files surrounding the missing file
missing.snaps4<- sn40.17[which(sn40.17$File == "1678278673.170719145002.wav" ), ]
missing.snaps5<- sn40.17[which(sn40.17$File == "1678278673.170719151002.wav" ), ]

#binding site 40 files together
ms40 <- rbind(missing.snaps4, missing.snaps5)
ms40$Site <- 40

#selecting files surrounding the missing file
missing.snaps5<- sn5.17[which(sn5.17$File == "1677987881.170721145002.wav" ), ]
missing.snaps6<- sn5.17[which(sn5.17$File == "1677987881.170721151002.wav" ), ]

#binding site 5 files together
ms5 <- rbind(missing.snaps5, missing.snaps6)
ms5$Site <- 5

#binding all missing files together
missing.snaps <- rbind(ms35, ms40, ms5)

write.csv(missing.snaps, "Raw_Data/MissingFiles.csv")

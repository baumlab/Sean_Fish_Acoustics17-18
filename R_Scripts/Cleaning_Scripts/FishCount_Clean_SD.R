#2017 - 2018 Fish Count Cleaning Script
## The purpose of this script is to make sure that all of the data is there and makes sense and then to move it into a more manageable dataframe
##There will be 1 final dataframe of this data with all of the sites in it
library(tidyr)
library(dplyr)

#Reading in the raw data
FC32<- read.csv("Raw_Data/FINAL_Quant_Acoustics_32.csv")
FC35<- read.csv("Raw_Data/FINAL_Quant_Acoustics_35.csv")
FC05<- read.csv("Raw_Data/FINAL_Quant_Acoustics_5.csv")
FC08<- read.csv("Raw_Data/FINAL_Quant_Acoustics_8.csv")
FC40<- read.csv("Raw_Data/FINAL_Quant_Acoustics_40.csv")


#removing extra column from 8 and 32
FC32 <- FC32[-c(13)]
FC08 <- FC08[-c(13)]


#rbinding all of the dataframes together
#creating a list of names
df_names <- c("FC32", "FC35", "FC05", "FC08", "FC40")
df_names
lapply(df_names, get)
FC.all <- do.call(rbind, lapply(df_names, get))
str(FC.all)

#replacing NA's in herbivory with 0's
FC.all$Num_Herbivory[is.na(FC.all$Num_Herbivory)] <- 0

#checking for missing data values
sum(is.na(FC.all$Tot_Knocks))
sum(is.na(FC.all$Num_L_calls))
sum(is.na(FC.all$Num_Herbivory))
# no missing values so we are good to go

#removing files with boat noise

#pulling out all comments that include "boat" so that I can isolate files with boat noise
FC.boat <- FC.all[grep("Boat", FC.all$Comment), ]
unique(FC.all$Comment)

#renaming columns
names(FC.boat) <- c("Site", "Date", "Time", "TIR", "Knocks", "KT", "KT#", "Tot_Knocks", "L_Calls", "Call Type", "Herbivory", "Comment")

#creating date - time - site ID's
#seperating time into hour and minute
FC.boat <- FC.boat %>% separate(Time, into = c("Hour", "Minute", "Second"), sep = ":")
#pasting date then hour then site
FC.boat$st.id <- paste(FC.boat$Date,FC.boat$Hour, sep= "-")
FC.boat$st.id <- paste(FC.boat$st.id, FC.boat$Site, sep = "_")

#creating a list of st.id's that have boat noise
boat.list <- unique(FC.boat$st.id)

#saving boat.list so that I can use it to pull out boat files
save(boat.list, file="Raw_Data/boatlist.Rdata")


## Summing values by Hour (ALL SITES)####

#creating a unique ID for each time/date combination
FC.test <- FC.all
#separating hour and minute so that I can sum by hour
FC.test <- FC.test %>% separate(Time, into = c("Hour", "Minute"), sep = ":")

#creating a column combining hour and date - for a unique time/date ID
FC.test$time.id <- paste(FC.test$Date,FC.test$Hour, sep= "-")

#summing by each hour (4 samples) so that we get 4 values per day
FC.test.hr <- aggregate(cbind(Tot_Knocks, Num_L_calls, Num_Herbivory) ~ time.id, data=FC.test, FUN=sum)


#summing by each day (16 samples) so that we get one value per day
FC.test.day <- aggregate(cbind(Tot_Knocks, Num_L_calls, Num_Herbivory) ~ Date, data=FC.test, FUN=sum)

## Summing values by Hour (Individual Sites)####
#getting names of columns (site has weird name)
head(FC.test)

#creating a column combining hour, date, and site - for a unique time/date ID
FC.test$st.id <- paste(FC.test$time.id,FC.test$ï..Site, sep= "_")


#summing by each hour (4 samples) so that we get 4 values per day per site
FC.site.hr <- aggregate(cbind(Tot_Knocks, Num_L_calls, Num_Herbivory) ~ st.id, data=FC.test, FUN=sum)

#separating each site from the main dataframe FC.test - because it has the st.id that I need to aggregate in the next step 
FCt32 <- FC.test %>% filter(ï..Site == 32)
FCt35 <- FC.test %>% filter(ï..Site == 35)
FCt40 <- FC.test %>% filter(ï..Site == 40)
FCt05 <- FC.test %>% filter(ï..Site == 5)
FCt08 <- FC.test %>% filter(ï..Site == 8)

#summing by each hour so that we get 4 values per day (now with each site as its own dataframe)
FCt32.hr <- aggregate(cbind(Tot_Knocks, Num_L_calls, Num_Herbivory) ~ st.id, data=FCt32, FUN=sum)
FCt35.hr <- aggregate(cbind(Tot_Knocks, Num_L_calls, Num_Herbivory) ~ st.id, data=FCt35, FUN=sum)
FCt40.hr <- aggregate(cbind(Tot_Knocks, Num_L_calls, Num_Herbivory) ~ st.id, data=FCt40, FUN=sum)
FCt05.hr <- aggregate(cbind(Tot_Knocks, Num_L_calls, Num_Herbivory) ~ st.id, data=FCt05, FUN=sum)
FCt08.hr <- aggregate(cbind(Tot_Knocks, Num_L_calls, Num_Herbivory) ~ st.id, data=FCt08, FUN=sum)

## Saving everything as .Rdata files ####
#saving the individual files
#save(FCt32.hr, file="Raw_Data/FC.32hr.Rdata")
#save(FCt35.hr, file="Raw_Data/FC.35hr.Rdata")
#save(FCt40.hr, file="Raw_Data/FC.40hr.Rdata")
#save(FCt05.hr, file="Raw_Data/FC.05hr.Rdata")
#save(FCt08.hr, file="Raw_Data/FC.08hr.Rdata")

#saving the grouped data files

#save(FC.test.hr, file="Raw_Data/FC.ALL.hr.Rdata")
#save(FC.test.day, file="Raw_Data/FC.ALL.day.Rdata")


## Getting the number of calls per day at each site ####
#creating a column combining date and site - for a unique date-site ID
FC.test$site.date <- paste(FC.test$Date,FC.test$ï..Site, sep= "-")

#summing by each site.date to get the number of calls per site per day
FC.site.day <- aggregate(cbind(Tot_Knocks, Num_L_calls, Num_Herbivory) ~ site.date, data=FC.test, FUN=sum)

#separating site and day
FC.sd <- FC.site.day %>% separate(site.date, into = c("Date", "Site"), sep = "-")
FC.sdALL <- FC.sd
#separating MD from year
FC.sad <- FC.sd %>% separate(Date, into = c("MD", "Year"), sep = 6)

#separating the underscore from the date
FC.sad <- FC.sad %>% separate(MD, into = c("MD", "del"), sep = 5)
#removing the underscore row
FC.sad <- subset(FC.sad, select = -c(del))

#subsetting by year
FC.sd17 <- FC.sad[which(FC.sad$Year == 17),]
FC.sd18 <- FC.sad[which(FC.sad$Year == 18),]
## Getting the number of calls per hour per day at each site ####

#separating hour and site from date
FC.site.hr <- FC.site.hr %>% separate(st.id, into = c("Date", "Hour_Site"), sep = "-")

#separating hour and site
FC.site.hr <- FC.site.hr %>% separate(Hour_Site, into = c("Hour", "Site"), sep = "_")

FC.sep <- FC.site.hr
FC.sepALL <- FC.sep
#separating MD from year
FC.sad <- FC.sep %>% separate(Date, into = c("MD", "Year"), sep = 6)

#separating the underscore from the date
FC.sad <- FC.sad %>% separate(MD, into = c("MD", "del"), sep = 5)
#removing the underscore row
FC.sad <- subset(FC.sad, select = -c(del))

#subsetting by year
FC.sep17 <- FC.sad[which(FC.sad$Year == 17),]
FC.sep18 <- FC.sad[which(FC.sad$Year == 18),]

#saving the new datafiles
#save(FC.sd, file="Raw_Data/FC.CallperDayALL.Rdata")
#save(FC.sd17, file="Raw_Data/FC.CallperDay17.Rdata")
#save(FC.sd18, file="Raw_Data/FC.CallperDay18.Rdata")
#
#save(FC.sep, file="Raw_Data/FC.CallperHourALL.Rdata")
#save(FC.sep17, file="Raw_Data/FC.CallperHour17.Rdata")
#save(FC.sep18, file="Raw_Data/FC.CallperHour18.Rdata")

### Creating new dataframe including all data from fish count dates ####

#Reading in the data created in ACI_SPL_Clean
load("Raw_Data/s32.17df.Rdata")
load("Raw_Data/s35.17df.Rdata")
load("Raw_Data/s40.17df.Rdata")
load("Raw_Data/s5.17df.Rdata")
load("Raw_Data/s8.17df.Rdata")

load("Raw_Data/s32.18df.Rdata")
load("Raw_Data/s35.18df.Rdata")
load("Raw_Data/s40.18df.Rdata")
load("Raw_Data/s5.18df.Rdata")
load("Raw_Data/s8.18df.Rdata")

## Reformating date so that it matches with Fish Count dataframes ####

#separating date into month and day
s32.17 <- s32.17 %>% separate(Date, into = c("Day", "Month"), sep = "-")
s35.17 <- s35.17 %>% separate(Date, into = c("Day", "Month"), sep = "-")
s40.17 <- s40.17 %>% separate(Date, into = c("Day", "Month"), sep = "-")
s5.17 <- s5.17 %>% separate(Date, into = c("Day", "Month"), sep = "-")
s8.17 <- s8.17 %>% separate(Date, into = c("Day", "Month"), sep = "-")

s32.18 <- s32.18 %>% separate(Date, into = c("Day", "Month"), sep = "-")
s35.18 <- s35.18 %>% separate(Date, into = c("Day", "Month"), sep = "-")
s40.18 <- s40.18 %>% separate(Date, into = c("Day", "Month"), sep = "-")
s5.18 <- s5.18 %>% separate(Date, into = c("Day", "Month"), sep = "-")
s8.18 <- s8.18 %>% separate(Date, into = c("Day", "Month"), sep = "-")

#pasting month and day back together with underscore to match formatting
s32.17$Date <- paste(s32.17$Day,s32.17$Month, sep= "_")
s35.17$Date <- paste(s35.17$Day,s35.17$Month, sep= "_")
s40.17$Date <- paste(s40.17$Day,s40.17$Month, sep= "_")
s5.17$Date <- paste(s5.17$Day,s5.17$Month, sep= "_")
s8.17$Date <- paste(s8.17$Day,s8.17$Month, sep= "_")

s32.18$Date <- paste(s32.18$Day,s32.18$Month, sep= "_")
s35.18$Date <- paste(s35.18$Day,s35.18$Month, sep= "_")
s40.18$Date <- paste(s40.18$Day,s40.18$Month, sep= "_")
s5.18$Date <- paste(s5.18$Day,s5.18$Month, sep= "_")
s8.18$Date <- paste(s8.18$Day,s8.18$Month, sep= "_")

#pasting year back into date
s32.17$Date <- paste(s32.17$Date,s32.17$Year, sep= "_")
s35.17$Date <- paste(s35.17$Date,s35.17$Year, sep= "_")
s40.17$Date <- paste(s40.17$Date,s40.17$Year, sep= "_")
s5.17$Date <- paste(s5.17$Date,s5.17$Year, sep= "_")
s8.17$Date <- paste(s8.17$Date,s8.17$Year, sep= "_")

s32.18$Date <- paste(s32.18$Date,s32.18$Year, sep= "_")
s35.18$Date <- paste(s35.18$Date,s35.18$Year, sep= "_")
s40.18$Date <- paste(s40.18$Date,s40.18$Year, sep= "_")
s5.18$Date <- paste(s5.18$Date,s5.18$Year, sep= "_")
s8.18$Date <- paste(s8.18$Date,s8.18$Year, sep= "_")


#separate Time into Hour and minute
s32.17 <- s32.17 %>% separate(Time, into = c("Hour", "Minute"), sep = ":")
s35.17 <- s35.17 %>% separate(Time, into = c("Hour", "Minute"), sep = ":")
s40.17 <- s40.17 %>% separate(Time, into = c("Hour", "Minute"), sep = ":")
s5.17 <- s5.17 %>% separate(Time, into = c("Hour", "Minute"), sep = ":")
s8.17 <- s8.17 %>% separate(Time, into = c("Hour", "Minute"), sep = ":")

s32.18 <- s32.18 %>% separate(Time, into = c("Hour", "Minute"), sep = ":")
s35.18 <- s35.18 %>% separate(Time, into = c("Hour", "Minute"), sep = ":")
s40.18 <- s40.18 %>% separate(Time, into = c("Hour", "Minute"), sep = ":")
s5.18 <- s5.18 %>% separate(Time, into = c("Hour", "Minute"), sep = ":")
s8.18 <- s8.18 %>% separate(Time, into = c("Hour", "Minute"), sep = ":")

#removing leading zeroes from hours with a single digit to match the Fish count dataframe
s32.17$Hour <- gsub("(?<![0-9])0+", "", s32.17$Hour, perl = TRUE) # this removes all zero hours which is OK because they weren't sampled
s35.17$Hour <- gsub("(?<![0-9])0+", "", s35.17$Hour, perl = TRUE)
s40.17$Hour <- gsub("(?<![0-9])0+", "", s40.17$Hour, perl = TRUE)
s5.17$Hour <- gsub("(?<![0-9])0+", "", s5.17$Hour, perl = TRUE)
s8.17$Hour <- gsub("(?<![0-9])0+", "", s8.17$Hour, perl = TRUE)

#2018
s32.18$Hour <- gsub("(?<![0-9])0+", "", s32.18$Hour, perl = TRUE) # this removes all zero hours which is OK because they weren't sampled
s35.18$Hour <- gsub("(?<![0-9])0+", "", s35.18$Hour, perl = TRUE)
s40.18$Hour <- gsub("(?<![0-9])0+", "", s40.18$Hour, perl = TRUE)
s5.18$Hour <- gsub("(?<![0-9])0+", "", s5.18$Hour, perl = TRUE)
s8.18$Hour <- gsub("(?<![0-9])0+", "", s8.18$Hour, perl = TRUE)

#pasting Date and Hour together
s32.17$Date <- paste(s32.17$Date,s32.17$Hour, sep= "-")
s35.17$Date <- paste(s35.17$Date,s35.17$Hour, sep= "-")
s40.17$Date <- paste(s40.17$Date,s40.17$Hour, sep= "-")
s5.17$Date <- paste(s5.17$Date,s5.17$Hour, sep= "-")
s8.17$Date <- paste(s8.17$Date,s8.17$Hour, sep= "-")

s32.18$Date <- paste(s32.18$Date,s32.18$Hour, sep= "-")
s35.18$Date <- paste(s35.18$Date,s35.18$Hour, sep= "-")
s40.18$Date <- paste(s40.18$Date,s40.18$Hour, sep= "-")
s5.18$Date <- paste(s5.18$Date,s5.18$Hour, sep= "-")
s8.18$Date <- paste(s8.18$Date,s8.18$Hour, sep= "-")

#creating site column
s32.17$Site <- 32
s35.17$Site <- 35
s40.17$Site <- 40
s5.17$Site <- 5
s8.17$Site <- 8

s32.18$Site <- 32
s35.18$Site <- 35
s40.18$Site <- 40
s5.18$Site <- 5
s8.18$Site <- 8

#pasting Date id and site together
s32.17$Date <- paste(s32.17$Date,s32.17$Site, sep= "_")
s35.17$Date <- paste(s35.17$Date,s35.17$Site, sep= "_")
s40.17$Date <- paste(s40.17$Date,s40.17$Site, sep= "_")
s5.17$Date <- paste(s5.17$Date,s5.17$Site, sep= "_")
s8.17$Date <- paste(s8.17$Date,s8.17$Site, sep= "_")

s32.18$Date <- paste(s32.18$Date,s32.18$Site, sep= "_")
s35.18$Date <- paste(s35.18$Date,s35.18$Site, sep= "_")
s40.18$Date <- paste(s40.18$Date,s40.18$Site, sep= "_")
s5.18$Date <- paste(s5.18$Date,s5.18$Site, sep= "_")
s8.18$Date <- paste(s8.18$Date,s8.18$Site, sep= "_")

#remove all minutes except 00 so that we get only the matching hours/minutes

attach(s32.17)
df32.17 <- s32.17[which(Minute=="00"),]
detach(s32.17)

attach(s35.17)
df35.17 <- s35.17[which(Minute=="00"),]
detach(s35.17)

attach(s40.17)
df40.17 <- s40.17[which(Minute=="00"),]
detach(s40.17)

attach(s5.17)
df5.17 <- s5.17[which(Minute=="00"),]
detach(s5.17)

attach(s8.17)
df8.17 <- s8.17[which(Minute=="00"),]
detach(s8.17)


#2018


attach(s32.18)
df32.18 <- s32.18[which(Minute=="00"),]
detach(s32.18)

attach(s35.18)
df35.18 <- s35.18[which(Minute=="00"),]
detach(s35.18)

attach(s40.18)
df40.18 <- s40.18[which(Minute=="00"),]
detach(s40.18)

attach(s5.18)
df5.18 <- s5.18[which(Minute=="00"),]
detach(s5.18)

attach(s8.18)
df8.18 <- s8.18[which(Minute=="00"),]
detach(s8.18)

#renaming columns for matching so that I can merge dataframes
names(df32.17)[names(df32.17) == "Date"] <- "st.id"
names(df35.17)[names(df35.17) == "Date"] <- "st.id"
names(df40.17)[names(df40.17) == "Date"] <- "st.id"
names(df5.17)[names(df5.17) == "Date"] <- "st.id"
names(df8.17)[names(df8.17) == "Date"] <- "st.id"

names(df32.18)[names(df32.18) == "Date"] <- "st.id"
names(df35.18)[names(df35.18) == "Date"] <- "st.id"
names(df40.18)[names(df40.18) == "Date"] <- "st.id"
names(df5.18)[names(df5.18) == "Date"] <- "st.id"
names(df8.18)[names(df8.18) == "Date"] <- "st.id"

#stacking by site
df32 <- rbind(df32.17, df32.18)
df35 <- rbind(df35.17, df35.18)
df40 <- rbind(df40.17, df40.18)
df5 <- rbind(df5.17, df5.18)
df8 <- rbind(df8.17, df8.18)



#matching dataframes
FC.DF32 <- merge(df32, FCt32.hr, by = "st.id")
FC.DF35 <- merge(df35, FCt35.hr, by = "st.id")
FC.DF40 <- merge(df40, FCt40.hr, by = "st.id")
FC.DF5 <- merge(df5, FCt05.hr, by = "st.id")
FC.DF8 <- merge(df8, FCt08.hr, by = "st.id")

### Problem here - only pulling dates that are 2 digits long because one dataframe uses hours that are one digit and one uses hours that are 2 digits

#rbinding all dataframes into one dataframe with 200 rows
AC.DF <- rbind(FC.DF32, FC.DF35, FC.DF40, FC.DF5, FC.DF8)


## Recreating a date column so that I can plot by date


#creating a day-month column
AC.DF$Date <- paste(AC.DF$Day,AC.DF$Month, sep= "_")

#binding year2 and date together to get a full date column
AC.DF$Date <- paste(AC.DF$Date,AC.DF$Year, sep= "_")

#dropping columns that are not of use
colnames(AC.DF)
drop <- c("Minute", "Day", "Month")
AC.DF = AC.DF[,!names(AC.DF) %in% drop]
colnames(AC.DF)

#saving my total dataframe

#save(AC.DF, file="Raw_Data/AC.DF.Rdata")



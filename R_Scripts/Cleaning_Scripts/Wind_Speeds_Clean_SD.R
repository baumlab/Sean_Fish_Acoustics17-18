#2017-2018 Wind Speed Cleaning Script
##The purpose of this script is to prepare the data so that it can be matched by datetime with other data files
##There will be 1 dataframe combining both years

library(tidyr)
library(dplyr)
#reading in all raw data
w17 <- read.csv("Raw_Data/2017_WindData_NOAA.csv")
w18 <- read.csv("Raw_Data/2018_WindData_NOAA.csv")

#removing useless columns

#2017

#w dir and speed are col 25 and 24
#keep the first 4 columns as well
w17 <- w17[-c(5:23,26:28)]

#2018
#col 26 and 27 are wind
#keep the first 4 columns as well
w18 <- w18[-c(5:25)]


###2017

#making adjustments to time so that it can be matched
w17 <- w17 %>% separate(Time.of.Observation, into = c("Date", "Time"), sep = "T")

w17 <- w17 %>% separate(Time, into = c("Hour", "Minute", "Seconds", sep = ":"))

#removing useless rows -> ":" and seconds because they are always 00 and aren't used in my datetime format for snaps
w17 <- w17[-c(7:8)]

#recombining minutes and hours

w17$Time <- paste(w17$Hour, w17$Minute, sep = ":")


w17$datetime <- as.POSIXct(paste(w17$Date, w17$Time), format = "%Y-%m-%d %H:%M")


###2018

#making adjustments to time so that it can be matched
w18 <- w18 %>% separate(Time.of.Observation, into = c("Date", "Time"), sep = "T")

w18 <- w18 %>% separate(Time, into = c("Hour", "Minute", "Seconds", sep = ":"))

#removing useless rows -> ":" and seconds because they are always 00 and aren't used in my datetime format for snaps
w18 <- w18[-c(7:8)]

#recombining minutes and hours

w18$Time <- paste(w18$Hour, w18$Minute, sep = ":")

w18$datetime <- as.POSIXct(paste(w18$Date, w18$Time), format = "%Y-%m-%d %H:%M")


#rbinding the dataframes together
wind.sp <- rbind(w17, w18)

#saving wind.sp as a Rdata file
save(wind.sp, file= "Raw_Data/Windspeed.Rdata")

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
save(FC.sd, file="Raw_Data/FC.CallperDayALL.Rdata")
save(FC.sd17, file="Raw_Data/FC.CallperDay17.Rdata")
save(FC.sd18, file="Raw_Data/FC.CallperDay18.Rdata")

save(FC.sep, file="Raw_Data/FC.CallperHourALL.Rdata")
save(FC.sep17, file="Raw_Data/FC.CallperHour17.Rdata")
save(FC.sep18, file="Raw_Data/FC.CallperHour18.Rdata")

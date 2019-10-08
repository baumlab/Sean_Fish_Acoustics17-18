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
save(FCt32.hr, file="Raw_Data/FC.32hr.Rdata")
save(FCt35.hr, file="Raw_Data/FC.35hr.Rdata")
save(FCt40.hr, file="Raw_Data/FC.40hr.Rdata")
save(FCt05.hr, file="Raw_Data/FC.05hr.Rdata")
save(FCt08.hr, file="Raw_Data/FC.08hr.Rdata")

#saving the grouped data files

save(FC.test.hr, file="Raw_Data/FC.ALL.hr.Rdata")
save(FC.test.day, file="Raw_Data/FC.ALL.day.Rdata")

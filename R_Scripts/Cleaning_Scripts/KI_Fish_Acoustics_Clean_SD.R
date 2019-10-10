#2017-2018 Fish for Acoustics Cleaning script
##The purpose of this script is to subset 2017 and 2018 and only sites used for the Acoustics surveys
#loading packages
library(tidyr)
library(dplyr)


load("Raw_Data/KI_UVC_11_13_15_17_18_SDEDIT.Rdata")

#subsetting for my sites
sites.to.keep <- c("32", "35", "40", "8", "5")
ki.ac <- ki_full[ki_full$Site%in%sites.to.keep,]
ki.ac <- droplevels(ki.ac)
unique(ki.ac$Site)

#subsetting for my years
years.to.keep <- c("2017", "2018")
ki.ac <- ki.ac[ki.ac$Year%in%years.to.keep,]
ki.ac <- droplevels(ki.ac)
unique(ki.ac$Year)

#creating new column in case sites were sampled on multiple occasions
colnames(ki.ac)

ki.ac$sitedate.id <- paste(ki.ac$KI.Date,ki.ac$Site, sep= "-")

#### Summing Abundance by survey ####
#subsetting only the columns that I need
ki.acab <- subset(ki.ac, select =c("Number", "sitedate.id", "Year"))
#summing by site id
ki.acab <- aggregate(Number ~ sitedate.id, data=ki.acab, FUN=sum)
#recreating site and date columns
ki.acab <- ki.acab %>% separate(sitedate.id, into = c("Date", "Site"), sep = "-")

#seperating them into years
#separating MD from year
ki.acab1 <- ki.acab %>% separate(Date, into = c("MD", "Year"), sep = 6)

#separating the underscore from the date
ki.acab1 <- ki.acab1 %>% separate(MD, into = c("MD", "del"), sep = 5)
#removing the underscore row
ki.acab1 <- subset(ki.acab1, select = -c(del))

#subsetting by year
ki.acab17 <- ki.acab1[which(ki.acab1$Year == 2017),]
ki.acab18 <- ki.acab1[which(ki.acab1$Year == 2018),]

#### Averaging Abundance for each site by year ####
#creating a new column for year
ki.acav <- ki.acab %>% separate(Date, into = c("MD", "Year"), sep = 6)

#creating an id column for site and year so that I can average by site and year
ki.acav$siteyear.id <- paste(ki.acav$Site,ki.acav$Year, sep= "_")

#averaging by site
ki.acav <- aggregate(Number ~ siteyear.id, data=ki.acav, FUN=mean)


#seperating them into years
#separating MD from year
ki.acav1 <- ki.acav %>% separate(siteyear.id, into = c("Site", "Year"), sep = "_")

#subsetting by year
ki.acav17 <- ki.acav1[which(ki.acav1$Year == 2017),]
ki.acav18 <- ki.acav1[which(ki.acav1$Year == 2018),]

#averaging by site with all years included
ki.acav <- aggregate(Number~ Site, data=ki.acav1, FUN=mean)
#### Saving dataframes ####
save(ki.acab, file="Raw_Data/ki_fishabundance.Rdata")
save(ki.acab17, file="Raw_Data/ki_fishabundance17.Rdata")
save(ki.acab18, file="Raw_Data/ki_fishabundance18.Rdata")

save(ki.acav, file="Raw_Data/ki_fishaverage.Rdata")
save(ki.acav17, file="Raw_Data/ki_fishaverage17.Rdata")
save(ki.acav18, file="Raw_Data/ki_fishaverage18.Rdata")

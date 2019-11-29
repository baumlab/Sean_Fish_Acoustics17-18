#2017-2018 Selection Table Cleaning Script
##The purpose of this script is to reorganize the data into more manageable dataframes
##There will be 2 dataframes, one for comparisons in knock intensity, one for comparisons in 

#
library(dplyr)

#loading AC.DF1
load("Raw_Data/AC.DF1.Rdata")


#loading in selection tables
ST12.17.21 <- read.delim(file = "Raw_Data/Selection_Tables/1677987881.170712210002.Table.1.selections.txt")
ST25.18.15 <- read.delim(file = "Raw_Data/Selection_Tables/1677987850.180625150002.Table.1.selections.txt")
ST13.17.03<- read.delim(file = "Raw_Data/Selection_Tables/1677987881.170713030002.Table.1.selections.txt")
ST13.17.21<- read.delim(file = "Raw_Data/Selection_Tables/1677987881.170713210002.Table.1.selections.txt")
ST14.17.03<- read.delim(file = "Raw_Data/Selection_Tables/1677987881.170714030002.Table.1.selections.txt")
ST14.17.21<- read.delim(file = "Raw_Data/Selection_Tables/1677987881.170714210002.Table.1.selections.txt")
ST21.17.03<- read.delim(file = "Raw_Data/Selection_Tables/1677987881.170721030002.Table.1.selections.txt")
ST12.17.15<- read.delim(file = "Raw_Data/Selection_Tables/1677987881.170712150002.Table.1.selections.txt")
ST19.17.03<- read.delim(file = "Raw_Data/Selection_Tables/1677987881.170719030002.Table.1.selections.txt")
ST14.17.15<- read.delim(file = "Raw_Data/Selection_Tables/1677987881.170714150002.Table.1.selections.txt")
ST27.18.09<- read.delim(file = "Raw_Data/Selection_Tables/1677987850.180627090002.Table.1.selections.txt")
ST20.18.09<- read.delim(file = "Raw_Data/Selection_Tables/1677987850.180620090002.Table.1.selections.txt")
ST25.18.09<- read.delim(file = "Raw_Data/Selection_Tables/1677987850.180625090002.Table.1.selections.txt")
ST26.18.09<- read.delim(file = "Raw_Data/Selection_Tables/1677987850.180626090002.Table.1.selections.txt")
ST24.18.09<- read.delim(file = "Raw_Data/Selection_Tables/1677987850.180624090002.Table.1.selections.txt")
ST19.17.09<- read.delim(file = "Raw_Data/Selection_Tables/1677987881.170719090002.Table.1.selections.txt")
ST12.17.09<- read.delim(file = "Raw_Data/Selection_Tables/1677987881.170712090002.Table.1.selections.txt")
ST21.17.09<- read.delim(file = "Raw_Data/Selection_Tables/1677987881.170721090002.Table.1.selections.txt")
ST20.18.03<- read.delim(file = "Raw_Data/Selection_Tables/1677987850.180620030004.Table.1.selections.txt")
ST20.18.21<- read.delim(file = "Raw_Data/Selection_Tables/1677987850.180620210002.Table.1.selections.txt")


#loading in selection tables from Mid_SPL selections
Mid20.18.09<- read.delim(file = "Raw_Data/Selection_Tables/1677987850.180620090002.SPLMid.selections.txt")
Mid27.18.09<- read.delim(file = "Raw_Data/Selection_Tables/1677987850.180627090002.SPLMid.selections.txt")
Mid25.18.09<- read.delim(file = "Raw_Data/Selection_Tables/1677987850.180625090002.SPLMid.selections.txt")
Mid26.18.09<- read.delim(file = "Raw_Data/Selection_Tables/1677987850.180626090002.SPLMid.selections.txt")
Mid24.18.09<- read.delim(file = "Raw_Data/Selection_Tables/1677987850.180624090002.SPLMid.selections.txt")
Mid19.17.09<- read.delim(file = "Raw_Data/Selection_Tables/1677987881.170719090002.SPLMid.selections.txt")
Mid12.17.09<- read.delim(file = "Raw_Data/Selection_Tables/1677987881.170712090002.SPLMid.selections.txt")
Mid21.17.09<- read.delim(file = "Raw_Data/Selection_Tables/1677987881.170721090002.SPLMid.selections.txt")
Mid20.18.03<- read.delim(file = "Raw_Data/Selection_Tables/1677987850.180620030004.SPLMid.selections.txt")
Mid20.18.21<- read.delim(file = "Raw_Data/Selection_Tables/1677987850.180620210002.SPLMid.selections.txt")

#loading in small selection tables
sm20.03<- read.delim(file = "Raw_Data/Small_Selection_Tables/1677987850.180620030002.txt")
sm20.09<- read.delim(file = "Raw_Data/Small_Selection_Tables/1677987850.180620090002.txt")
sm20.21<- read.delim(file = "Raw_Data/Small_Selection_Tables/1677987850.180620210002.txt")
sm24.09<- read.delim(file = "Raw_Data/Small_Selection_Tables/1677987850.180624090002.txt")
sm25.09<- read.delim(file = "Raw_Data/Small_Selection_Tables/1677987850.180625090002.txt")
sm25.15<- read.delim(file = "Raw_Data/Small_Selection_Tables/1677987850.180625150002.txt")
sm26.09<- read.delim(file = "Raw_Data/Small_Selection_Tables/1677987850.180626090002.txt")
sm27.09<- read.delim(file = "Raw_Data/Small_Selection_Tables/1677987850.180627090002.txt")
sm12.09<- read.delim(file = "Raw_Data/Small_Selection_Tables/1677987881.170712090002.txt")
sm12.15<- read.delim(file = "Raw_Data/Small_Selection_Tables/1677987881.170712150002.txt")
sm12.21<- read.delim(file = "Raw_Data/Small_Selection_Tables/1677987881.170712210002.txt")
sm13.03<- read.delim(file = "Raw_Data/Small_Selection_Tables/1677987881.170713030002.txt")
sm13.21<- read.delim(file = "Raw_Data/Small_Selection_Tables/1677987881.170713210002.txt")
sm14.03<- read.delim(file = "Raw_Data/Small_Selection_Tables/1677987881.170714030002.txt")
sm14.15<- read.delim(file = "Raw_Data/Small_Selection_Tables/1677987881.170714150002.txt")
sm14.21<- read.delim(file = "Raw_Data/Small_Selection_Tables/1677987881.170714210002.txt")
sm19.03<- read.delim(file = "Raw_Data/Small_Selection_Tables/1677987881.170719030002.txt")
sm19.09<- read.delim(file = "Raw_Data/Small_Selection_Tables/1677987881.170719090002.txt")
sm21.03<- read.delim(file = "Raw_Data/Small_Selection_Tables/1677987881.170721030002.txt")
sm21.09<- read.delim(file = "Raw_Data/Small_Selection_Tables/1677987881.170721090002.txt")



#adding date column to each dataframe
ST12.17.21$Date <- "12_07_17"
ST25.18.15$Date <- "25_06_18"
ST13.17.03$Date <- "13_07_17"
ST14.17.03$Date <- "14_07_17"
ST21.17.03$Date <- "21_07_17"
ST12.17.15$Date <- "12_07_17"
ST19.17.03$Date <- "19_07_17"
ST14.17.15$Date <- "14_07_17"
ST27.18.09$Date <- "27_06_18"
ST20.18.09$Date <- "20_06_18"
ST25.18.09$Date <- "25_06_18"
ST26.18.09$Date <- "26_06_18"
ST24.18.09$Date <- "24_06_18"
ST19.17.09$Date <- "19_07_17"
ST12.17.09$Date <- "12_07_17"
ST21.17.09$Date <- "21_07_17"
ST20.18.03$Date <- "20_06_18"
ST20.18.21$Date <- "20_06_18"

Mid20.18.09$Date <- "20_06_18"
Mid27.18.09$Date <- "27_06_18"
Mid25.18.09$Date <- "25_06_18"
Mid26.18.09$Date <- "26_06_18"
Mid24.18.09$Date <- "24_06_18"
Mid19.17.09$Date <- "19_07_17"
Mid12.17.09$Date <- "12_07_17"
Mid21.17.09$Date <- "21_07_17"
Mid20.18.03$Date <- "20_06_18"
Mid20.18.21$Date <- "20_06_18"

sm20.03$Date <- "20_06_18"
sm20.09$Date <- "20_06_18"
sm20.21$Date <- "20_06_18"
sm24.09$Date <- "24_06_18"
sm25.09$Date <- "25_06_18"
sm25.15$Date <- "25_06_18"
sm26.09$Date <- "26_06_18"
sm27.09$Date <- "27_06_18"
sm12.09$Date <- "12_07_17"
sm12.15$Date <- "12_07_17"
sm12.21$Date <- "12_07_17"
sm13.03$Date <- "13_07_17"
sm13.21$Date <- "13_07_17"
sm14.03$Date <- "14_07_17"
sm14.15$Date <- "14_07_17"
sm14.21$Date <- "14_07_17"
sm19.03$Date <- "19_07_17"
sm19.09$Date <- "19_07_17"
sm21.03$Date <- "21_07_17"
sm21.09$Date <- "21_07_17"

#Adding hour column to each dataframe
ST12.17.21$Hour <- 21
ST25.18.15$Hour <- 15
ST13.17.03$Hour <- 3
ST14.17.03$Hour <- 3
ST21.17.03$Hour <- 3
ST12.17.15$Hour <- 15
ST19.17.03$Hour <- 3
ST14.17.15$Hour <- 15
ST27.18.09$Hour <- 9
ST20.18.09$Hour <- 9
ST25.18.09$Hour <- 9
ST26.18.09$Hour <- 9
ST24.18.09$Hour <- 9
ST19.17.09$Hour <- 9
ST12.17.09$Hour <- 9
ST21.17.09$Hour <- 9
ST20.18.03$Hour <- 3
ST20.18.21$Hour <- 21

Mid20.18.09$Hour <- 9
Mid27.18.09$Hour <- 9
Mid25.18.09$Hour <- 9
Mid26.18.09$Hour <- 9
Mid24.18.09$Hour <- 9
Mid19.17.09$Hour <- 9
Mid12.17.09$Hour <- 9
Mid21.17.09$Hour <- 9
Mid20.18.03$Hour <- 3
Mid20.18.21$Hour <- 21

sm20.03$Hour <- 3
sm20.09$Hour <- 9
sm20.21$Hour <- 21
sm24.09$Hour <- 9
sm25.09$Hour <- 9
sm25.15$Hour <- 15
sm26.09$Hour <- 9
sm27.09$Hour <- 9
sm12.09$Hour <- 9
sm12.15$Hour <- 15
sm12.21$Hour <- 21
sm13.03$Hour <- 3
sm13.21$Hour <- 21
sm14.03$Hour <- 3
sm14.15$Hour <- 15
sm14.21$Hour <- 21
sm19.03$Hour <- 3
sm19.09$Hour <- 9
sm21.03$Hour <- 3
sm21.09$Hour <- 9

#Adding year column to each dataframe
ST12.17.21$Year <- 17
ST25.18.15$Year <- 18
ST13.17.03$Year <- 17
ST14.17.03$Year <- 17
ST21.17.03$Year <- 17
ST12.17.15$Year <- 17
ST19.17.03$Year <- 17
ST14.17.15$Year <- 17
ST27.18.09$Year <- 18
ST20.18.09$Year <- 18
ST25.18.09$Year <- 18
ST26.18.09$Year <- 18
ST24.18.09$Year <- 18
ST19.17.09$Year <- 17
ST12.17.09$Year <- 17
ST21.17.09$Year <- 17
ST20.18.03$Year <- 18
ST20.18.21$Year <- 18

Mid20.18.09$Year <- 18
Mid27.18.09$Year <- 18
Mid25.18.09$Year <- 18
Mid26.18.09$Year <- 18
Mid24.18.09$Year <- 18
Mid19.17.09$Year <- 17
Mid12.17.09$Year <- 17
Mid21.17.09$Year <- 17
Mid20.18.03$Year <- 18
Mid20.18.21$Year <- 18

sm20.03$Year <- 18
sm20.09$Year <- 18
sm20.21$Year <- 18
sm24.09$Year <- 18
sm25.09$Year <- 18
sm25.15$Year <- 18
sm26.09$Year <- 18
sm27.09$Year <- 18
sm12.09$Year <- 17
sm12.15$Year <- 17
sm12.21$Year <- 17
sm13.03$Year <- 17
sm13.21$Year <- 17
sm14.03$Year <- 17
sm14.15$Year <- 17
sm14.21$Year <- 17
sm19.03$Year <- 17
sm19.09$Year <- 17
sm21.03$Year <- 17
sm21.09$Year <- 17

#seperating selection tables into three parts: knocks, Mid_SPL selections, and other calls

#knocks
ST17.1<- ST12.17.21[which(ST12.17.21$Comments==""),]
ST18.1<- ST25.18.15[which(ST25.18.15$Comments==""),]
ST17.2<- ST13.17.03[which(ST13.17.03$Comments==""),]
ST17.3<- ST14.17.03[which(ST14.17.03$Comments==""),]
ST17.4<- ST21.17.03[which(ST21.17.03$Comments==""),]
ST17.5<- ST12.17.15[which(ST12.17.15$Comments==""),]
ST17.6<- ST19.17.03[which(ST19.17.03$Comments==""),]
ST17.7<- ST14.17.15[which(ST14.17.15$Comments==""),]
ST18.2<- ST27.18.09[which(ST27.18.09$Comments==""),]
ST18.3<- ST20.18.09[which(ST20.18.09$Comments==""),]
ST18.4<- ST25.18.09[which(ST25.18.09$Comments==""),]
ST18.5<- ST26.18.09[which(ST26.18.09$Comments==""),]
ST18.6<- ST24.18.09[which(ST24.18.09$Comments==""),]
ST17.8<- ST19.17.09[which(ST19.17.09$Comments==""),]
ST17.9<- ST12.17.09[which(ST12.17.09$Comments==""),]
ST17.10<- ST21.17.09[which(ST21.17.09$Comments==""),]
ST18.7<- ST20.18.03[which(ST20.18.03$Comments==""),]
ST18.8<- ST20.18.21[which(ST20.18.21$Comments==""),]



#getting references
Ref17.1<- ST12.17.21[which(ST12.17.21$Comments=="Reference"),]
Ref18.1<- ST25.18.15[which(ST25.18.15$Comments=="Reference"),]
Ref17.2<- ST13.17.03[which(ST13.17.03$Comments=="Reference"),]
Ref17.3<- ST14.17.03[which(ST14.17.03$Comments=="Reference"),]
Ref17.4<- ST21.17.03[which(ST21.17.03$Comments=="Reference"),]
Ref17.5<- ST12.17.15[which(ST12.17.15$Comments=="Reference"),]
Ref17.6<- ST19.17.03[which(ST19.17.03$Comments=="Reference"),]
Ref17.7<- ST14.17.15[which(ST14.17.15$Comments=="Reference"),]
Ref18.2<- ST27.18.09[which(ST27.18.09$Comments=="Reference"),]
Ref18.3<- ST20.18.09[which(ST20.18.09$Comments=="Reference"),]
Ref18.4<- ST25.18.09[which(ST25.18.09$Comments=="Reference"),]
Ref18.5<- ST26.18.09[which(ST26.18.09$Comments=="Reference"),]
Ref18.6<- ST24.18.09[which(ST24.18.09$Comments=="Reference"),]
Ref17.8<- ST19.17.09[which(ST19.17.09$Comments=="Reference"),]
Ref17.9<- ST12.17.09[which(ST12.17.09$Comments=="Reference"),]
Ref17.10<- ST21.17.09[which(ST21.17.09$Comments=="Reference"),]
Ref18.7<- ST20.18.03[which(ST20.18.03$Comments=="Reference"),]
Ref18.8<- ST20.18.21[which(ST20.18.21$Comments=="Reference"),]



#Mid Selections
MT17.1<- ST12.17.21[which(ST12.17.21$Comments=="Mid_Selection"),]
MT18.1<- ST25.18.15[which(ST25.18.15$Comments=="Mid_Selection"),]
MT17.2<- ST13.17.03[which(ST13.17.03$Comments=="Mid_Selection"),]
MT17.3<- ST14.17.03[which(ST14.17.03$Comments=="Mid_Selection"),]
MT17.4<- ST21.17.03[which(ST21.17.03$Comments=="Mid_Selection"),]
MT17.5<- ST12.17.15[which(ST12.17.15$Comments=="Mid_Selection"),]
MT17.6<- ST19.17.03[which(ST19.17.03$Comments=="Mid_Selection"),]
MT17.7<- ST14.17.15[which(ST14.17.15$Comments=="Mid_Selection"),]
MT18.2<- ST27.18.09[which(ST27.18.09$Comments=="Mid_Selection"),]
MT18.3<- ST20.18.09[which(ST20.18.09$Comments=="Mid_Selection"),]
MT18.4<- ST25.18.09[which(ST25.18.09$Comments=="Mid_Selection"),]
MT18.5<- ST26.18.09[which(ST26.18.09$Comments=="Mid_Selection"),]
MT18.6<- ST24.18.09[which(ST24.18.09$Comments=="Mid_Selection"),]
MT17.8<- ST19.17.09[which(ST19.17.09$Comments=="Mid_Selection"),]
MT17.9<- ST12.17.09[which(ST12.17.09$Comments=="Mid_Selection"),]
MT17.10<- ST21.17.09[which(ST21.17.09$Comments=="Mid_Selection"),]
MT18.7<- ST20.18.03[which(ST20.18.03$Comments=="Mid_Selection"),]
MT18.8<- ST20.18.21[which(ST20.18.21$Comments=="Mid_Selection"),]

#small selections
sm20.03<- sm20.03[which(sm20.03$View=="Spectrogram 1"),]
sm20.09<- sm20.09[which(sm20.09$View=="Spectrogram 1"),]
sm20.21<- sm20.21[which(sm20.21$View=="Spectrogram 1"),]
sm24.09<- sm24.09[which(sm24.09$View=="Spectrogram 1"),]
sm25.09<- sm25.09[which(sm25.09$View=="Spectrogram 1"),]
sm25.15<- sm25.15[which(sm25.15$View=="Spectrogram 1"),]
sm26.09<- sm26.09[which(sm26.09$View=="Spectrogram 1"),]
sm27.09<- sm27.09[which(sm27.09$View=="Spectrogram 1"),]
sm12.09<- sm12.09[which(sm12.09$View=="Spectrogram 1"),]
sm12.15<- sm12.15[which(sm12.15$View=="Spectrogram 1"),]
sm12.21<- sm12.21[which(sm12.21$View=="Spectrogram 1"),]
sm13.03<- sm13.03[which(sm13.03$View=="Spectrogram 1"),]
sm13.21<- sm13.21[which(sm13.21$View=="Spectrogram 1"),]
sm14.03<- sm14.03[which(sm14.03$View=="Spectrogram 1"),]
sm14.15<- sm14.15[which(sm14.15$View=="Spectrogram 1"),]
sm14.21<- sm14.21[which(sm14.21$View=="Spectrogram 1"),]
sm19.03<- sm19.03[which(sm19.03$View=="Spectrogram 1"),]
sm19.09<- sm19.09[which(sm19.09$View=="Spectrogram 1"),]
sm21.03<- sm21.03[which(sm21.03$View=="Spectrogram 1"),]
sm21.09<- sm21.09[which(sm21.09$View=="Spectrogram 1"),]

#small selections reference
ref20.03<- sm20.03[5,]
ref20.09<- sm20.09[5,]
ref20.21<- sm20.21[5,]
ref24.09<- sm24.09[5,]
ref25.09<- sm25.09[5,]
ref25.15<- sm25.15[5,]
ref26.09<- sm26.09[5,]
ref27.09<- sm27.09[5,]
ref12.09<- sm12.09[5,]
ref12.15<- sm12.15[5,]
ref12.21<- sm12.21[5,]
ref13.03<- sm13.03[5,]
ref13.21<- sm13.21[5,]
ref14.03<- sm14.03[5,]
ref14.15<- sm14.15[5,]
ref14.21<- sm14.21[5,]
ref19.03<- sm19.03[5,]
ref19.09<- sm19.09[5,]
ref21.03<- sm21.03[5,]
ref21.09<- sm21.09[5,]

#small selections
sm20.03<- sm20.03[1:4,]
sm20.09<- sm20.09[1:4,]
sm20.21<- sm20.21[1:4,]
sm24.09<- sm24.09[1:4,]
sm25.09<- sm25.09[1:4,]
sm25.15<- sm25.15[1:4,]
sm26.09<- sm26.09[1:4,]
sm27.09<- sm27.09[1:4,]
sm12.09<- sm12.09[1:4,]
sm12.15<- sm12.15[1:4,]
sm12.21<- sm12.21[1:4,]
sm13.03<- sm13.03[1:4,]
sm13.21<- sm13.21[1:4,]
sm14.03<- sm14.03[1:4,]
sm14.15<- sm14.15[1:4,]
sm14.21<- sm14.21[1:4,]
sm19.03<- sm19.03[1:4,]
sm19.09<- sm19.09[1:4,]
sm21.03<- sm21.03[1:4,]
sm21.09<- sm21.09[1:4,]

#filling in the empty dataframes from seperate selection tables
MT18.2 <- Mid20.18.09
MT18.3 <- Mid27.18.09
MT18.4 <- Mid25.18.09
MT18.5 <- Mid26.18.09
MT18.6 <- Mid24.18.09
MT17.10 <- Mid19.17.09
MT17.8 <- Mid12.17.09
MT17.9 <- Mid21.17.09
MT18.7 <- Mid20.18.03
MT18.8 <- Mid20.18.21

#rbinding everything together
Ktot <- rbind(ST17.1, ST17.2, ST17.3, ST17.4, ST17.5, ST17.6, ST17.7, ST17.8, ST17.9, ST17.10, ST18.1, ST18.2, ST18.3, ST18.4, 
              ST18.5, ST18.6, ST18.7, ST18.8)

Reftot <- rbind(Ref17.1, Ref17.2, Ref17.3, Ref17.4, Ref17.5, Ref17.6, Ref17.7, Ref17.8, Ref17.9, Ref17.10, Ref18.1, Ref18.2, 
                Ref18.3, Ref18.4, Ref18.5, Ref18.6, Ref18.7, Ref18.8)

Ref2 <- rbind(ref20.03,
  ref20.09,
  ref20.21,
  ref24.09,
  ref25.09,
  ref25.15,
  ref26.09,
  ref27.09,
  ref12.09,
  ref12.15,
  ref12.21,
  ref13.03,
  ref13.21,
  ref14.03,
  ref14.15,
  ref14.21,
  ref19.03,
  ref19.09,
  ref21.03
  
)

Stot <- rbind(sm20.03,
  sm20.09,
  sm20.21,
  sm24.09,
  sm25.09,
  sm25.15,
  sm26.09,
  sm27.09,
  sm12.09,
  sm12.15,
  sm12.21,
  sm13.03,
  sm13.21,
  sm14.03,
  sm14.15,
  sm14.21,
  sm19.03,
  sm19.09,
  sm21.03
)
#21.09 removed because its missing stuff

#for MT I need to remove comments column
MT17.1 <- subset(MT17.1, select = -c(Comments))
MT17.2 <- subset(MT17.2, select = -c(Comments))
MT17.3 <- subset(MT17.3, select = -c(Comments))
MT17.4 <- subset(MT17.4, select = -c(Comments))
MT17.5 <- subset(MT17.5, select = -c(Comments))
MT17.6 <- subset(MT17.6, select = -c(Comments))
MT17.7 <- subset(MT17.7, select = -c(Comments))
MT17.8 <- subset(MT17.8, select = -c(Comments))
MT17.9 <- subset(MT17.9, select = -c(Comments))
MT17.10 <-subset(MT17.10, select = -c(Comments))
MT18.1 <- subset(MT18.1, select = -c(Comments))
MT18.2 <- subset(MT18.2, select = -c(Comments))
MT18.3 <- subset(MT18.3, select = -c(Comments))
MT18.4 <- subset(MT18.4, select = -c(Comments))
MT18.5 <- subset(MT18.5, select = -c(Comments))
MT18.6 <- subset(MT18.6, select = -c(Comments))
MT18.7 <- subset(MT18.7, select = -c(Comments))
MT18.8 <- subset(MT18.8, select = -c(Comments))

#rbinding everything together
Mtot <- rbind(MT17.1, MT17.2, MT17.3, MT17.4, MT17.5, MT17.6, MT17.7, MT17.8, MT17.9, MT17.10, MT18.1, MT18.2, MT18.3, MT18.4,
              MT18.5, MT18.6, MT18.7, MT18.8)


####### K tot ###########


#Creating column that creates unique ID for date and time
Ktot$DH <- paste(Ktot$Date, Ktot$Hour, sep= "-")
Reftot$DH <- paste(Reftot$Date, Reftot$Hour, sep= "-")
Ref2$DH <- paste(Ref2$Date, Ref2$Hour, sep= "-")

#merging by unique ID
KtotE <- merge(Ktot, Reftot[, c("DH", "Energy")], by = "DH")
KtotP <- merge(Ktot, Reftot[, c("DH", "Peak.Power.Density..dB.FS.")], by = "DH")
#KtotI <- merge(Ktot, Reftot[, c("DH", "Inband.Power..dB.FS.", by = "DH")]) - Reftot doesn't have inband power

#Subtracting Values from Reference values
KtotE$EnergyDiff <- KtotE$Energy.x - KtotE$Energy.y
KtotP$PowerDiff <- KtotP$Peak.Power.Density..dB.FS..x - KtotP$Peak.Power.Density..dB.FS..y

#Adding SPL values

#adding site to the end of all DH so that I can match with AC.DF1 dataframe
KtotE$st.id <- paste0(KtotE$DH, "_5")
KtotP$st.id <- paste0(KtotP$DH, "_5")

#matching SPL values from AC.DF1 dataframe
KtotE <- merge(KtotE, AC.DF1[, c("st.id", "SPL_Midrange")], by = "st.id", all = FALSE)
KtotP <- merge(KtotP, AC.DF1[, c("st.id", "SPL_Midrange")], by = "st.id", all = FALSE)

#saving dataframes
#save(KtotE, file= "Raw_Data/KtotE.Rdata")
#save(KtotP, file= "Raw_Data/KtotP.Rdata")

######## M tot ##############

#creating column with unique ID for date and time
Mtot$DH <- paste(Mtot$Date, Mtot$Hour, sep= "-")

#merging with Reftot by unique ID
MtotP <- merge(Mtot, Reftot[, c("DH", "Peak.Power.Density..dB.FS.")], by = "DH")

#subtracting values from reference values
MtotP$PowerDiff <- MtotP$Peak.Power.Density..dB.FS..x - MtotP$Peak.Power.Density..dB.FS..y

#Adding SPL values
#adding site to the end of DH so that I can match with the AC.DF1 dataframe
MtotP$st.id <-paste0(MtotP$DH, "_5")

#matching SPL values from AC.DF1 dataframe
MtotP <- merge(MtotP, AC.DF1[, c("st.id", "SPL_Midrange")], by = "st.id", all = FALSE)

#saving dataframe
#save(MtotP, file = "Raw_Data/MtotP.Rdata")

######## S tot ################

#creating column with unique ID for date and time
Stot$DH <- paste(Stot$Date, Stot$Hour, sep= "-")

#merging with Reftot by unique ID
StotP <- merge(Stot, Ref2[, c("DH", "Peak.Power.Density..dB.FS.")], by = "DH")
StotP <- merge(StotP, Ref2[, c("DH", "Avg.Power.Density..dB.FS.")], by = "DH")
#subtracting values from reference values
StotP$PowerDiff <- StotP$Peak.Power.Density..dB.FS..x - StotP$Peak.Power.Density..dB.FS..y
StotP$AvPowerDiff <- StotP$Avg.Power.Density..dB.FS..x - StotP$Avg.Power.Density..dB.FS..y
#Adding SPL values
#adding site to the end of DH so that I can match with the AC.DF1 dataframe
StotP$st.id <-paste0(StotP$DH, "_5")

#matching SPL values from AC.DF1 dataframe
StotP <- merge(StotP, AC.DF1[, c("st.id", "SPL_Midrange")], by = "st.id", all = FALSE)

#saving dataframe
save(StotP, file = "Raw_Data/StotP.Rdata")



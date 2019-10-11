#Acoustics Model Script
## The purpose of this script is to come up with the most descriptive model for the Acoustics data, use model selection, and decide on how to best represent my data
##There should be 1 final model at the end of this

library(dplyr)
library(GGally)
library(mctest)
library(usdm)

#loading in total dataframe
load("../Raw_Data/AC.DF.Rdata")


#rough draft model formula for SPL_Midrange

#fit1 <- lm(MF_SPL ~ Knocks + Long Calls + Site + Hour, data = AC.DF) - just a draft not using actual column names
colnames(AC.DF)
fit1 <- lm(SPL_Midrange ~ Tot_Knocks + Num_L_calls + Site + Hour, data = AC.DF)
summary(fit1)


par(mfrow=c(2,2))
plot(fit1)

#subsetting only explanatory variables
AC.DF.x <- subset(AC.DF, select = c(Tot_Knocks, Num_L_calls, Site, Hour))

#testing for collinearity between explanatory variables
ggpairs(AC.DF.x)

#subsetting only lm variables
AC.DF.1 <- subset(AC.DF, select = c(SPL_Midrange, Tot_Knocks, Num_L_calls, Site, Hour))

vif(AC.DF.x)

#no colinnearity found between explanatory variables
ggpairs(AC.DF.1)
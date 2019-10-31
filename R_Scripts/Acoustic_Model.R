#Acoustics Model Script
## The purpose of this script is to come up with the most descriptive model for the Acoustics data, use model selection, and decide on how to best represent my data
##There should be 1 final model at the end of this

library(dplyr)
library(GGally)
library(mctest)
library(usdm)

#loading in total dataframe
load("Raw_Data/AC.DF.Rdata")
load("Raw_Data/AC.DF1.Rdata")

#### SPL_Midrange Models ####
#rough draft model formula for SPL_Midrange

#fit1 <- lm(MF_SPL ~ Knocks + Long Calls + Site + Hour, data = AC.DF) - just a draft not using actual column names
#colnames(AC.DF)
#fit1.1 <- lm(SPL_Midrange ~ Tot_Knocks + Num_L_calls + Num_Herbivory + Site + Hour, data = AC.DF)
#summary(fit1.1)
#
#
#par(mfrow=c(2,2))
#plot(fit1.1)
#
#fit1.2 <- lm(SPL_Midrange ~ Tot_Knocks + Num_L_calls + Num_Herbivory, data = AC.DF1)
#summary(fit1.2)
#
#fit1.3 <- lm(SPL_Midrange ~ Tot_Knocks, data = AC.DF1)
#summary(fit1.3)
#
#fit1.4 <- lm(SPL_Midrange ~ Num_L_calls, data = AC.DF1)
#summary(fit1.4)

## GLM because I have a gamma distribution ##
gfit1 <- glm(SPL_Midrange ~ Tot_Knocks+ Num_L_calls, data = AC.DF1, family = Gamma)
summary(gfit1)

par(mfrow = c(2,2))
plot(gfit1)


results_fit1 <- summary.glm(gfit1)$coefficients

write.csv(results_fit1, "Figures/Fit1Results.csv")



#### Testing for collinearity ####

#subsetting only explanatory variables
AC.DF.x <- subset(AC.DF, select = c(Tot_Knocks, Num_L_calls, Site, Hour))

#testing for collinearity between explanatory variables
ggpairs(AC.DF.x)

#subsetting only lm variables
AC.DF.1 <- subset(AC.DF, select = c(SPL_Midrange, Tot_Knocks, Num_L_calls, Site, Hour))

vif(AC.DF.x)

#no colinnearity found between explanatory variables
ggpairs(AC.DF.1)

#Running AIC step selection on the maximal model (fit1.1)
sfit1.1 <- step(gfit1)
summary(sfit1.1)

#### Broadband_SPL Models #####
#fit2 <- lm(BB_SPL ~ Knocks + Long Calls + Site + Hour + Snaps, data = AC.DF1) - just a draft not using actual column names
colnames(AC.DF1)
fit2 <- lm(SPL_BB ~ Tot_Knocks + Num_L_calls + Site + Hour + Snaps, data = AC.DF1)
summary(fit2)

fit3 <- lm(SPL_BB ~ Snaps + Hour + Site, data = AC.DF1)
summary(fit3)

#### HF_SPL Models ####
fit4 <- lm(SPL_HF ~ Snaps + Hour + Site, data = AC.DF1)
summary(fit4)




#### ACI Models ####

## GLM because I have a gamma distribution ##
gfit2 <- glm(ACI_Midrange ~ Tot_Knocks+ Num_L_calls + Num_Herbivory, data = AC.DF1, family = Gamma)
summary(gfit2)

par(mfrow = c(2,2))
plot(gfit2)

gfit3 <- glm(ACI_BB ~ Snaps + Tot_Knocks + Num_L_calls + Num_Herbivory + Hour + Site, data = AC.DF1, family = Gamma)
summary(gfit3)


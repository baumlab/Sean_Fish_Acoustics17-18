### Cleaning the 2015 and 2017 KI fish survey data

# Set wd


# Load required packages
library(dplyr)


### Load raw data
trophic <- read.csv("Raw_Data/Deith_CRED_FG_Allocation.csv")

# 2013
#ki_13_JG <- read.csv("Raw_Data/KI_fishsurvey_2013_JG.csv", stringsAsFactors = FALSE)
#ki_13_SC <- read.csv("Raw_Data/KI_fishsurvey_2013_SC.csv", stringsAsFactors = FALSE)
#ki_13 <- rbind(ki_13_SC, ki_13_JG)

# 2015
#ki_15_SC <- read.csv("Raw_Data/KI_fishsurvey_2015_SC.csv", stringsAsFactors = FALSE)
#ki_15_SD <- read.csv("Raw_Data/KI_fishsurvey_2015_SD.csv", stringsAsFactors = FALSE)
#ki_15 <- rbind(ki_15_SC, ki_15_SD)

# 2017
ki_17_SD <- read.csv("Raw_Data/KI_fishsurvey_2017_SD.csv", stringsAsFactors = FALSE)
ki_17_TAP <- read.csv("Raw_Data/KI_fishsurvey_2017_TAP.csv", stringsAsFactors = FALSE)
names(ki_17_SD) <- names(ki_17_TAP)
ki_17 <- rbind(ki_17_SD, ki_17_TAP)

# 2018
ki_18_SD <- read.csv("Raw_Data/KI_fishsurvey_2018_SD.csv", stringsAsFactors = FALSE)
ki_18_SF <- read.csv("Raw_Data/KI_fishsurvey_2018_SF.csv", stringsAsFactors = FALSE)
ki_18 <- rbind(ki_18_SD, ki_18_SF)

### Merge data
#$Sexual.Phase..TP..IP..juv. <- NULL
#ki_15$Sexual.Phase..TP..IP..juv. <- NULL
ki_17$Sexual.Phase..TP..IP..juv. <- NULL
ki_18$Sexual.Phase..TP..IP..juv. <- NULL


#ki_13$Year <- 2013
#ki_15$Year <- 2015
ki_17$Year <- 2017
ki_18$Year <- 2018

#matching column names
names(ki_18) <- names(ki_17)


#binding both years into one dataframe
ki_full <- rbind(ki_17, ki_18)


### Check that no data was lost in binding
dim(ki_full); dim(ki_17_SD)[1] + dim(ki_17_TAP)[1] + dim(ki_18_SD)[1] + dim(ki_18_SF)[1]


### Clean data frame
str(ki_full)
ki_full <- ki_full[!ki_full$Number == "", ] # One observation missing number
ki_full <- ki_full[!ki_full$Number == "T", ] # Removes one observation
ki_full <- ki_full[!is.na(ki_full$Size..cm.), ] # Three observations missing size
ki_full$Number <- as.numeric(ki_full$Number)
ki_full$Size..cm. <- as.numeric(ki_full$Size..cm.)
ki_full$Species.Code <- NULL # Thank God we don't have to deal with this
dim(ki_full)


### Remove data from training dives, etc.
unique(ki_full$Note)
ki_full <- ki_full[!grepl("Training", ki_full$Note), ]
ki_full <- ki_full[!grepl("Trainiing", ki_full$Note), ]
ki_full <- ki_full[!grepl("TRAINING", ki_full$Note), ]
ki_full <- ki_full[!grepl("Bad data", ki_full$Note), ]


### Clean some typos
ki_full <- ki_full[order(ki_full$Species), ]
ki_full$Species <- paste(toupper(substr(ki_full$Species, 1, 1)), substr(ki_full$Species, 2, nchar(ki_full$Species)), sep = "")

unique(ki_full$Species)

ki_full$Species[ki_full$Species == "Acanthurus achiles"] <- "Acanthurus achilles"
ki_full$Species[ki_full$Species == "Acanthurus flavicaudus"] <- "Ctenochaetus flavicauda"
ki_full$Species[ki_full$Species == "Acanthurus leucochilus"] <- "Acanthurus leucocheilus"
ki_full$Species[ki_full$Species == "Acanthurus nigricans "] <- "Acanthurus nigricans"
ki_full$Species[ki_full$Species == "Acanthurus nirgricauda"] <- "Acanthurus nigricauda"
ki_full$Species[ki_full$Species == "Acanturus nigroris"] <- "Acanthurus nigroris"
ki_full$Species[ki_full$Species == "Acanthurus olivacious"] <- "Acanthurus olivaceus"
ki_full$Species[ki_full$Species == "Acanthurus tricolor "] <- "Scarus tricolor"
ki_full$Species[ki_full$Species == "Apogon angustus"] <- "Ostorhinchus angustatus"
ki_full$Species[ki_full$Species == "Apogon apogonides"] <- "Ostorhinchus apogonoides"
ki_full$Species[ki_full$Species == "Arothron caruleopunctatus"] <- "Arothron caeruleopunctatus"
ki_full$Species[ki_full$Species == "BAlistapus undulatus"] <- "Balistapus undulatus"
ki_full$Species[ki_full$Species == "Blenniid sp."] <- "Blenniidae sp"
ki_full$Species[ki_full$Species == "Unknown Blenniidae"] <- "Blenniidae sp"
ki_full$Species[ki_full$Species == "Cantherhines dumerelii"] <- "Cantherhines dumerilii"
ki_full$Species[ki_full$Species == "Centropyger loricula"] <- "Centropyge loricula"
ki_full$Species[ki_full$Species == "Centropygi loricula"] <- "Centropyge loricula"
ki_full$Species[ki_full$Species == "Cephalopholis hexagonatus"] <- "Epinephelus hexagonatus"
ki_full$Species[ki_full$Species == "Cephalopholis minita"] <- "Cephalopholis miniata"
ki_full$Species[ki_full$Species == "Cephaloppholis miniata"] <- "Cephalopholis miniata"
ki_full$Species[ki_full$Species == "Cephalopholis urodeta "] <- "Cephalopholis urodeta"
ki_full$Species[ki_full$Species == "Chaetodon citronelis"] <- "Chaetodon citrinellus"
ki_full$Species[ki_full$Species == "Chaetodon kleini"] <- "Chaetodon kleinii"
ki_full$Species[ki_full$Species == "Chaetodon loricula"] <- "Centropyge loricula"
ki_full$Species[ki_full$Species == "Chaetodon vagabundas"] <- "Chaetodon vagabundus"
ki_full$Species[ki_full$Species == "Chelinus trilobatus"] <- "Cheilinus trilobatus"
ki_full$Species[ki_full$Species == "Chlorurus spp."] <- "Chlorurus sp."
ki_full$Species[ki_full$Species == "Chromis ternatenis "] <- "Chromis ternatensis"
ki_full$Species[ki_full$Species == "Chhromis vanderbilti"] <- "Chromis vanderbilti"
ki_full$Species[ki_full$Species == "Chromis xanth"] <- "Chromis xanthura"
ki_full$Species[ki_full$Species == "Cirrhitichthys oxycephalis"] <- "Cirrhitichthys oxycephalus"
ki_full$Species[ki_full$Species == "Cirripectes spp."] <- "Cirripectes sp."
ki_full$Species[ki_full$Species == "Coris Centralis"] <- "Coris centralis"
ki_full$Species[ki_full$Species == "Ctenochaetus cyanocheilus "] <- "Ctenochaetus cyanocheilus"
ki_full$Species[ki_full$Species == "Ctenochaetus flavissimus"] <- "Ctenochaetus striatus"
ki_full$Species[ki_full$Species == "Enchelychore pardalis"] <- "Enchelycore pardalis"
ki_full$Species[ki_full$Species == "Epinephelus miniata"] <- "Cephalopholis miniata"
ki_full$Species[ki_full$Species == "Epinephalis spilotoceps"] <- "Epinephelus spilotoceps"
ki_full$Species[ki_full$Species == "Epinephelos spilotoceps"] <- "Epinephelus spilotoceps"
ki_full$Species[ki_full$Species == "Eviola cometa"] <- "Eviota cometa"
ki_full$Species[ki_full$Species == "Forcipiger longorostris"] <- "Forcipiger longirostris"
ki_full$Species[ki_full$Species == "Gobiid sp"] <- "Gobiidae sp"
ki_full$Species[ki_full$Species == "Gomphosis varius"] <- "Gomphosus varius"
ki_full$Species[ki_full$Species == "Gracila albomarinata"] <- "Gracila albomarginata"
ki_full$Species[ki_full$Species == "Gracila albomarginata\n\n"] <- "Gracila albomarginata"
ki_full$Species[ki_full$Species == "Gymnothorax species"] <- "Gymnothorax sp"
ki_full$Species[ki_full$Species == "Gymnothorax thrysoideus"] <- "Gymnothorax thyrsoideus"
ki_full$Species[ki_full$Species == "Iniistius auropuctatus"] <- "Iniistius auropunctatus"
ki_full$Species[ki_full$Species == "Labrid sp."] <- "Labridae sp"
ki_full$Species[ki_full$Species == "Labroides rubroviolacious"] <- "Labroides rubrolabiatus"
ki_full$Species[ki_full$Species == "Lethrines meleagris"] <- "Lethrinus olivaceus"
ki_full$Species[ki_full$Species == "Lutjanus monotaxis"] <- "Lutjanus monostigma"
ki_full$Species[ki_full$Species == "MAcropharyngodon meleagris"] <- "Macropharyngodon meleagris"
ki_full$Species[ki_full$Species == "Melicthys niger"] <- "Melichthys niger"
ki_full$Species[ki_full$Species == "Melicthys vidua"] <- "Melichthys vidua"
ki_full$Species[ki_full$Species == "Myripristis tiere"] <- "Sargocentron tiere"
ki_full$Species[ki_full$Species == "Ostorhinchus apogonides"] <- "Ostorhinchus apogonoides"
ki_full$Species[ki_full$Species == "Oxycheilinus diagrammus"] <- "Oxycheilinus digramma"
ki_full$Species[ki_full$Species == "Paracanthus hepatus"] <- "Paracanthurus hepatus"
ki_full$Species[ki_full$Species == "Paracirrhites xanthus?"] <- "Paracirrhites xanthus"
ki_full$Species[ki_full$Species == "Parapercis spp."] <- "Parapercis sp."
ki_full$Species[ki_full$Species == "Parupeneus cyclostomas"] <- "Parupeneus cyclostomus"
ki_full$Species[ki_full$Species == "PArupeneus insularis"] <- "Parupeneus insularis"
ki_full$Species[ki_full$Species == "Parupeneus mimicus"] <- "Mulloidichthys mimicus"
ki_full$Species[ki_full$Species == "Parupeneus multifaciatus"] <- "Parupeneus multifasciatus"
ki_full$Species[ki_full$Species == "Parupeneus pleurostrigma"] <- "Parupeneus pleurostigma"
ki_full$Species[ki_full$Species == "Pempheris oulensis"] <- "Pempheris oualensis"
ki_full$Species[ki_full$Species == "Pervagor aspricauda"] <- "Pervagor aspricaudus"
ki_full$Species[ki_full$Species == "Plagiotremis sp."] <- "Plagiotremus sp."
ki_full$Species[ki_full$Species == "Plagiotremus species"] <- "Plagiotremus sp."
ki_full$Species[ki_full$Species == "PLectroglyphidodon dickii"] <- "Plectroglyphidodon dickii"
ki_full$Species[ki_full$Species == "Pseudocheilinus evanides"] <- "Pseudocheilinus evanidus"
ki_full$Species[ki_full$Species == "Pseduocheilnus octotaenia"] <- "Pseudocheilinus octotaenia"
ki_full$Species[ki_full$Species == "Pseudanthias hexataniea"] <- "Pseudocheilinus hexataenia"
ki_full$Species[ki_full$Species == "Pteroleotris zebra"] <- "Ptereleotris zebra"
ki_full$Species[ki_full$Species == "Caesio tile"] <- "Pterocaesio tile"
ki_full$Species[ki_full$Species == "Pterocaesio spp."] <- "Pterocaesio sp."
ki_full$Species[ki_full$Species == "Scorpaenidae sp."] <- "Pterois sp."
ki_full$Species[ki_full$Species == "Sargocentron tiare"] <- "Sargocentron tiere"
ki_full$Species[ki_full$Species == "Scarus frenatus "] <- "Scarus frenatus"
ki_full$Species[ki_full$Species == "Scarus frontalis"] <- "Chlorurus frontalis"
ki_full$Species[ki_full$Species == "Scarus ghobon"] <- "Scarus ghobban"
ki_full$Species[ki_full$Species == "Sccarus oviceps"] <- "Scarus oviceps"
ki_full$Species[ki_full$Species == "Scarus rubrovioulacious"] <- "Scarus rubroviolaceus"
ki_full$Species[ki_full$Species == "Scombroides lysan"] <- "Scomberoides lysan"
ki_full$Species[ki_full$Species == "Unknown Scorpaenidae"] <- "Scorpaenidae sp."
ki_full$Species[ki_full$Species == "Stegastes fasciatus"] <- "Stegastes fasciolatus"
ki_full$Species[ki_full$Species == "Sufflamen fraenatus"] <- "Sufflamen fraenatum"
ki_full$Species[ki_full$Species == "Synchiropus ocellatus"] <- "Neosynchiropus ocellatus"
ki_full$Species[ki_full$Species == "Synodus sp"] <- "Synodus sp."
ki_full$Species[ki_full$Species == "Thalassoma quinquevittatum\n"] <- "Thalassoma quinquevittatum"
ki_full$Species[ki_full$Species == "Variola lauti"] <- "Variola louti"

unique(ki_full$Species)


### Add length-weight data
load('R_Scripts/TMPwd.Rdata')
cred <- wd

ki_full$lw_a <- cred$LW_A[match(ki_full$Species, cred$SCIENTIFIC_NAME)]
ki_full$lw_b <- cred$LW_B[match(ki_full$Species, cred$SCIENTIFIC_NAME)]
ki_full$LENGTH_CONVERSION_FACTOR <- cred$LENGTH_CONVERSION_FACTOR[match(ki_full$Species, cred$SCIENTIFIC_NAME)]

# See which species are missing l-w data
dim(ki_full[is.na(ki_full$lw_a),] )
unique(ki_full$Species[is.na(ki_full$lw_a)] )
sum(as.numeric(ki_full$Number[is.na(ki_full$lw_a)] ), na.rm = TRUE) # 294 rows (36 species)


### Add Fishbase parameters for species not in CRED dataset
ki_full$lw_a[ki_full$Species == "Arothron caeruleopunctatus"] <- 0.02692
ki_full$lw_b[ki_full$Species == "Arothron caeruleopunctatus"] <- 2.88
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Arothron caeruleopunctatus"] <- 1

ki_full$lw_a[ki_full$Species == "Bothus pantherinus"] <- 0.00912
ki_full$lw_b[ki_full$Species == "Bothus pantherinus"] <- 3.07
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Bothus pantherinus"] <- 1

ki_full$lw_a[ki_full$Species == "Chromis atripes"] <- 0.0229
ki_full$lw_b[ki_full$Species == "Chromis atripes"] <- 3.175
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Chromis atripes"] <- 1

ki_full$lw_a[ki_full$Species == "Cirripectes auritus"] <- 0.00741
ki_full$lw_b[ki_full$Species == "Cirripectes auritus"] <- 3.00
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Cirripectes auritus"] <- 1

ki_full$lw_a[ki_full$Species == "Eviota albolineata"] <- 0.00631
ki_full$lw_b[ki_full$Species == "Eviota albolineata"] <- 3.08
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Eviota albolineata"] <- 1

ki_full$lw_a[ki_full$Species == "Eviota cometa"] <- 0.00891
ki_full$lw_b[ki_full$Species == "Eviota cometa"] <- 3.08
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Eviota cometa"] <- 1

ki_full$lw_a[ki_full$Species == "Gnatholepis anjerensis"] <- 0.00871
ki_full$lw_b[ki_full$Species == "Gnatholepis anjerensis"] <- 3.05
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Gnatholepis anjerensis"] <- 1

ki_full$lw_a[ki_full$Species == "Gymnothorax thyrsoideus"] <- 0.0005
ki_full$lw_b[ki_full$Species == "Gymnothorax thyrsoideus"] <- 3.303
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Gymnothorax thyrsoideus"] <- 1

ki_full$lw_a[ki_full$Species == "Iniistius auropunctatus"] <- 0.01122
ki_full$lw_b[ki_full$Species == "Iniistius auropunctatus"] <- 3.04
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Iniistius auropunctatus"] <- 1

ki_full$lw_a[ki_full$Species == "Neosynchiropus ocellatus"] <- 0.01047
ki_full$lw_b[ki_full$Species == "Neosynchiropus ocellatus"] <- 2.96
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Neosynchiropus ocellatus"] <- 1

ki_full$lw_a[ki_full$Species == "Ostorhinchus angustatus"] <- 0.01479
ki_full$lw_b[ki_full$Species == "Ostorhinchus angustatus"] <- 3.07
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Ostorhinchus angustatus"] <- 1

ki_full$lw_a[ki_full$Species == "Ostorhinchus apogonoides"] <- 0.01479
ki_full$lw_b[ki_full$Species == "Ostorhinchus apogonoides"] <- 3.07
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Ostorhinchus apogonoides"] <- 1

ki_full$lw_a[ki_full$Species == "Oxycheilinus diagramma"] <- 0.01950
ki_full$lw_b[ki_full$Species == "Oxycheilinus diagramma"] <- 2.95
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Oxycheilinus diagramma"] <- 1

ki_full$lw_a[ki_full$Species == "Parapercis lata"] <- 0.0133
ki_full$lw_b[ki_full$Species == "Parapercis lata"] <- 2.943
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Parapercis lata"] <- 1

ki_full$lw_a[ki_full$Species == "Priacanthus hamrur"] <- 0.03
ki_full$lw_b[ki_full$Species == "Priacanthus hamrur"] <- 2.801
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Priacanthus hamrur"] <- 1

ki_full$lw_a[ki_full$Species == "Pterocaesio lativittata"] <- 0.0092
ki_full$lw_b[ki_full$Species == "Pterocaesio lativittata"] <- 3.234
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species=="Pterocaesio lativittata"] <- 1

ki_full$lw_a[ki_full$Species == "Synodus jaculum"] <- 0.0085
ki_full$lw_b[ki_full$Species == "Synodus jaculum"] <- 3.078
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Synodus jaculum"] <- 1

ki_full$lw_a[ki_full$Species == "Valenciennea helsdingenii"] <- 0.0104
ki_full$lw_b[ki_full$Species == "Valenciennea helsdingenii"] <- 2.859
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Valenciennea helsdingenii"] <- 1


### Assign fish identified to genus or Family with mean l-w parameters
ki_full$lw_a[ki_full$Species == "Blenniidae sp"] <- mean(cred$LW_A[grepl("Blenniella", cred$SCIENTIFIC_NAME)])
ki_full$lw_b[ki_full$Species == "Blenniidae sp"] <- mean(cred$LW_B[grepl("Blenniella", cred$SCIENTIFIC_NAME)])
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Blenniidae sp"] <- mean(cred$LENGTH_CONVERSION_FACTOR[grepl("Blenniella", cred$SCIENTIFIC_NAME)])

ki_full$lw_a[ki_full$Species == "Chlorurus sp."] <- mean(cred$LW_A[grepl("Chlorurus", cred$SCIENTIFIC_NAME)])
ki_full$lw_b[ki_full$Species == "Chlorurus sp."] <- mean(cred$LW_B[grepl("Chlorurus", cred$SCIENTIFIC_NAME)])
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Chlorurus sp."] <- mean(cred$LENGTH_CONVERSION_FACTOR[grepl("Chlorurus", cred$SCIENTIFIC_NAME)])

ki_full$lw_a[ki_full$Species == "Cirripectes sp."] <- mean(cred$LW_A[grepl("Cirripectes", cred$SCIENTIFIC_NAME)])
ki_full$lw_b[ki_full$Species == "Cirripectes sp."] <- mean(cred$LW_B[grepl("Cirripectes", cred$SCIENTIFIC_NAME)])
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Cirripectes sp."] <- mean(cred$LENGTH_CONVERSION_FACTOR[grepl("Cirripectes", cred$SCIENTIFIC_NAME)])

ki_full$lw_a[ki_full$Species == "Epinephelus sp."] <- mean(cred$LW_A[grepl("Epinephelus", cred$SCIENTIFIC_NAME)])
ki_full$lw_b[ki_full$Species == "Epinephelus sp."] <- mean(cred$LW_B[grepl("Epinephelus", cred$SCIENTIFIC_NAME)])
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Epinephelus sp."] <- mean(cred$LENGTH_CONVERSION_FACTOR[grepl("Epinephelus", cred$SCIENTIFIC_NAME)])

ki_full$lw_a[ki_full$Species == "Gobiidae sp"] <- mean(cred$LW_A[grepl("Gobiidae", cred$SCIENTIFIC_NAME)])
ki_full$lw_b[ki_full$Species == "Gobiidae sp"] <- mean(cred$LW_B[grepl("Gobiidae", cred$SCIENTIFIC_NAME)])
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Gobiidae sp"] <- mean(cred$LENGTH_CONVERSION_FACTOR[grepl("Gobiidae", cred$SCIENTIFIC_NAME)])

ki_full$lw_a[ki_full$Species == "Halichoeres sp."] <- mean(cred$LW_A[grepl("Halichoeres", cred$SCIENTIFIC_NAME)])
ki_full$lw_b[ki_full$Species == "Halichoeres sp."] <- mean(cred$LW_B[grepl("Halichoeres", cred$SCIENTIFIC_NAME)])
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Halichoeres sp."] <- mean(cred$LENGTH_CONVERSION_FACTOR[grepl("Halichoeres", cred$SCIENTIFIC_NAME)])

ki_full$lw_a[ki_full$Species == "Labridae sp"] <- mean(cred$LW_A[grepl("Labroides", cred$SCIENTIFIC_NAME)])
ki_full$lw_b[ki_full$Species == "Labridae sp"] <- mean(cred$LW_B[grepl("Labroides", cred$SCIENTIFIC_NAME)])
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Labridae sp"] <- mean(cred$LENGTH_CONVERSION_FACTOR[grepl("Labroides", cred$SCIENTIFIC_NAME)])

ki_full$lw_a[ki_full$Species == "Naso sp"] <- mean(cred$LW_A[grepl("Naso", cred$SCIENTIFIC_NAME)])
ki_full$lw_b[ki_full$Species == "Naso sp"] <- mean(cred$LW_B[grepl("Naso", cred$SCIENTIFIC_NAME)])
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Naso sp"] <- mean(cred$LENGTH_CONVERSION_FACTOR[grepl("Naso", cred$SCIENTIFIC_NAME)])

ki_full$lw_a[ki_full$Species == "Parapercis sp."] <- mean(cred$LW_A[grepl("Parapercis", cred$SCIENTIFIC_NAME)])
ki_full$lw_b[ki_full$Species == "Parapercis sp."] <- mean(cred$LW_B[grepl("Parapercis", cred$SCIENTIFIC_NAME)])
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Parapercis sp."] <- mean(cred$LENGTH_CONVERSION_FACTOR[grepl("Parapercis", cred$SCIENTIFIC_NAME)])

ki_full$lw_a[ki_full$Species == "Pervagor sp"] <- mean(cred$LW_A[grepl("Pervagor", cred$SCIENTIFIC_NAME)])
ki_full$lw_b[ki_full$Species == "Pervagor sp"] <- mean(cred$LW_B[grepl("Pervagor", cred$SCIENTIFIC_NAME)])
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Pervagor sp"] <- mean(cred$LENGTH_CONVERSION_FACTOR[grepl("Pervagor", cred$SCIENTIFIC_NAME)])

ki_full$lw_a[ki_full$Species == "Plagiotremus sp."] <- mean(cred$LW_A[grepl("Plagiotremus", cred$SCIENTIFIC_NAME)])
ki_full$lw_b[ki_full$Species == "Plagiotremus sp."] <- mean(cred$LW_B[grepl("Plagiotremus", cred$SCIENTIFIC_NAME)])
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Plagiotremus sp."] <- mean(cred$LENGTH_CONVERSION_FACTOR[grepl("Plagiotremus", cred$SCIENTIFIC_NAME)])

ki_full$lw_a[ki_full$Species == "Pseudanthias sp"] <- mean(cred$LW_A[grepl("Pseudanthias", cred$SCIENTIFIC_NAME)])
ki_full$lw_b[ki_full$Species == "Pseudanthias sp"] <- mean(cred$LW_B[grepl("Pseudanthias", cred$SCIENTIFIC_NAME)])
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Pseudanthias sp"] <- mean(cred$LENGTH_CONVERSION_FACTOR[grepl("Pseudanthias", cred$SCIENTIFIC_NAME)])

ki_full$lw_a[ki_full$Species == "Ptereleotris sp"] <- mean(cred$LW_A[grepl("Ptereleotris", cred$SCIENTIFIC_NAME)])
ki_full$lw_b[ki_full$Species == "Ptereleotris sp"] <- mean(cred$LW_B[grepl("Ptereleotris", cred$SCIENTIFIC_NAME)])
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Ptereleotris sp"] <- mean(cred$LENGTH_CONVERSION_FACTOR[grepl("Ptereleotris", cred$SCIENTIFIC_NAME)])

ki_full$lw_a[ki_full$Species == "Pterocaesio sp."] <- mean(cred$LW_A[grepl("Pterocaesio", cred$SCIENTIFIC_NAME)])
ki_full$lw_b[ki_full$Species == "Pterocaesio sp."] <- mean(cred$LW_B[grepl("Pterocaesio", cred$SCIENTIFIC_NAME)])
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Pterocaesio sp."] <- mean(cred$LENGTH_CONVERSION_FACTOR[grepl("Pterocaesio", cred$SCIENTIFIC_NAME)])

ki_full$lw_a[ki_full$Species == "Pterois sp."] <- mean(cred$LW_A[grepl("Pterois", cred$SCIENTIFIC_NAME)])
ki_full$lw_b[ki_full$Species == "Pterois sp."] <- mean(cred$LW_B[grepl("Pterois", cred$SCIENTIFIC_NAME)])
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Pterois sp."] <- mean(cred$LENGTH_CONVERSION_FACTOR[grepl("Pterois", cred$SCIENTIFIC_NAME)])

ki_full$lw_a[ki_full$Species == "Synodus sp."] <- mean(cred$LW_A[grepl("Synodus", cred$SCIENTIFIC_NAME)])
ki_full$lw_b[ki_full$Species == "Synodus sp."] <- mean(cred$LW_B[grepl("Synodus", cred$SCIENTIFIC_NAME)])
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Synodus sp."] <- mean(cred$LENGTH_CONVERSION_FACTOR[grepl("Synodus", cred$SCIENTIFIC_NAME)])

ki_full$lw_a[ki_full$Species == "Valenciennea sp."] <- mean(cred$LW_A[grepl("Valenciennea", cred$SCIENTIFIC_NAME)])
ki_full$lw_b[ki_full$Species == "Valenciennea sp."] <- mean(cred$LW_B[grepl("Valenciennea", cred$SCIENTIFIC_NAME)])
ki_full$LENGTH_CONVERSION_FACTOR[ki_full$Species == "Valenciennea sp."] <- mean(cred$LENGTH_CONVERSION_FACTOR[grepl("Valenciennea", cred$SCIENTIFIC_NAME)])

dim(ki_full[is.na(ki_full$lw_a),] )
unique(ki_full$Species[is.na(ki_full$lw_a)] )

### L/W DATA COMPLETE FOR ALL SPECIES!!! ###


### Add Family info
ki_full$Family <- as.character(trophic$X[match(ki_full$Species, trophic$CREDSpecies)])
dim(ki_full[is.na(ki_full$Family),])

# Add in Family info for species not in 'trophic' dataset
unique(ki_full$Species[is.na(ki_full$Family)])

ki_full$Family[ki_full$Species == "Arothron caeruleopunctatus"] <- "Tetraodontidae"
ki_full$Family[ki_full$Species == "Bothus pantherinus"] <- "Bothidae"
ki_full$Family[ki_full$Species == "Chlorurus sp."] <- "Scaridae"
ki_full$Family[ki_full$Species == "Chromis atripes"] <- "Pomacentridae"
ki_full$Family[ki_full$Species == "Cirripectes auritus"] <- "Blenniidae"
ki_full$Family[ki_full$Species == "Cirripectes sp."] <- "Blenniidae"
ki_full$Family[ki_full$Species == "Epinephelus sp."] <- "Serranidae"
ki_full$Family[ki_full$Species == "Eviota cometa"] <- "Gobiidae"
ki_full$Family[ki_full$Species == "Gnatholepis anjerensis"] <- "Gobiidae"
ki_full$Family[ki_full$Species == "Gymnothorax thyrsoideus"] <- "Muraenidae"
ki_full$Family[ki_full$Species == "Halichoeres sp."] <- "Labridae"
ki_full$Family[ki_full$Species == "Halichoeres chrysus"] <- "Labridae"
ki_full$Family[ki_full$Species == "Iniistius auropunctatus"] <- "Labridae"
ki_full$Family[ki_full$Species == "Kyphosus sp"] <- "Kyphosidae"
ki_full$Family[ki_full$Species == "Neosynchiropus ocellatus"] <- "Callionymidae"
ki_full$Family[ki_full$Species == "Ostorhinchus angustatus"] <- "Apogonidae"
ki_full$Family[ki_full$Species == "Ostorhinchus apogonoides"] <- "Apogonidae"
ki_full$Family[ki_full$Species == "Parapercis lata"] <- "Pinguipedidae"
ki_full$Family[ki_full$Species == "Parapercis sp."] <- "Pinguipedidae"
ki_full$Family[ki_full$Species == "Plagiotremus sp."] <- "Blenniidae"
ki_full$Family[ki_full$Species == "Priacanthus hamrur"] <- "Priacanthidae"
ki_full$Family[ki_full$Species == "Pseudanthias sp"] <- "Serranidae"
ki_full$Family[ki_full$Species == "Ptereleotris sp"] <- "Microdesmidae"
ki_full$Family[ki_full$Species == "Pterocaesio sp."] <- "Caesionidae"
ki_full$Family[ki_full$Species == "Pterocaesio lativittata"] <- "Caesionidae"
ki_full$Family[ki_full$Species == "Pterois sp."] <- "Scorpaenidae"
ki_full$Family[ki_full$Species == "Synodus jaculum"] <- "Synodontidae"
ki_full$Family[ki_full$Species == "Synodus sp."] <- "Synodontidae"
ki_full$Family[ki_full$Species == "Valenciennea sp."] <- "Gobiidae"
ki_full$Family[ki_full$Species == "Valenciennea helsdingenii"] <- "Gobiidae"

unique(ki_full$Species[is.na(ki_full$Family)])


### Add functional group data
ki_full$CoarseFG <- as.character(trophic$CoarseFG[match(ki_full$Species, trophic$CREDSpecies)])
ki_full$FineFG <- as.character(trophic$FineFG[match(ki_full$Species, trophic$CREDSpecies)])


# Add in CoarseFG info for species not in 'trophic' dataset
dim(ki_full[is.na(ki_full$CoarseFG),])
unique(ki_full$Species[is.na(ki_full$CoarseFG)])

ki_full$CoarseFG[ki_full$Species == "Arothron caeruleopunctatus"] <- "Omnivore"
ki_full$CoarseFG[ki_full$Species == "Bothus pantherinus"] <- "Carnivore"
ki_full$CoarseFG[ki_full$Species == "Chlorurus sp."] <- "Herbivore"
ki_full$CoarseFG[ki_full$Species == "Chromis atripes"] <- "Planktivore"
ki_full$CoarseFG[ki_full$Species == "Cirripectes auritus"] <- "Herbivore"
ki_full$CoarseFG[ki_full$Species == "Cirripectes sp."] <- "Herbivore"
ki_full$CoarseFG[ki_full$Species == "Epinephelus sp."] <- "Carnivore"
ki_full$CoarseFG[ki_full$Species == "Eviota cometa"] <- "Planktivore"
ki_full$CoarseFG[ki_full$Species == "Gnatholepis anjerensis"] <- "Carnivore"
ki_full$CoarseFG[ki_full$Species == "Gobiidae sp"] <- "NA"
ki_full$CoarseFG[ki_full$Species == "Gymnothorax thyrsoideus"] <- "Carnivore"
ki_full$CoarseFG[ki_full$Species == "Halichoeres sp."] <- "Carnivore"
ki_full$CoarseFG[ki_full$Species == "Halichoeres chrysus"] <- "Carnivore"
ki_full$CoarseFG[ki_full$Species == "Iniistius auropunctatus"] <- "Carnivore"
ki_full$CoarseFG[ki_full$Species == "Kyphosus sp"] <- "Herbivore"
ki_full$CoarseFG[ki_full$Species == "Naso sp"] <- "NA"
ki_full$CoarseFG[ki_full$Species == "Neosynchiropus ocellatus"] <- "Carnivore"
ki_full$CoarseFG[ki_full$Species == "Ostorhinchus angustatus"] <- "Planktivore"
ki_full$CoarseFG[ki_full$Species == "Ostorhinchus apogonoides"] <- "Planktivore"
ki_full$CoarseFG[ki_full$Species == "Parapercis sp."] <- "Carnivore"
ki_full$CoarseFG[ki_full$Species == "Parapercis lata"] <- "Carnivore"
ki_full$CoarseFG[ki_full$Species == "Plagiotremus sp."] <- "Carnivore"
ki_full$CoarseFG[ki_full$Species == "Priacanthus hamrur"] <- "Planktivore"
ki_full$CoarseFG[ki_full$Species == "Pseudanthias sp"] <- "Planktivore"
ki_full$CoarseFG[ki_full$Species == "Ptereleotris sp"] <- "Planktivore"
ki_full$CoarseFG[ki_full$Species == "Pterocaesio sp."] <- "Planktivore"
ki_full$CoarseFG[ki_full$Species == "Pterocaesio lativittata"] <- "Planktivore"
ki_full$CoarseFG[ki_full$Species == "Pterois sp."] <- "Carnivore"
ki_full$CoarseFG[ki_full$Species == "Synodus jaculum"] <- "Carnivore"
ki_full$CoarseFG[ki_full$Species == "Synodus sp."] <- "Carnivore"
ki_full$CoarseFG[ki_full$Species == "Valenciennea sp."] <- "Carnivore"
ki_full$CoarseFG[ki_full$Species == "Valenciennea helsdingenii"] <- "Carnivore"
# Too much variation within Family/genus to assign CoarseFG to Gobiidae sp or Naso sp

unique(ki_full$Species[is.na(ki_full$CoarseFG)])


# Add in FineFG info for species not in 'trophic' dataset
unique(ki_full$Species[is.na(ki_full$FineFG)])

ki_full$FineFG[ki_full$Species == "Acanthurus sp"] <- "Cropper"
ki_full$FineFG[ki_full$Species == "Arothron caeruleopunctatus"] <- "Benthic intertivore"
ki_full$FineFG[ki_full$Species == "Bothus pantherinus"] <- "Generalist carnivore"
ki_full$FineFG[ki_full$Species == "Chlorurus sp."] <- "Excavator"
ki_full$FineFG[ki_full$Species == "Chromis atripes"] <- "Diurnal planktivore"
ki_full$FineFG[ki_full$Species == "Cirripectes auritus"] <- "Cropper"
ki_full$FineFG[ki_full$Species == "Cirripectes sp."] <- "Cropper"
ki_full$FineFG[ki_full$Species == "Epinephelus sp."] <- "Diurnal piscivore"
ki_full$FineFG[ki_full$Species == "Eviota cometa"] <- "Diurnal planktivore"
ki_full$FineFG[ki_full$Species == "Gnatholepis anjerensis"] <- "Benthic omnivore"
ki_full$FineFG[ki_full$Species == "Gobiidae sp"] <- "NA"
ki_full$FineFG[ki_full$Species == "Gymnothorax thyrsoideus"] <- "Generalist carnivore"
ki_full$FineFG[ki_full$Species == "Halichoeres sp."] <- "Invertivore"
ki_full$FineFG[ki_full$Species == "Halichoeres chrysus"] <- "Invertivore"
ki_full$FineFG[ki_full$Species == "Iniistius auropunctatus"] <- "Invertivore"
ki_full$FineFG[ki_full$Species == "Kyphosus sp"] <- "Browser"
ki_full$FineFG[ki_full$Species == "Labridae sp"] <- "NA"
ki_full$FineFG[ki_full$Species == "Naso sp"] <- "NA"
ki_full$FineFG[ki_full$Species == "Neosynchiropus ocellatus"] <- "Invertivore"
ki_full$FineFG[ki_full$Species == "Ostorhinchus angustatus"] <- "Nocturnal planktivore"
ki_full$FineFG[ki_full$Species == "Ostorhinchus apogonoides"] <- "Nocturnal planktivore"
ki_full$FineFG[ki_full$Species == "Parapercis sp."] <- "Generalist carnivore"
ki_full$FineFG[ki_full$Species == "Parapercis lata"] <- "Generalist carnivore"
ki_full$FineFG[ki_full$Species == "Plagiotremus sp."] <- "Diurnal piscivore"
ki_full$FineFG[ki_full$Species == "Priacanthus hamrur"] <- "Nocturnal planktivore"
ki_full$FineFG[ki_full$Species == "Pseudanthias sp"] <- "Diurnal planktivore"
ki_full$FineFG[ki_full$Species == "Ptereleotris sp"] <- "Diurnal planktivore"
ki_full$FineFG[ki_full$Species == "Pterocaesio sp."] <- "Diurnal planktivore"
ki_full$FineFG[ki_full$Species == "Pterocaesio lativittata"] <- "Diurnal planktivore"
ki_full$FineFG[ki_full$Species == "Pterois sp."] <- "Generalist carnivore"
ki_full$FineFG[ki_full$Species == "Synodus jaculum"] <- "Diurnal piscivore"
ki_full$FineFG[ki_full$Species == "Synodus sp."] <- "Diurnal piscivore"
ki_full$FineFG[ki_full$Species == "Valenciennea sp."] <- "Invertivore"
ki_full$FineFG[ki_full$Species == "Valenciennea helsdingenii"] <- "Invertivore"
# Too much variation within Family/genus to assign FineFG to Gobiidae sp, Labridae sp, Naso sp

unique(ki_full$Species[is.na(ki_full$FineFG)])


# Specify corallivore groupings (oblivate vs. facultative)
unique(ki_full$Species[ki_full$FineFG == "Corallivore"])

# ki_full$FineFG[ki_full$Species == "Amanses scopas"] <- "corallivore"
ki_full$FineFG[ki_full$Species == "Arothron meleagris"] <- "Obligate corallivore"
ki_full$FineFG[ki_full$Species == "Cantherhines dumerilii"] <- "Obligate corallivore"
ki_full$FineFG[ki_full$Species == "Chaetodon auriga"] <- "Facultative corallivore"
ki_full$FineFG[ki_full$Species == "Chaetodon bennetti"] <- "Obligate corallivore"
ki_full$FineFG[ki_full$Species == "Chaetodon citrinellus"] <- "Facultative corallivore"
ki_full$FineFG[ki_full$Species == "Chaetodon ephippium"] <- "Facultative corallivore"
ki_full$FineFG[ki_full$Species == "Chaetodon kleinii"] <- "Facultative corallivore"
ki_full$FineFG[ki_full$Species == "Chaetodon lunulatus"] <- "Obligate corallivore"
ki_full$FineFG[ki_full$Species == "Chaetodon meyeri"] <- "Obligate corallivore"
ki_full$FineFG[ki_full$Species == "Chaetodon ornatissimus"] <- "Obligate corallivore"
ki_full$FineFG[ki_full$Species == "Chaetodon pelewensis"] <- "Facultative corallivore"
ki_full$FineFG[ki_full$Species == "Chaetodon quadrimaculatus"] <- "Facultative corallivore"
ki_full$FineFG[ki_full$Species == "Chaetodon trifascialis"] <- "Obligate corallivore"
ki_full$FineFG[ki_full$Species == "Chaetodon unimaculatus"] <- "Obligate corallivore"
ki_full$FineFG[ki_full$Species == "Chaetodon vagabundus"] <- "Facultative corallivore"
ki_full$FineFG[ki_full$Species == "Heniochus chrysostomus"] <- " Facultative corallivore"
ki_full$FineFG[ki_full$Species == "Labrichthys unilineatus"] <- "Obligate corallivore"
ki_full$FineFG[ki_full$Species == "Plectroglyphidodon johnstonianus"] <- "Obligate corallivore"

unique(ki_full$Species[is.na(ki_full$FineFG)])


### Now add mass estimates
# Add mass values from length-weight relationships
ki_full$length <- ki_full$Size..cm.*ki_full$LENGTH_CONVERSION_FACTOR
ki_full$MASS <- round(with(ki_full, lw_a*(length)^lw_b), digits = 2)

dim(ki_full[is.na(ki_full$MASS), ])
unique(ki_full$Species[is.na(ki_full$MASS)])


### Add site data
sites <- read.csv("Raw_Data/ki_sites_updatedMay2018_newFPressure_KLT_msc.csv")

head(sites)

ki_full$f.pressure <- factor(sites$f.pressure[match(ki_full$Site, sites$site)])
ki_full$lat <- sites$lat[match(ki_full$Site, sites$site)]
ki_full$lon <- sites$lon[match(ki_full$Site, sites$site)]
ki_full$prod <- sites$smw.prod[match(ki_full$Site, sites$site)]


### Fix a few dates
#ki_full$KI.Date[ki_full$KI.Date == "21_07_13"] <- "21_07_2013"
#ki_full$KI.Date[ki_full$KI.Date == "22_07_13"] <- "22_07_2013"
#ki_full$KI.Date[ki_full$KI.Date == "24_07_13"] <- "24_07_2013"
#ki_full$KI.Date[ki_full$KI.Date == "25_07_13"] <- "25_07_2013"
#ki_full$KI.Date[ki_full$KI.Date == "4_07_2015"] <- "04_07_2015"
#ki_full$KI.Date[ki_full$KI.Date == "5_07_2015"] <- "05_07_2015"
#ki_full$KI.Date[ki_full$KI.Date == " 06_07_2015"] <- "06_07_2015"
unique(ki_full$KI.Date)


### Create unique codes for each date/site/transect combo
ki_full$unique.site <- paste(ki_full$KI.Date, ki_full$Transect, ki_full$Site, sep = "_")
unique(ki_full$unique.site)


### Get variables in the correct class
head(ki_full)
str(ki_full)

ki_full$Site <- as.factor(ki_full$Site)
ki_full$Observer <- as.factor(ki_full$Observer)
ki_full$Transect <- as.factor(ki_full$Transect)
ki_full$Year <- as.factor(ki_full$Year)
ki_full$f.pressure <- as.factor(ki_full$f.pressure)


### Need to correct abundances of small fish for smaller survey area
ki_small <- ki_full[ki_full$length < 20, ]
ki_large <- ki_full[ki_full$length >= 20, ]

### Need to double ki small to account for smaller survey area (300m2 compared to 600m2 for large fish)
ki_small$Number <- ki_small$Number*2
ki_full <- rbind(ki_small, ki_large)


### DATA IS CLEAN!!! ###

### Save and quit
save(ki_full, file = "KI_UVC_17_18.Rdata")


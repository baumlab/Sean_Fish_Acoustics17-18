
### Calculating site-level sums for the KI fish data (divers remain separate)

# Set wd


# Load data
load("C:/Users/Sdimo/Documents/GitHub/ki-fish/Sean_Acoustics/KI_UVC_17_18.Rdata")

# Load necessary packages
library(dplyr)


## Check sample sizes for each site
ki_full$site.date <- with(ki_full, paste(KI.Date, Site, sep = "."))
#samples <- ki_full %>% group_by(site.date) %>% summarise(count = n_distinct(Transect))
#low.samps <- samples[samples$count <3, ]
# Remove anything with fewer than 3 transects (removes 183 rows)
#ki_full <- ki_full[!(ki_full$site.date %in% low.samps$site.date),]

## Check that 2 divers were at all sites
obs <- ki_full %>% group_by(site.date) %>% summarise(count = n_distinct(Observer))
low.obs <- obs[obs$count <2, ]
# Remove anything with fewer than 2 observers
ki_full <- ki_full[!(ki_full$site.date %in% low.obs$site.date),]

## Remove sharks and jacks (due to potential survey biases)
ki_full <- ki_full[!grepl("Caranx", ki_full$Species), ] # Removes 52 observations
ki_full <- ki_full[!grepl("Carangoides", ki_full$Species), ] # Removes 3 observations
ki_full <- ki_full[!grepl("Scomberoides", ki_full$Species), ] # Removes 21 observations
ki_full <- ki_full[!grepl("Carcharhinus", ki_full$Species), ] # Removes 2 observations


## Consolidate to 10 functional groups (herbivores/carnivores split into fine FGs)
ki_full$Trophic <- NULL
# Corallivores
ki_full$Trophic[ki_full$FineFG == "Corallivore"] <- "Corallivore"
ki_full$Trophic[ki_full$FineFG == "Obligate corallivore"] <- "Corallivore"
ki_full$Trophic[ki_full$FineFG == "Facultative corallivore"] <- "Corallivore"
# Detritivores
ki_full$Trophic[ki_full$CoarseFG == "Detritivore"] <- "Detritivore"
# Generalist carnivores
ki_full$Trophic[ki_full$FineFG == "Generalist carnivore"] <- "Generalist Carnivore"
# Herbivores
#ki_full$Trophic[ki_full$CoarseFG == "Herbivore"] <- "Herbivore"
ki_full$Trophic[ki_full$FineFG == "Browser"] <- "Browser"
ki_full$Trophic[ki_full$FineFG == "Cropper"] <- "Grazer"
ki_full$Trophic[ki_full$FineFG == "Excavator"] <- "Scraper/Excavator"
#ki_full$Trophic[ki_full$FineFG == "Scraper"] <- "Scraper/Excavator"
# Invertivores
ki_full$Trophic[ki_full$FineFG == "Ectoparasites"] <- "Invertivore"
ki_full$Trophic[ki_full$FineFG == "Invertivore"] <- "Invertivore"
ki_full$Trophic[ki_full$FineFG == "Benthic invertivore"] <- "Invertivore"
# Onmivores
ki_full$Trophic[ki_full$FineFG == "Benthic omnivore"] <- "Omnivore"
ki_full$Trophic[ki_full$FineFG == "Pelagic omnivore"] <- "Omnivore"
ki_full$Trophic[ki_full$FineFG == "Herbivore/Corallivore"] <- "Omnivore"
ki_full$Trophic[ki_full$CoarseFG == "Herbivore/Planktivore"] <- "Omnivore"
ki_full$Trophic[ki_full$CoarseFG == "Planktivore/Carnivore"] <- "Omnivore"
# Piscivores
ki_full$Trophic[ki_full$FineFG == "Piscivore"] <- "Piscivore"
ki_full$Trophic[ki_full$FineFG == "Diurnal piscivore"] <- "Piscivore"
ki_full$Trophic[ki_full$FineFG == "Nocturnal piscivore"] <- "Piscivore"
# Planktivores
ki_full$Trophic[ki_full$CoarseFG == "Planktivore"] <- "Planktivore"

aggregate(FineFG ~ Trophic, ki_full, FUN = unique)

# Remove observations that could not be assigned to a trophic group (removes 41 rows)
ki_full <- ki_full[!(is.na(ki_full$Trophic)), ]

# Change P. dickii to a corallivore
ki_full$Trophic[ki_full$Species == "Plectroglyphidodon dickii"] <- "Corallivore"

# Create data frames for each functional/size group
# ki_large <- ki_full[ki_full$length >= 20, ]
# ki_small <- ki_full[ki_full$length < 20, ]
ki_coral <- ki_full[ki_full$Trophic == "Corallivore", ]
ki_det <- ki_full[ki_full$Trophic == "Detritivore", ]
ki_gen <- ki_full[ki_full$Trophic == "Generalist Carnivore", ]
 ki_brows <- ki_full[ki_full$Trophic == "Browser", ]
 ki_graz <- ki_full[ki_full$Trophic == "Grazer", ]
 ki_exca <- ki_full[ki_full$Trophic == "Scraper/Excavator", ]
#ki_herb <- ki_full[ki_full$Trophic == "Herbivore", ]
ki_inv <- ki_full[ki_full$Trophic == "Invertivore", ]
ki_omn <- ki_full[ki_full$Trophic == "Omnivore", ]
ki_pisc <- ki_full[ki_full$Trophic == "Piscivore", ]
ki_plank <- ki_full[ki_full$Trophic == "Planktivore", ]


######################
### TOTAL ABUNDANCE ###
######################

ki_AB <- ki_full %>% group_by(Year, KI.Date, Site, Observer, prod, f.pressure) %>% summarise(AB_total = sum(Number))


########################
### SPECIES RICHNESS ###
########################

# Remove observations not identified to species level
unique(ki_full$Species)
ki_full <- ki_full[!grepl("Acanthurus sp", ki_full$Species), ]
ki_full <- ki_full[!grepl("Blenniidae sp", ki_full$Species), ]
ki_full <- ki_full[!grepl("Chlorurus sp.", ki_full$Species), ]
ki_full <- ki_full[!grepl("Epinephelus sp.", ki_full$Species), ]
ki_full <- ki_full[!grepl("Gymnothorax sp", ki_full$Species), ]
ki_full <- ki_full[!grepl("Halichoeres sp.", ki_full$Species), ]
ki_full <- ki_full[!grepl("Kyphosus sp", ki_full$Species), ]
ki_full <- ki_full[!grepl("Pervagor sp", ki_full$Species), ]
ki_full <- ki_full[!grepl("Plagiotremus sp.", ki_full$Species), ]
ki_full <- ki_full[!grepl("Pseudanthias sp", ki_full$Species), ]
ki_full <- ki_full[!grepl("Ptereleotris sp", ki_full$Species), ]
ki_full <- ki_full[!grepl("Pterocaesio sp", ki_full$Species), ]
ki_full <- ki_full[!grepl("Scarus sp", ki_full$Species), ]
ki_full <- ki_full[!grepl("Synodus sp.", ki_full$Species), ]
ki_full <- ki_full[!grepl("Valenciennea sp.", ki_full$Species), ]

ki_SR <- ki_full %>% group_by(Year, KI.Date, Site, Observer, prod, f.pressure) %>% summarise(SR_total = n_distinct(Species))


##################################
### FUNCTIONAL GROUP ABUNDANCE ###
##################################

 ki_AB_brows <- ki_brows %>% group_by(Year, KI.Date, Site, Observer, f.pressure) %>% summarise(AB_brows = sum(Number))
ki_AB_coral <- ki_coral %>% group_by(Year, KI.Date, Site, Observer, prod, f.pressure) %>% summarise(AB_coral = sum(Number))
ki_AB_det <- ki_det %>% group_by(Year, KI.Date, Site, Observer, prod, f.pressure) %>% summarise(AB_det = sum(Number))
 ki_AB_exca <- ki_exca %>% group_by(Year, KI.Date, Site, Observer, f.pressure) %>% summarise(AB_exca = sum(Number))
ki_AB_gen <- ki_gen %>% group_by(Year, KI.Date, Site, Observer, prod, f.pressure) %>% summarise(AB_gen = sum(Number))
 ki_AB_graz <- ki_graz %>% group_by(Year, KI.Date, Site, Observer, f.pressure) %>% summarise(AB_graz = sum(Number))
#ki_AB_herb <- ki_herb %>% group_by(Year, KI.Date, Site, Observer, prod, f.pressure) %>% summarise(AB_herb = sum(Number))
ki_AB_inv <- ki_inv %>% group_by(Year, KI.Date, Site, Observer, prod, f.pressure) %>% summarise(AB_inv = sum(Number))
ki_AB_omn <- ki_omn %>% group_by(Year, KI.Date, Site, Observer, prod, f.pressure) %>% summarise(AB_omn = sum(Number))
ki_AB_pisc <- ki_pisc %>% group_by(Year, KI.Date, Site, Observer, prod, f.pressure) %>% summarise(AB_pisc = sum(Number))
ki_AB_plank <- ki_plank %>% group_by(Year, KI.Date, Site, Observer, prod, f.pressure) %>% summarise(AB_plank = sum(Number))


## Combine calculated values into a single data frame
# For values summed to site level (divers remain separate)
ki_fish <- ki_AB
ki_fish$dso <- paste(ki_fish$Site, ki_fish$KI.Date, ki_fish$Observer, sep = "-")
ki_SR$dso <- paste(ki_SR$Site, ki_SR$KI.Date, ki_SR$Observer, sep = "-")
 ki_AB_brows$dso <- paste(ki_AB_brows$Site, ki_AB_brows$KI.Date, ki_AB_brows$Observer, sep = "-")
ki_AB_coral$dso <- paste(ki_AB_coral$Site, ki_AB_coral$KI.Date, ki_AB_coral$Observer, sep = "-")
ki_AB_det$dso <- paste(ki_AB_det$Site, ki_AB_det$KI.Date, ki_AB_det$Observer, sep = "-")
 ki_AB_exca$dso <- paste(ki_AB_exca$Site, ki_AB_exca$KI.Date, ki_AB_exca$Observer, sep = "-")
ki_AB_gen$dso <- paste(ki_AB_gen$Site, ki_AB_gen$KI.Date, ki_AB_gen$Observer, sep = "-")
 ki_AB_graz$dso <- paste(ki_AB_graz$Site, ki_AB_graz$KI.Date, ki_AB_graz$Observer, sep = "-")
#ki_AB_herb$dso <- paste(ki_AB_herb$Site, ki_AB_herb$KI.Date, ki_AB_herb$Observer, sep = "-")
ki_AB_inv$dso <- paste(ki_AB_inv$Site, ki_AB_inv$KI.Date, ki_AB_inv$Observer, sep = "-")
ki_AB_omn$dso <- paste(ki_AB_omn$Site, ki_AB_omn$KI.Date, ki_AB_omn$Observer, sep = "-")
ki_AB_pisc$dso <- paste(ki_AB_pisc$Site, ki_AB_pisc$KI.Date, ki_AB_pisc$Observer, sep = "-")
ki_AB_plank$dso <- paste(ki_AB_plank$Site, ki_AB_plank$KI.Date, ki_AB_plank$Observer, sep = "-")

ki_fish$SR_total <- ki_SR$SR_total[match(ki_fish$dso, ki_SR$dso)]
 ki_fish$AB_brows <- ki_AB_brows$AB_brows[match(ki_fish$dso, ki_AB_brows$dso)]
ki_fish$AB_coral <- ki_AB_coral$AB_coral[match(ki_fish$dso, ki_AB_coral$dso)]
ki_fish$AB_det <- ki_AB_det$AB_det[match(ki_fish$dso, ki_AB_det$dso)]
 ki_fish$AB_exca <- ki_AB_exca$AB_exca[match(ki_fish$dso, ki_AB_exca$dso)]
ki_fish$AB_gen <- ki_AB_gen$AB_gen[match(ki_fish$dso, ki_AB_gen$dso)]
 ki_fish$AB_graz <- ki_AB_graz$AB_graz[match(ki_fish$dso, ki_AB_graz$dso)]
#ki_fish$AB_herb <- ki_AB_herb$AB_herb[match(ki_fish$dso, ki_AB_herb$dso)]
ki_fish$AB_inv <- ki_AB_inv$AB_inv[match(ki_fish$dso, ki_AB_inv$dso)]
ki_fish$AB_omn <- ki_AB_omn$AB_omn[match(ki_fish$dso, ki_AB_omn$dso)]
ki_fish$AB_pisc <- ki_AB_pisc$AB_pisc[match(ki_fish$dso, ki_AB_pisc$dso)]
ki_fish$AB_plank <- ki_AB_plank$AB_plank[match(ki_fish$dso, ki_AB_plank$dso)]


 ki_fish$AB_brows[is.na(ki_fish$AB_brows)] <- 0
ki_fish$AB_coral[is.na(ki_fish$AB_coral)] <- 0
ki_fish$AB_det[is.na(ki_fish$AB_det)] <- 0
 ki_fish$AB_exca[is.na(ki_fish$AB_exca)] <- 0
ki_fish$AB_gen[is.na(ki_fish$AB_gen)] <- 0
 ki_fish$AB_graz[is.na(ki_fish$AB_graz)] <- 0
#ki_fish$AB_herb[is.na(ki_fish$AB_herb)] <- 0
ki_fish$AB_inv[is.na(ki_fish$AB_inv)] <- 0
ki_fish$AB_omn[is.na(ki_fish$AB_omn)] <- 0
ki_fish$AB_pisc[is.na(ki_fish$AB_pisc)] <- 0
ki_fish$AB_plank[is.na(ki_fish$AB_plank)] <- 0

# Check for NA values anywhere in the data frame
any(is.na(ki_fish))

#renaming ki_fish for herbivore-breakdown data set
ki_hfish <- ki_fish
## Save and quit
save(ki_hfish, file = "KI_UVC_17_18_obs_herb_sum.Rdata") # Values summed by Observer


###############
### BIOMASS ###
###############

ki_BM <- ki_full %>% group_by(Year, KI.Date, Site, Observer, prod, f.pressure) %>% summarise(BM_total = sum(biomass)/300)
# ki_BM_brows <- ki_brows %>% group_by(Year, KI.Date, Site, Observer, f.pressure) %>% summarise(BM_brows = sum(biomass)/300)
ki_BM_coral <- ki_coral %>% group_by(Year, KI.Date, Site, Observer, prod, f.pressure) %>% summarise(BM_coral = sum(biomass)/300)
ki_BM_det <- ki_det %>% group_by(Year, KI.Date, Site, Observer, prod, f.pressure) %>% summarise(BM_det = sum(biomass)/300)
# ki_BM_exca <- ki_exca %>% group_by(Year, KI.Date, Site, Observer, f.pressure) %>% summarise(BM_exca = sum(biomass)/300)
ki_BM_gen <- ki_gen %>% group_by(Year, KI.Date, Site, Observer, prod, f.pressure) %>% summarise(BM_gen = sum(biomass)/300)
# ki_BM_graz <- ki_graz %>% group_by(Year, KI.Date, Site, Observer, f.pressure) %>% summarise(BM_graz = sum(biomass)/300)
ki_BM_herb <- ki_herb %>% group_by(Year, KI.Date, Site, Observer, prod, f.pressure) %>% summarise(BM_herb = sum(biomass)/300)
ki_BM_inv <- ki_inv %>% group_by(Year, KI.Date, Site, Observer, prod, f.pressure) %>% summarise(BM_inv = sum(biomass)/300)
ki_BM_omn <- ki_omn %>% group_by(Year, KI.Date, Site, Observer, prod, f.pressure) %>% summarise(BM_omn = sum(biomass)/300)
ki_BM_pisc <- ki_pisc %>% group_by(Year, KI.Date, Site, Observer, prod, f.pressure) %>% summarise(BM_pisc = sum(biomass)/300)
ki_BM_plank <- ki_plank %>% group_by(Year, KI.Date, Site, Observer, prod, f.pressure) %>% summarise(BM_plank = sum(biomass)/300)


## Combine calculated values into a single data frame
# For values summed to site level (divers remain separate)
ki_fish_BM <- ki_BM
ki_fish_BM$dso <- paste(ki_fish_BM$Site, ki_fish_BM$KI.Date, ki_fish_BM$Observer, sep = "-")
# ki_BM_brows$dso <- paste(ki_BM_brows$Site, ki_BM_brows$KI.Date, ki_BM_brows$Observer, sep = "-")
ki_BM_coral$dso <- paste(ki_BM_coral$Site, ki_BM_coral$KI.Date, ki_BM_coral$Observer, sep = "-")
ki_BM_det$dso <- paste(ki_BM_det$Site, ki_BM_det$KI.Date, ki_BM_det$Observer, sep = "-")
# ki_BM_exca$dso <- paste(ki_BM_exca$Site, ki_BM_exca$KI.Date, ki_BM_exca$Observer, sep = "-")
ki_BM_gen$dso <- paste(ki_BM_gen$Site, ki_BM_gen$KI.Date, ki_BM_gen$Observer, sep = "-")
# ki_BM_graz$dso <- paste(ki_BM_graz$Site, ki_BM_graz$KI.Date, ki_BM_graz$Observer, sep = "-")
ki_BM_herb$dso <- paste(ki_BM_herb$Site, ki_BM_herb$KI.Date, ki_BM_herb$Observer, sep = "-")
ki_BM_inv$dso <- paste(ki_BM_inv$Site, ki_BM_inv$KI.Date, ki_BM_inv$Observer, sep = "-")
ki_BM_omn$dso <- paste(ki_BM_omn$Site, ki_BM_omn$KI.Date, ki_BM_omn$Observer, sep = "-")
ki_BM_pisc$dso <- paste(ki_BM_pisc$Site, ki_BM_pisc$KI.Date, ki_BM_pisc$Observer, sep = "-")
ki_BM_plank$dso <- paste(ki_BM_plank$Site, ki_BM_plank$KI.Date, ki_BM_plank$Observer, sep = "-")

# ki_fish_BM$BM_brows <- ki_BM_brows$BM_brows[match(ki_fish_BM$dso, ki_BM_brows$dso)]
ki_fish_BM$BM_coral <- ki_BM_coral$BM_coral[match(ki_fish_BM$dso, ki_BM_coral$dso)]
ki_fish_BM$BM_det <- ki_BM_det$BM_det[match(ki_fish_BM$dso, ki_BM_det$dso)]
# ki_fish_BM$BM_exca <- ki_BM_exca$BM_exca[match(ki_fish_BM$dso, ki_BM_exca$dso)]
ki_fish_BM$BM_gen <- ki_BM_gen$BM_gen[match(ki_fish_BM$dso, ki_BM_gen$dso)]
# ki_fish_BM$BM_graz <- ki_BM_graz$BM_graz[match(ki_fish_BM$dso, ki_BM_graz$dso)]
ki_fish_BM$BM_herb <- ki_BM_herb$BM_herb[match(ki_fish_BM$dso, ki_BM_herb$dso)]
ki_fish_BM$BM_inv <- ki_BM_inv$BM_inv[match(ki_fish_BM$dso, ki_BM_inv$dso)]
ki_fish_BM$BM_omn <- ki_BM_omn$BM_omn[match(ki_fish_BM$dso, ki_BM_omn$dso)]
ki_fish_BM$BM_pisc <- ki_BM_pisc$BM_pisc[match(ki_fish_BM$dso, ki_BM_pisc$dso)]
ki_fish_BM$BM_plank <- ki_BM_plank$BM_plank[match(ki_fish_BM$dso, ki_BM_plank$dso)]

# ki_fish_BM$BM_brows[is.na(ki_fish_BM$BM_brows)] <- 0
ki_fish_BM$BM_coral[is.na(ki_fish_BM$BM_coral)] <- 0
ki_fish_BM$BM_det[is.na(ki_fish_BM$BM_det)] <- 0
# ki_fish_BM$BM_exca[is.na(ki_fish_BM$BM_exca)] <- 0
ki_fish_BM$BM_gen[is.na(ki_fish_BM$BM_gen)] <- 0
# ki_fish_BM$BM_graz[is.na(ki_fish_BM$BM_graz)] <- 0
ki_fish_BM$BM_herb[is.na(ki_fish_BM$BM_herb)] <- 0
ki_fish_BM$BM_inv[is.na(ki_fish_BM$BM_inv)] <- 0
ki_fish_BM$BM_omn[is.na(ki_fish_BM$BM_omn)] <- 0
ki_fish_BM$BM_pisc[is.na(ki_fish_BM$BM_pisc)] <- 0
ki_fish_BM$BM_plank[is.na(ki_fish_BM$BM_plank)] <- 0

# Check for NA values anywhere in the data frame
any(is.na(ki_fish_BM))

## Save and quit
save(ki_fish_BM, file = "KI_UVC_13_15_17_BM_obs_sum_ALL.Rdata") # Values summed by Observer

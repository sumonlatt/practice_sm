# install.packages("devtools")
# devtools::install_github("ropensci/rdhs")
library(rdhs)

## what are the indicators
indicators <- dhs_indicators()
indicators[1,]
tags<-dhs_tags()

# Let's say we want to view the tags that relate to family planning
tags[grepl("Family", tags$TagName), ]

# and now let's then grab this data by specifying the countryIds and the survey year starts
men_fp_data <- dhs_data(tagIds = 83,countryIds = c("NG","PK","SN","CI"),breakdown="subnational",surveyYearStart = 2010)
fp_indicators_data <- dhs_data(tagIds = 84,countryIds = c("NG","PK","SN","CI"),breakdown="subnational",surveyYearStart = 2010)

# Let's say we want to view the indicator ID that relate to contraceptive
indicators[grepl("contraceptive", indicators$IndicatorID), ]

# Make an api request 
resp <- dhs_data(indicatorIds = "FP_CUSM_W_ANY", surveyYearStart = 2010,breakdown = "subnational")

# Make an api request for unmet need for family planning
unmet_need <- dhs_data(indicatorIds = "FP_NADM_W_UNT", surveyYearStart = 2010,breakdown = "subnational")

# filter it to afew countries countries for space
countries  <- c("Pakistan","Nigeria","Senegal","Cote d'Ivoire")

# and plot the results
library(ggplot2)
ggplot(	resp[resp$CountryName %in% countries,],
       aes(x=SurveyYear,y=Value,colour=CountryName)) +
  geom_point() +
  geom_smooth(method = "glm") + 
  theme(axis.text.x = element_text(angle = 90, vjust = .5)) +
  ylab(resp$Indicator[1]) + 
  facet_wrap(~CountryName,ncol = 2) 

ggplot(	unmet_need[unmet_need$CountryName %in% countries,],
        aes(x=SurveyYear,y=Value,colour=CountryName)) +
  geom_point() +
  geom_smooth(method = "glm") + 
  theme(axis.text.x = element_text(angle = 90, vjust = .5)) +
  ylab(unmet_need$Indicator[1]) + 
  facet_wrap(~CountryName,ncol = 2) 



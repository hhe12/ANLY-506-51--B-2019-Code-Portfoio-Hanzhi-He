#Chapter 4 
#Exploratory Data Analysis Checklist
#ANLY 506-51- B-2019/Summer - Exploratory Data Analytics
#Hanzhi He

#Use data from a file in Moodle attachment
library(readr)
USEPA <- read_csv("US EPA data 2017.csv")
names(USEPA) <- make.names(names(USEPA))
#First check at the data
nrow(USEPA)
ncol(USEPA)
str(USEPA)
head(USEPA[, c(6:7, 10)])
tail(USEPA[, c(6:7, 10)])
table(USEPA$Latitude)

#find observations which are measured at latitude tail(USEPA$Latitude,1), or 32.46639
library(dplyr)
filter(USEPA, Latitude == tail(USEPA$Latitude,1)) %>% select(`Sample.Duration`,`Arithmetic.Mean`)

#find out the data points with below selection 
filter(USEPA, USEPA$'State.Code' == "01" & USEPA$'County.Code' == "049") %>% select(`Sample.Duration`,`Arithmetic.Mean`) %>% as.data.frame

#see the total number of counties that are included in USEPA
select(USEPA, 'County.Code') %>% unique %>% nrow

#See how many unique county codes are in USEPA
unique(USEPA$'County.Code')
summary(USEPA$`Arithmetic.Mean`)

#deciles of the data
quantile(USEPA$`Arithmetic.Mean`, seq(0, 1, 0.1))

#identify each county we will use a combination of the State Code and the County Code variables.
ranking <- group_by(USEPA, USEPA$'State.Code', USEPA$'County.Code') %>%
  summarize(USEPA = mean(`X1st.Max.Value`)) %>%
  as.data.frame %>%
  arrange(desc(USEPA))

#look at the top 10 and bottom 10 counties
head(ranking, 10)
tail(ranking,10)    

#see how many bservations are there for county 049
filter(USEPA, USEPA$`County.Code` == "049" & USEPA$`State.Code` == "01") %>% nrow

#set a random number generator and resample the indices of the rows of the data frame
set.seed(102)
N <- nrow(USEPA)
idx <- sample(N, N, replace = TRUE)
USEPA2<- USEPA[idx, ]
ranking2 <- group_by(USEPA2, USEPA2$'State.Code', USEPA2$'County.Code') %>%
  summarize(USEPA2 = mean(`X1st.Max.Value`)) %>%
  as.data.frame %>%
  arrange(desc(USEPA2))

#compare the top and bottom 10 states and counties from original ranking and from resampled ranking
cbind(head(ranking, 10),head(ranking2, 10))      
cbind(tail(ranking, 10), tail(ranking2, 10))

#Chapter 9 
#Importing, saving and managing data
#ANLY 506-51- B-2019/Summer - Exploratory Data Analytics
#Hanzhi He

#Display all objects in the current workspace
ls()	

#Remove all objects in the workspace
rm(list = ls())	

#see my current work directory
getwd()	

#Changes the working directory to a specified file location and check all the fies in the folder
setwd(dir = "/Users/peters/Desktop/HU HW/EDA")
list.files()

#writes x to a text file called mydata.txt
x=1
write.table(x, file = "data.txt")

#Saves objects a, b, ...
a=2
b=3
save(a, b, file = "EDAimage.RData")

#Saves all objects in your workspace to myimage.RData
save.image( file="EDAimage.RData")

#Loads objects in the file myimage.RData
load(file = "EDAimage.RData")

#Reads a text file called mydata.txt
read.table(file = "data.txt")

#create objects for later practice
study1.df <- data.frame(id = 1:5,sex = c("m", "m", "f", "f", "m"),score = c(51, 20, 67, 52, 42))
score.by.sex <- aggregate(score ~ sex,FUN = mean, data = study1.df)
study1.htest <- t.test(score ~ sex, data = study1.df)

#save objects as a new RData file in my directory
save(study1.df, score.by.sex, study1.htest, file = "EDA/study1.RData")

#folder of my working directory
save.image(file = "EDA/projectimage.RData")

#load objects into my workspace
load(file = "EDA/study1.RData")
load(file = "EDA/projectimage.RData")

# Remove huge.df
rm(huge.df)

# Remove ALL
rm(list = ls())


# Write the pirates dataframe object to a tab-delimited text file
write.table(x = pirates, file = "pirates.txt", sep = "\t")

# Write the pirates dataframe object to a tab-delimited
#  text file called pirates.txt to my desktop# Save the file as pirates.txt to my desktop
# Make the columns tab-delimited
install.packages("yarrr")
library("yarrr")
pirates
write.table(x = pirates,file = "EDA/pirates.txt", sep = "\t")



# Read mydata.txt from my  directory and store as "mydata" project

mydata <- read.table(file = 'EDA/data.txt', sep = '\t',header = TRUE, stringsAsFactors = FALSE)    

# Read a file from the web
fromweb <- read.table(file = 'http://goo.gl/jTNf6P', sep = '\t', header = TRUE)
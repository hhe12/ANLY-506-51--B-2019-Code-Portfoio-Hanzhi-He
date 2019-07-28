#Chapter 8 from YaRrr!
#Matrices and dataframes
#ANLY 506-51- B-2019/Summer - Exploratory Data Analytics
#Hanzhi He

#create a matrix with number 1-30
#First create three vectors of length 5, then combine them into one matrix
x <- 1:5
y <- 6:10
z <- 11:15
cbind(x, y, z)

#create a matrix where x, y and z are rows
rbind(x, y, z)
#creating a matrix with numeric and character columns will make everything a character:
cbind(c(1, 2, 3, 4, 5),
      c("a", "b", "c", "d", "e"))

#create a matrix of integers 1-10 with 5 rows and 2 columns
matrix(data = 1:10,
       nrow = 5,
       ncol = 2)

# Now with 2 rows and 5 columns
matrix(data = 1:10,
       nrow = 2,
       ncol = 5)

#change above matrix to one with same structure but fill by row instead of column
matrix(data = 1:10,
       nrow = 2,
       ncol = 5,
       byrow = TRUE)

#create a survey data frame with manual inputs
survey <- data.frame("index" = c(1, 2, 3, 4, 5),
                     "sex" = c("m", "m", "m", "f", "f"),
                     "age" = c(99, 46, 23, 54, 23))

str(survey)

#create a dataframe of survey data WITHOUT factors
survey <- data.frame("index" = c(1, 2, 3, 4, 5),
                     "sex" = c("m", "m", "m", "f", "f"),
                     "age" = c(99, 46, 23, 54, 23),
                     stringsAsFactors = FALSE)

#no more factors in the structure now.
str(survey)

#Take a look at the ChickWeight data
head(ChickWeight)
tail(ChickWeight)
View(ChickWeight)

#use below codes to examine ToothGrowth data
summary(ToothGrowth)
str(ToothGrowth)
names(ToothGrowth)
ToothGrowth$len
mean(ToothGrowth$len)
table(ToothGrowth$supp)
head(ToothGrowth[c("len", "supp")])

# Create a new dataframe called survey
survey <- data.frame("index" = c(1, 2, 3, 4, 5),
                     "age" = c(24, 25, 42, 56, 22))

# Add a new column, sex, to survey
survey$sex <- c("m", "m", "f", "f", "m")

# make changes to survey dataframe
names(survey)[1] <- "participant.number"
names(survey)[names(survey) == "age"] <- "years"

#see ToothGrowth dataframe
ToothGrowth[1:6, 1]
ToothGrowth[1:3, c(1,3)]
ToothGrowth[1, ]
ToothGrowth[, 2]

#create new df with only the rows of ToothGrowth under different conditions
ToothGrowth.VC <- ToothGrowth[ToothGrowth$supp == "VC", ]
ToothGrowth.OJ.a <- ToothGrowth[ToothGrowth$supp == "OJ" &
                                  ToothGrowth$dose < 1, ] 

#generate a subset of ToothGrowth under certain conditions
subset(x = ToothGrowth,
       subset = len < 20 &
         supp == "OJ" &
         dose >= 1)

subset(x = ToothGrowth,
       subset = len > 30 & supp == "VC",
       select = c(len, dose))

# To find out the mean tooth length of Guinea pigs given OJ using subset()
oj <- subset(x = ToothGrowth,
             subset = supp == "OJ")
mean(oj$len)

#create a dataframe "health" with some inputs
health <- data.frame("age" = c(32, 24, 43, 19, 43),
                     "height" = c(1.75, 1.65, 1.50, 1.92, 1.80),
                     "weight" = c(70, 65, 62, 79, 85))

# Calculate bmi
bmi = health$weight / health$height ^ 2


#Chapter 20 from R for Data Science
#Vectors

library(tidyverse)

#check the type of various vectors
typeof(letters)
typeof(1:10)
typeof(1)
typeof(1L)

#Its length
x <- list("a", "b", 1:10)
length(x)

#logical vectors
1:10 %% 3 == 0

#contruct a vector
c(TRUE, TRUE, FALSE, NA)

#square of the square root of two
x <- sqrt(2) ^ 2
x

# special values NaN, Inf and -Inf can arise during division:
c(-1, 0, 1) / 0

#the amount of memory needed
x <- "This is a reasonably long string."
pryr::object_size(x)

y <- rep(x, 1000)
pryr::object_size(y)

#Coercion: using a logical vector in a numeric context
x <- sample(20, 100, replace = TRUE)
y <- x > 10
sum(y)
#what proportion are greater than 10?
mean(y)

# a vector containing multiple types 
typeof(c(TRUE, 1L))
typeof(c(1L, 1.5))
typeof(c(1.5, "a"))

#basic mathematical operations work with vectors
sample(10) + 100
runif(10) > 0.5

#add two vectors of different lengths
1:10 + 1:2
1:10 + 1:3

#create tables (with repeated vectors)
tibble(x = 1:4, y = rep(1:2, 2))
tibble(x = 1:4, y = rep(1:2, each = 2))

# Name vectors as x, y, z or a,b,c
c(x = 1, y = 2, z = 4)
set_names(1:3, c("a", "b", "c"))


#Subsetting with positive integers keeps the elements at those positions
x <- c("one", "two", "three", "four", "five")
x[c(3, 2, 5)]
x[c(1, 1, 5, 5, 5, 2)]

#Negative values drop the elements at the specified positions
x[c(-1, -3, -5)]

#It's an error to mix positive and negative values
x[c(1, -1)]

#subsetting with zero, which returns no values
x[0]

# All non-missing values of x
x <- c(10, 3, NA, 5, 8, 1, NA)
x[!is.na(x)]

# All even (or missing!) values of x
x[x %% 2 == 0]

#subset it with a character vector:
x <- c(abc = 1, def = 2, xyz = 5)
x[c("xyz", "def")]

#List: hierarchical or tree-like structures
x <- list(1, 2, 3)
x

#focus on the structure
str(x)

x_named <- list(a = 1, b = 2, c = 3)
str(x_named)

#list() can contain a mix of objects:
y <- list("a", 1L, 1.5, TRUE)
str(y)

#Lists can even contain other lists
z <- list(list(1, 2), list(3, 4))
str(z)

#more list examples
x1 <- list(c(1, 2), c(3, 4))
x2 <- list(list(1, 2), list(3, 4))
x3 <- list(1, list(2, list(3)))

#There are three ways to subset a list
a <- list(a = 1:3, b = "a string", c = pi, d = list(-1, -5))
str(a[1:2])
str(a[4])
str(a[[1]])
str(a[[4]])
a$a
a[["a"]]

#get and set individual attribute values with attr() or see them all at once with attributes()
x <- 1:10
attr(x, "greeting")
attr(x, "greeting") <- "Hi!"
attr(x, "farewell") <- "Bye!"
attributes(x)

#specific implementation
methods("as.Date")
getS3method("as.Date", "default")


#represent categorical data that can take a fixed set of possible values
x <- factor(c("ab", "cd", "ab"), levels = c("ab", "cd", "ef"))
typeof(x)

attributes(x)

#dates
x <- as.Date("1971-01-01")
unclass(x)
typeof(x)
attributes(x)

x <- lubridate::ymd_hm("1970-01-01 01:00")
unclass(x)
typeof(x)
x <- lubridate::ymd_hm("1970-01-01 01:00")
unclass(x)

attr(x, "tzone") <- "US/Pacific"
x
attr(x, "tzone") <- "US/Eastern"
x

#Tibbles are augmented lists: they have class "tbl_df" + "tbl" + "data.frame"
tb <- tibble::tibble(x = 1:5, y = 5:1)
typeof(tb)

attributes(tb)


#Traditional data.frames
df <- data.frame(x = 1:5, y = 5:1)
typeof(df)
attributes(df)
#Chapter 12 from R for Data Science
#Tidy data
#ANLY 506-51- B-2019/Summer - Exploratory Data Analytics
#Hanzhi He

library(tidyverse)
#represent the same data in different ways shown in below tables
table1
table2
table3

# Spread across two tables
table4a
table4b

# Compute rate per 10,000
table1 %>% 
mutate(rate = cases / population * 10000)

# Compute cases per year
table1 %>% 
count(year, wt = cases)

# plot to see changes over time
library(ggplot2)
ggplot(table1, aes(year, cases)) + 
  geom_line(aes(group = country), colour = "grey50") + 
  geom_point(aes(colour = country))

#gather those columns into a new pair of variables
table4a %>% 
  gather(`1999`, `2000`, key = "year", value = "cases")
table4b %>% 
gather(`1999`, `2000`, key = "year", value = "population")

#combine the tidied table4a and table4b into a single table
tidy4a <- table4a %>% 
  gather(`1999`, `2000`, key = "year", value = "cases")
tidy4b <- table4b %>% 
  gather(`1999`, `2000`, key = "year", value = "population")
left_join(tidy4a, tidy4b)

#analyse the representation in similar way to gather() using spread()
table2 %>%
  spread(key = type, value = count)

#split column that contains both cases and population variables into two variables
table3 %>% 
  separate(rate, into = c("cases", "population"))

#use a character to separate a column and pass the character to the sep argument of separate()
table3 %>% 
  separate(rate, into = c("cases", "population"), sep = "/")

#convert to better types using convert = TRUE
table3 %>% 
  separate(rate, into = c("cases", "population"), convert = TRUE)

#separate the last two digits of each year
table3 %>% 
  separate(year, into = c("century", "year"), sep = 2)

#use unite() to rejoin the century and year columns 
table5 %>% 
unite(new, century, year)

#The default will place an underscore between the values from different columns
table5 %>% 
  unite(new, century, year, sep = "")

#Work on missing values
stocks <- tibble(
  year   = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
  qtr    = c(   1,    2,    3,    4,    2,    3,    4),
  return = c(1.88, 0.59, 0.35,   NA, 0.92, 0.17, 2.66)
)

stocks %>% 
  spread(year, return)

# use gather() and set na.rm=TRUE to turn explicit missing values implicit
stocks %>% 
  spread(year, return) %>% 
  gather(year, return, `2015`:`2016`, na.rm = TRUE)

#Another important tool for making missing values explicit in tidy data is complete()
stocks %>% 
  complete(year, qtr)

#missing values indicate that the previous value should be carried forward
treatment <- tribble(
  ~ person,           ~ treatment, ~response,
  "Derrick Whitmore", 1,           7,
  NA,                 2,           10,
  NA,                 3,           9,
  "Katherine Burke",  1,           4
)

#fill in missing values with fill()
treatment %>% 
  fill(person)

#gather together all the columns from new_sp_m014 to newrel_f65
who1 <- who %>% 
  gather(new_sp_m014:newrel_f65, key = "key", value = "cases", na.rm = TRUE)
who1

who1 %>% 
  count(key)

#replace the characters "newrel" with "new_rel" in the key column. This makes all variable names consistent.
who2 <- who1 %>% 
  mutate(key = stringr::str_replace(key, "newrel", "new_rel"))
who2

#separate values in each code with two passes of separate(). 

#The first pass will split the codes at each underscore.
who3 <- who2 %>% 
  separate(key, c("new", "type", "sexage"), sep = "_")
who3

#drop the new column since it's constant
who3 %>% 
  count(new)

# drop iso2 and iso3
who4 <- who3 %>% 
  select(-new, -iso2, -iso3)

#separate sexage into sex and age by splitting after the first character
who5 <- who4 %>% 
  separate(sexage, c("sex", "age"), sep = 1)
who5

#The who dataset is now tidy
who %>%
  gather(key, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(key = stringr::str_replace(key, "newrel", "new_rel")) %>%
  separate(key, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1)
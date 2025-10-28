# Datasetd

library(tidyverse)
library(dplyr)

df <- read.csv("sn03.csv")
# Removes columns through X until X.10
df_clean <- df %>%
  select(-(X:X.10))

df_clean <- df %>%
  select(-(X.25:X.34))

# Remove rows 1 through 28
df_clean <- df_clean %>%
  slice(-(1:9))
(df_clean)

#
df <- df_clean %>% 
  select(-(X:X.10))


# Remove x.12 through x.15
df <- df %>%
  select(-(X.12:X.15))

# remove x.25
df <- df %>%
  select(-(X.23))


####
colnames(df)

# rename colnames
colnames(df) <- c("Items(Japanese)", "2017", "2018", "2019", "2020", "2021", "2022", "2023", "2024", "Items")

df <- df %>%
  slice(-(1:4))


df <- df %>%
  slice(-(3:10))



df <- df %>%
  slice(-(5:258))

df <- df %>%
  slice(-(6:23))


df <- df %>%
  slice(-(8:135))


df <- df %>%
  slice(-(10:31))

df <- df %>%
  slice(-(11:46))


df <- df %>%
  slice(-(25:99))


df <- df %>%
  select(-(1))

df <- df %>%
  slice(-(24:163))





########################################
df2 <- read.csv("consumption_lower.csv")


df2 <- df2 %>%
  select(-(X:X.11))

df2 <- df2 %>%
  select(-(X.13:X.15))

df2 <- df2 %>%
  select(-(X.22))

df2 <- df2 %>%
  select(-(X.24:X.29))

df2 <- df2 %>% 
  slice(-(1:13))



colnames(df2) <- c("items", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "Items")

df2 <- df2 %>% 
  slice(-(3:10))

df2 <- df2 %>% 
  slice(-(5:259))


df2 <- df2 %>% 
  slice(-(6:23))


df2 <- df2 %>% 
  slice(-(7:8))


df2 <- df2 %>% 
  slice(-(8:143))

df2 <- df2 %>% 
  slice(-(9:34))

df2 <- df2 %>% 
  slice(-(9:17))

df2 <- df2 %>% 
  slice(-(10:33))

df2 <- df2 %>% 
  slice(-(24:192))

df2 <- df2 %>% 
  slice(-(9))


df2 <- df2 %>% 
  slice(-(24:54))


df2 <- df2 %>% 
  slice(-(24:35))

# remove first column
df2 <- df2 %>% 
  select(-1)

df2 <- df2 %>% 
  slice(-22)




#########################################################
# Merge data set 

merged_dataset <- merge(df2, df, by="Items", sort=FALSE)
(merged_dataset)

#############
cpi <- read.csv("cpi.csv")
loans <- read.csv("LoansandDIscounts.csv")
nikkei <- read.csv("Nikkei.csv")
students <- read.csv("numberofunistudents.csv")
m2 <- read.csv("m2.csv")
unemployment_rate <- read.csv("yearly_unemployment.csv")
savings <- read.csv("savings.csv") # No data for 2001 so maybe we can take avg, but because consumption data is btween 2009 we can omit. 

#################################################################
cpi <- cpi %>%
  select(-(X2000:X2008))

colnames(cpi) <- c("Items", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023", "2024")
  
#check datatype of cpi 
str(cpi)
str(merged_dataset)

# Remove commas from rows between columns 2009 to 2024 from merged dataset
merged_dataset[,2:17] <- merged_dataset[,2:17] %>%
  mutate(across(everything(), ~as.numeric(gsub(",", "", .))))
(merged_dataset)
str(merged_dataset)

df_cpi <- bind_rows(merged_dataset, cpi)
(df_cpi)


loans$Items <- "loans by bank"
loans <- loans %>% 
  select(-(X2000:X2008))
loans <- loans %>% 
  select(-(X2025))

loans <- loans %>%
  select(Items, X2009, X2010, X2011, X2012, X2013, X2014, X2015, X2016, X2017, X2018, X2019, X2020, X2021, X2022, X2023, X2024)

colnames(loans) <- c("Items", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023", "2024")
str(loans)

df_cpi_loans <- bind_rows(df_cpi, loans)
(df_cpi_loans)

nikkei <- nikkei %>%
  select(-(X2000:X2008),-(X2025))

nikkei$Items <- "Nikkei Average"

nikkei <- nikkei %>%
  select(Items, X2009, X2010, X2011, X2012, X2013, X2014, X2015, X2016, X2017, X2018, X2019, X2020, X2021, X2022, X2023, X2024)
colnames(nikkei) <- c("Items", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023", "2024")
str(nikkei)
df_cpi_loans_nikkei <- bind_rows(df_cpi_loans, nikkei)
View(df_cpi_loans_nikkei)

View(m2)
m2 <- m2 %>%
  select(-(X2000:X2008),-(X2025))

m2$Items <- "M2 Money Supply"
m2 <- m2 %>% 
  select(Items, X2009, X2010, X2011, X2012, X2013, X2014, X2015, X2016, X2017, X2018, X2019, X2020, X2021, X2022, X2023, X2024)
colnames(m2) <- c("Items", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023", "2024")
df_cpi_loans_nikkei_m2 <- bind_rows(df_cpi_loans_nikkei, m2)
View(df_cpi_loans_nikkei_m2)

View(unemployment_rate)
unemployment_rate$Items <- "Unemployment Rate"
unemployment_rate <- unemployment_rate %>%
  select(Items, X2009, X2010, X2011, X2012, X2013, X2014, X2015, X2016, X2017, X2018, X2019, X2020, X2021, X2022, X2023, X2024)
colnames(m2) <- c("Items", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023", "2024")

df_cpi_loans_nikkei_m2_unemp <- bind_rows(df_cpi_loans_nikkei_m2, unemployment_rate)
View(df_cpi_loans_nikkei_m2_unemp)


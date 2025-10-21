# Datasetd

library(tidyverse)

df <- read.csv("sn03.csv")
view(df)

View(df)
# Removes columns through X until X.10
df_clean <- df %>%
  select(-(X:X.10))

df_clean <- df %>%
  select(-(X.25:X.34))

# Remove rows 1 through 28
df_clean <- df_clean %>%
  slice(-(1:9))
View(df_clean)

#
df <- df_clean %>% 
  select(-(X:X.10))
View(df)

# Remove x.12 through x.15
df <- df %>%
  select(-(X.12:X.15))
View(df)
# remove x.25
df <- df %>%
  select(-(X.23))
View(df)

####
colnames(df)

# rename colnames
colnames(df) <- c("Items(Japanese)", "2017", "2018", "2019", "2020", "2021", "2022", "2023", "2024", "Items")
View(df)
df <- df %>%
  slice(-(1:4))
View(df)


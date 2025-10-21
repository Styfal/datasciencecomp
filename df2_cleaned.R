
########################################
df2 <- read.csv("sn02.csv")

df2 <- df2 %>% 
  slice(-(1:9))

df2 <- df2 %>% 
  select(-(X:X.9))

df2 <- df2 %>% 
  select(-(X.24:X.29))

df2 <- df2 %>% 
  select(-(X.22))

df2 <- df2 %>%
  select(-(X.13:X.15))

df2 <- df2 %>%
  select(-(X.11))

df2 <- df2 %>%
  select(-(X.10))

df2 <- df2 %>% 
  slice(-(1:4))

colnames(df2) <- c("items", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "items(English)")


df2 <- df2 %>% 
  slice(-(13))

df2 <- df2 %>% 
  slice(-(14:28))

df2 <- df2 %>% 
  slice(-(14:251))


df2 <- df2 %>% 
  slice(-(15:31))


df2 <- df2 %>% 
  slice(-(17:19))



df2 <- df2 %>% 
  slice(-(18:21))


df2 <- df2 %>% 
  slice(-(19:71))



df2 <- df2 %>% 
  slice(-(19:119))



df2 <- df2 %>% 
  slice(-(22:36))

df2 <- df2 %>% 
  slice(-(23:26))

df2 <- df2 %>% 
  slice(-(25:36))

df2 <- df2 %>% 
  slice(-(37:39))

df2 <- df2 %>% 
  slice(-(41:199))

df2 <- df2 %>% 
  slice(-(42:74))

df2 <- df2 %>% 
  slice(-(45:56))

View(df2)







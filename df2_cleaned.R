df2 <- read.csv("consumption_lower.csv")
View(df2)

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

View(df2)

colnames(df2) <- c("items", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "items(English)")

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

View(df2)


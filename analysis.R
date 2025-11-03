library(tidyverse)
library(dtplyr)
library(dbplyr)

df <- read.csv("final_dataset.csv")
df2 <- read.csv("fixed_uncertainty.csv")

View(df2)

df <- as.data.frame(df)
df2 <- as.data.frame(df2)

# Find the correlation between these data (Not the categorical variables under Items)

glimpse(df)

final_long <- df %>%
  pivot_longer(cols = -Items, names_to = "Year", values_to = "Value") %>%
  mutate(Year = as.numeric(gsub("[^0-9]", "", Year)))  # keep only numbers

uncertainty_long <- df2 %>%
  pivot_longer(cols = -Year, names_to = "Year_col", values_to = "Value") %>%
  rename(Index = Year) %>%
  mutate(Year = as.numeric(gsub("[^0-9]", "", Year_col))) %>%
  select(-Year_col)

uncertainty_wide <- pivot_wider(uncertainty_long, names_from = Index, values_from = Value)

merged_df <- final_long %>%
  left_join(uncertainty_wide, by = "Year")

head(merged_df)
View(merged_df)

merged_df %>%
  group_by(Items) %>%
  summarise(sd_value = sd(Value, na.rm = TRUE)) %>%
  filter(sd_value == 0)

merged_df <- merged_df %>%
  group_by(Items) %>%
  filter(sd(Value, na.rm = TRUE) > 0) %>%
  ungroup()

cor_test_results <- merged_df %>%
  group_by(Items) %>%
  summarise(
    cor_AENROP = cor(Value, AENROP, use = "complete.obs", method = "pearson"),
    p_AENROP = cor.test(Value, AENROP)$p.value,
    cor_AROPRP = cor(Value, AROPRP, use = "complete.obs", method = "pearson"),
    p_AROPRP = cor.test(Value, AROPRP)$p.value
  ) %>%
  arrange(desc(abs(cor_AENROP)))

print(cor_test_results)

#######
merged_wide <- merged_df %>%
  select(Year, Items, Value, AENROP, AROPRP) %>%
  pivot_wider(names_from = Items, values_from = Value) %>%
  arrange(Year)

# Quick sanity check
names(merged_wide)

m1 <- lm(Education ~ AENROP + AROPRP, data = merged_wide)
summary(model1)

m2 <- lm(
  Education ~ AENROP + AROPRP +
    `Consumer Price Index (All items) 2020 base` +
    `M2 Money Supply` +
    `Unemployment Rate` +
    `Household Savings`,
  data = merged_wide
)

# Add 1-year lags of uncertainty; drop rows with NA created by lagging
merged_wide_lag <- merged_wide %>%
  mutate(
    AENROP_l1 = dplyr::lag(AENROP, 1),
    AROPRP_l1 = dplyr::lag(AROPRP, 1)
  ) %>%
  drop_na(Education, AENROP_l1, AROPRP_l1)

# Lag model (uncertainty_{t-1} -> Education_t)
m3 <- lm(Education ~ AENROP_l1 + AROPRP_l1, data = merged_wide_lag)

# Trend + controls + lags (more demanding; small n, so interpret cautiously)
m4 <- lm(
  Education ~ AENROP_l1 + AROPRP_l1 + Year +
    `Consumer Price Index (All items) 2020 base` +
    `M2 Money Supply` +
    `Unemployment Rate` +
    `Household Savings`,
  data = merged_wide_lag
)

summary(m3)
summary(m4)


summary(m1)
summary(m2)

#######################

install.packages(c("stargazer", "sandwich", "lmtest"))
library(stargazer); library(sandwich); library(lmtest)

robust_se <- function(model) sqrt(diag(vcovHC(model, type = "HC1")))

stargazer(
  m1, m2, m3, m4,
  type = "text", # use "html" or "latex" for reports
  title = "Political Uncertainty and Education Expenditure",
  dep.var.labels = "Education",
  covariate.labels = c(
    "AENROP", "AROPRP", "Year",
    "CPI (2020 Base)", "M2 Money Supply", "Unemployment Rate", "Household Savings",
    "AENROP (lag 1)", "AROPRP (lag 1)"
  ),
  se = list(robust_se(m1), robust_se(m2), robust_se(m3), robust_se(m4)),
  omit.stat = c("f"),
  digits = 3
)

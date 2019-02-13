library(tidyverse); library(magrittr)

dat <- read.csv("../data/Narcissism combined data CSV (Connor).csv") %>%
  .[,-c(1:9, 11:12, 286:288, 290:298)] %>%
  select(starts_with("CRTtotal"),
         starts_with("SRIS"),
         starts_with("BIS"), 
         starts_with("REI"),
         starts_with("NPI"),
         starts_with("HSNS"),
         matches("BRLN_[0-9]s"),
         starts_with("mmps"),
         starts_with("WRDS"),
         -ends_with("R"),
         -contains("meta"))


 


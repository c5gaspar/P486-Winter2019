library(magrittr)

dat <- read.csv("../../data/Narcissism combined data CSV (Connor).csv") %>%
  .[,286:298]

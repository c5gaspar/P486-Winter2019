#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!
##### PROCESS DATA FOR LEARNING SCRIPT #####
#!#!#!#!# WRITTEN BY CONNOR GASPAR #!#!#!#!#
#!#!# LAST MODIFIED ON JANUARY 21 2019 #!#!#
#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!

# Loading packages
require(dplyr); require(keras)

# Read in data
testLabels <- read.csv("../data/balanced/emnist-balanced-test.csv", header = F) %>%
  data.matrix() %>%
  .[,1]



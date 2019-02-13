#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!
##### PROCESS DATA FOR LEARNING SCRIPT #####
#!#!#!#!# WRITTEN BY CONNOR GASPAR #!#!#!#!#
#!#!# LAST MODIFIED ON JANUARY 21 2019 #!#!#
#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!#!

# Loading packages
require(magrittr); require(keras)

# Set random seed (for truly random validation data at each initialization)
set.seed(Sys.time())

# Read in data
trainDat <- read.csv("../data/balanced/emnist-balanced-train.csv", header = F) %>%
  data.matrix()

## Manipulate Data ##
# Convert labels to integer string and strip from training data
trainLabels <- trainDat[,1] %>%
  to_categorical()
# Actually labels from data
trainDat %<>% .[,-1] %>%
  # Normalize grayscale values in training data
  normalize()

## Construct Validation Data ##
# Needs to be a BALANCED set of outcomes for the sake of reliable testing
# Total size will be 17,000 samples - denoting 15% of the data, thankfully
# random selection from a balanced dataset should achieve this a high percentage
# of the time.
rIndices <- sample(1:dim(trainDat)[1], size = 17000)
# Seperate validation data (subset and strip)
valDat <- trainDat[rIndices,]
valLabels <- trainLabels[rIndices,]
# Actually strip from training
trainDat %<>% .[-rIndices,]
trainLabels %<>% .[-rIndices,]


library(keras); library(dplyr); library(magrittr)

set.seed(Sys.time())

# Extract data from internet and write to file
c(c(trainDat, trainLabels), c(testDat, testLabels)) %<-% keras::dataset_cifar10()

# Normalize data
trainDat %<>% normalize()
testDat %<>% normalize()

# Reencode labels (one-hot)
trainLabels.num <- trainLabels
trainLabels %<>% to_categorical()

# Create validation data
rIndices <- sample(1:dim(trainDat)[1], size = dim(trainDat)[1]*.15, replace = F)

valDat <- trainDat[rIndices,,,]
valLabels <- trainLabels[rIndices,]
trainDat %<>% .[-rIndices,,,]
trainLabels %<>% .[-rIndices,]


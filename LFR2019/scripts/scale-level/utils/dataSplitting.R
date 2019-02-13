library(keras); library(tidyverse); library(magrittr)

dataGen <- function(nominal = TRUE, validation = TRUE, mat = TRUE) {
  
  set.seed(123456789)
  
  source("utils/dataInput.R")
  
  # Partition training and testing data (79% of total) (testing = 75obs)
  tIndices <- caret::createDataPartition(dat$CRTtotal, p = .79, list = F)  # rand ind.
  
  # Seperate data
  trainDat <- dat[tIndices,]
  testDat <- dat[-tIndices,]
  
  if(validation) {
    
    # Partition validation data (17% of training) (validation = 50obs)
    vIndices <- caret::createDataPartition(trainDat$CRTtotal, p = .17, list = F)
    
    # Seperate data
    valDat <- trainDat[vIndices,]
    trainDat %<>% .[-vIndices,]
    valLabels <- valDat[,4] %>% as.numeric()
    valDat %<>% .[,-4]
    if(mat) {
      valDat %<>% data.matrix() %>% 
        #array_reshape(c(dim(.)[1], 14, 11)) %>%
        normalize()
    }
  }
  
  # Store outcome externally (CRTtotal)
  trainLabels <- trainDat[,4] %>% as.numeric()
  testLabels <- testDat[,4] %>% as.numeric()
  
  # Remove outcome from dataset
  trainDat %<>% .[,-4]
  testDat %<>% .[,-4]
  colNames <- colnames(trainDat)
  
  
  if(mat) {
    # Convert data frames to matrix, reshape to 3D and normalize
    trainDat %<>% data.matrix() %>%
      normalize() 
    testDat %<>% data.matrix() %>%
      normalize()
  } else {
    trainDat %<>% data.matrix() %>% 
      normalize() %>%
      as.data.frame()
    testDat %<>% data.matrix() %>%
      normalize() %>%
      as.data.frame()
  }
  
  # CONDITIONALLY convert outcomes to categorical
  if(nominal) {
    trainLabels %<>% factor %>% 
      to_categorical()  # One hot encoding
    testLabels %<>% factor  # Not needed for test data
    try(valLabels %<>% factor %>% to_categorical())  # One hot encoding 
  }
  if(validation) {
    return(list(trainDat, testDat, trainLabels, testLabels, valDat, valLabels, colNames))
  } else {return(list(trainDat, testDat, trainLabels, testLabels, colNames))}
}

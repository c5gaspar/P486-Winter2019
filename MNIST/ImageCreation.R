library(tidyverse); library(magrittr)
# Read training data
train <- read.csv("train.csv")
# Extract labels for purpose of array-izing
trainLabels <- train$label
# Transform to array
trainA <- train[,-c(1)] %>%
  t() %>%  # Transpose rows and columns for unlisting + array conversion
  unlist() %>%
  array(dim = c(28, 28, nrow(train))) %>%
  aperm(perm = c(2,1,3))  #  Need to replace this with the `array_reshape()` FUN
  
for(i in 1:dim(trainA)[3]) {
  png(paste0("MNIST images/training/", i, ".png"), width = 28, height = 28)
  par(mar = rep(0, 4))
  plot(as.raster(trainA[,,i], max = 255))
  dev.off()
}

# Read testing data
test <- read.csv("test.csv")

testA <- test %>%
  t() %>%  # Transpose rows and columns for unlisting + array conversion
  unlist() %>%
  array(dim = c(28, 28, nrow(test))) %>%
  aperm(perm = c(2,1,3))  #  Need to replace this with the `array_reshape()` FUN


for(i in 1:dim(testA)[3]) {
  png(paste0("MNIST images/testing/", i, ".png"), width = 28, height = 28)
  par(mar = rep(0, 4))
  plot(as.raster(testA[,,i], max = 255))
  dev.off()
}



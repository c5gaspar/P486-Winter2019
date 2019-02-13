testModel <- function(model, kerasModel = TRUE, convnet = FALSE, returnDat = FALSE) {
  # Purpose:
  # Takes in a model (either keras or not) and returns the prediction accuracy
  # of it when applied to an unseen & untrained testing set.
  #
  # Arguments:
  # - model: many-class, a trained model object for performing predictions
  # - kerasModel: boolean, indicates whether the class of the model object is
  #               keras (default) or not
  # - convent: boolean, indicates whether the provided model is a convoluted 
  #            network (default) or otherwise
  # Dependencies:
  library(magrittr); library(keras)
  
  # Read in test dataset
  testDat <- read.csv("../data/balanced/emnist-balanced-test.csv", header = F) %>%
    data.matrix()
  
  # Extract labels from array (conditional)
  testLabels <- testDat[,1]
  if(!kerasModel) {  # Conditionally convert image labels based upon model expectations
    testLabels %<>% factor()
  }
  # Strip labels from array
  testDat %<>% .[,-1]
  
  # Normalize array 
  if(kerasModel) {  # If keras model, normalize matrix
    testDat %<>% normalize()
  } else {  # If non-keras manually normalize by grayscale maximum
    testDat <- testDat/255
  }
  
  # Reshape as is necessary (keras models)
  if(convnet & kerasModel) {
    testDat %<>% array_reshape(c(dim(.)[1], 28, 28, 1))
  } else if(!convnet & keras) {
    testDat %<>% array_reshape(c(dim(.), 28, 28))
  }
  
  # Generate predictions of the test data
  if(kerasModel) {
    predictions <- predict_classes(model, testDat)
  } else {
    predictions <- predict(model, testDat)
  }
  
  # Print results
  if(!returnDat) {
  as.numeric(testLabels == predictions) %>%
    mean() %>%
    round(4) %>%
    cat("***\nTest data accuracy = ", ., "\n***", sep = "")
  }
  
  # Return value
  if(!returnDat){
  return(as.numeric(testLabels == predictions) %>%
           mean() %>%
           round(4))
  } else {
    return(list(testDat, testLabels))
  }
}


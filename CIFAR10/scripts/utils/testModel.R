testModel <- function(model, kerasModel = TRUE, convnet = FALSE) {
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
  }
}


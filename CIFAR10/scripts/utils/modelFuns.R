compileModel <- function(x) {
  compile(object = x,
          # Sets the parameters for gradient descent
          optimizer = "rmsprop",
          # Compares the observed prob. distribution to the predicted prob. distribution of labels
          loss = "categorical_crossentropy",
          # Indicates the metric of interest in training (what to minimize)
          metrics = c("accuracy"))
}

### Setup fit function ###
fitModel <- function(x, bs = 256, ep = 20, v = 2) {
  fit(object = x,  # Feeding the model structure
      x = trainDat,  # Training data (features)
      y = trainLabels,   # Training labels (targets)
      batch_size = bs,  # Sample size (# of images) for each descent 
      epochs = ep,   # Total number of full samples to use in training
      validation_data = list(valDat, valLabels),  # Validation data
      verbose = v)  # Silent
}

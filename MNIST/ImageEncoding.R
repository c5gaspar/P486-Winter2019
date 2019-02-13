library(dplyr); library(magick); library(png); library(magrittr); library(abind)

testImg <- list.files("MNIST images/training/", full.names = T)
  
testImgSortOrder <- strsplit(testImg, split = "/") %>% 
  unlist() %>% 
  .[seq(3, length(.), 3)] %>%
  strsplit(split = ".png") %>%
  unlist() %>%
  as.numeric() %>%
  order()

testImg %<>% .[testImgSortOrder]

testImgA <- array(numeric(), dim = c(28, 28, 0))

# Needs work
for(i in 1:length(testImg)) {
  testImgA[,,i] <- readPNG(testImg[i])
}


  

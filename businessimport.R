
#install.packages('data.table')
#install.packages('jsonlite')
library(data.table)
library(jsonlite)
library(dplyr)

setwd("C:/code/R/capstone/")

num <- 160000
fi <- file("dataset/business.json",open="r")
lines <- readLines(fi, n = num)
num <- length(lines)
businesses <- data.table(business_id=character(num), 
                         name=character(num),
                         latitude=numeric(num),
                         longitude=numeric(num),
                         stars=numeric(num),
                         review_count=numeric(num))
cols <- names(businesses)
for (i in 1:num){
  business <- fromJSON(lines[i])
  business <- business[cols]
  business[sapply(business, is.null)] <- NA
  businesses[i] <- as.data.frame(business)
  if (i%%1000 == 0){print(i)}
}


save(businesses,file="rdata/businesses.RData")

#load("rdata/businesses.RData")
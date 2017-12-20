
#install.packages('data.table')
#install.packages('jsonlite')
#install.packages('hashmap')
library(data.table)
library(jsonlite)
library(dplyr)
library(hashmap)

setwd("C:/code/R/capstone/")

#<4736897 total reviews
#substr(a,50,71)

load("rdata/users.RData")
useridx <- hashmap(users$user_id,1:nrow(users))


samplen <- sum(users$review_count)


num <- 100000
numlines <- num
total <- 0
fi <- file("dataset/review.json", open="r")

reviews <- data.table(review_id  = character(samplen),
                    user_id    = character(samplen),
                    business_id= character(samplen),
                    stars      = numeric(samplen),
                    date       = character(samplen),
                    useful     = numeric(samplen),
                    funny      = numeric(samplen),
                    cool       = numeric(samplen))


cols <- names(reviews)
reviewtotal <- 0
repeat{
  lines <- readLines(fi, n = num)
  numlines <- length(lines)
  if (numlines <= 0) break
  for (i in 1:numlines){
    if (!is.na(useridx[[substr(lines[i],50,71)]]) ){
      review <- fromJSON(lines[i])
      review <- review[cols]
      review[sapply(review, is.null)] <- NA
      reviewtotal <- reviewtotal+1
      reviews[reviewtotal] <- as.data.frame(review)
    }
  }
  total <- total + numlines
  print(total)
}

reviews <- reviews[reviews$review_id != "",]

save(reviews,file="rdata/reviews.RData")

#load("rdata/users.RData")
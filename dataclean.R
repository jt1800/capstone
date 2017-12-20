
library(hashmap)

setwd("C:/code/R/capstone/")

load("rdata/users.RData")
load("rdata/businesses.RData")
load("rdata/reviews.RData")


businesses$reviewed <- FALSE
businessidx <- hashmap(businesses$business_id,1:nrow(businesses))
useridx <- hashmap(users$user_id,1:nrow(users))

users$reviews <- 0
users$reviewSSE <- 0
for (i in 1:nrow(reviews)){
  bidx <- businessidx[[reviews$business_id[i]]]
  true_stars <- businesses$stars[bidx]
  businesses$reviewed[bidx] <- TRUE
  reviews$true_stars[i] <- true_stars
  sqerr <- (reviews$stars[i]-true_stars)^2
  if (!is.na(sqerr)){
    usidx <- useridx[[reviews$user_id[i]]]
    users$reviews[usidx] <- users$reviews[usidx] + 1
    users$reviewSSE[usidx] <- users$reviewSSE[usidx] + sqerr
  }
  if (i%%1000 == 0){
    print(i)
  }
}
businesses <- businesses[businesses$reviewed==TRUE,]
users$stddev <- (users$reviewSSE / users$reviews)^.5


save(users,file="rdata/users.RData")
save(businesses,file="rdata/businesses.RData")
save(reviews,file="rdata/reviews.RData")


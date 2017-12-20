
#install.packages('data.table')
#install.packages('jsonlite')
library(data.table)
library(jsonlite)
library(dplyr)

setwd("C:/code/R/capstone/")



#1183362 users

set.seed(2113)
usersample <- sample(1:1183362)
samplen <- 20000

num <- 100000
numlines <- num
total <- 0
fi <- file("dataset/user.json", open="r")

users <- data.table(user_id           = character(samplen),
                    name              = character(samplen),
                    review_count      = numeric(samplen),
                    yelping_since     = numeric(samplen),
                    friends           = numeric(samplen),
                    useful            = numeric(samplen),
                    funny             = numeric(samplen),
                    cool              = numeric(samplen),
                    fans              = numeric(samplen),
                    elite             = numeric(samplen),
                    average_stars     = numeric(samplen),
                    compliment_hot    = numeric(samplen),
                    compliment_more   = numeric(samplen),
                    compliment_profile= numeric(samplen),
                    compliment_cute   = numeric(samplen),
                    compliment_list   = numeric(samplen),
                    compliment_note   = numeric(samplen),
                    compliment_plain  = numeric(samplen),
                    compliment_cool   = numeric(samplen),
                    compliment_funny  = numeric(samplen),
                    compliment_writer = numeric(samplen),
                    compliment_photos = numeric(samplen))
cols <- names(users)
usertotal <- 0
repeat{
  lines <- readLines(fi, n = num)
  numlines <- length(lines)
  if (numlines <= 0) break
  for (i in 1:numlines){
    if (usersample[i] <= samplen){
      user <- fromJSON(lines[i])
      user <- user[cols]
      user$friends <- length(user$friends)
      user$elite <- length(user$elite)
      user$yelping_since <- as.numeric(as.Date(user$yelping_since))
      user[sapply(user, is.null)] <- NA
      usertotal <- usertotal+1
      users[usertotal] <- as.data.frame(user)
    }
  }
  total <- total + numlines
  print(total)
}

save(users,file="rdata/users.RData")

#load("rdata/users.RData")
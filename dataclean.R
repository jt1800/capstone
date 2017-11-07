

#install.packages('jsonlite')
library(jsonlite)
library(dplyr)

lines <- readLines(file("D:/code/R/capstone/dataset/user.json"), n = 10000)

users <- data.frame()

for (i in 1:length(lines)){
  user <- fromJSON(lines[i])
  user$friends <- length(user$friends)
  user$elite <- length(user$elite)
  users <- rbind(users, data.frame(user))
  if (i%%1000 == 0){
    print(i)
  }
}


#user <- stream_in(file("D:/code/R/capstone/dataset/user.json"),pagesize=100000)

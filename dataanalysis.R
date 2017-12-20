

setwd("C:/code/R/capstone/")

load("rdata/users.RData")
load("rdata/businesses.RData")
load("rdata/reviews.RData")
library(ggplot2)


l <- lm(stddev ~ friends + yelping_since + elite + average_stars + review_count, data = users)
summary(l)
comp <- lm(stddev ~ fans + yelping_since + elite + average_stars + review_count, data = users)
summary(comp)


#compliment_hot+compliment_more+compliment_profile+
#compliment_cute+compliment_list+compliment_note+compliment_plain+
#compliment_cool+compliment_funny+compliment_writer+compliment_photos
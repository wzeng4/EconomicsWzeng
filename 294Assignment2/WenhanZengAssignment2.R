# ---
# title: Assignment 2
# author: "Wenhan Zeng"
# date: "Jan.21.2016"
# assignment: https://github.com/EconomiCurtis/econ294_2015/blob/master/Assignments/Econ_294_Assignment_2.pdf
# ---

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# Question 0

WenhanZengAssignment2 <- list(
  firstName = "Wenhan",
  lastName  = "Zeng",
  email     = "wzeng4@ucsc.edu",
  studentID = 1504976
)
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# Question 1
library(foreign)
diamonds<-get(
    load(file=url("https://github.com/EconomiCurtis/econ294_2015/raw/master/data/diamonds.RData"))
)


WenhanZengAssignment2$s1a <- nrow(diamonds)
WenhanZengAssignment2$s1b <- ncol(diamonds)
WenhanZengAssignment2$s1c <- names(diamonds)
WenhanZengAssignment2$s1d <- summary(diamonds$price)
print(summary(diamonds$price))

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# Question 2
NHIS<-read.table(file="https://github.com/EconomiCurtis/econ294_2015/raw/master/data/NHIS_2007_TSV.txt",header=TRUE)

WenhanZengAssignment2$s2a <- nrow(NHIS) # the number of obs.
WenhanZengAssignment2$s2b <- ncol(NHIS) # the number of columns.
WenhanZengAssignment2$s2c <- names(NHIS)# headers' names.
WenhanZengAssignment2$s2d <- mean(NHIS$weight) # mean weight.
WenhanZengAssignment2$s2e <- median(NHIS$weight) # median weight.
#I didn't take the group with 996~999 pounds out in questions above, though these are just different type of missing value.
NHIS["ADJweight"] <-ifelse(NHIS$weight>900,NA,NHIS$weight)
WenhanZengAssignment2$s2d<- mean(NHIS$ADJweight) # mean weight.

hist(NHIS$weight,main="Histogram of weight",
     xlab="weight",
     ylab="frequency",
     border="black",
     col="cadetblue",
     breaks=40)
  
  
  

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#    save(CurtisKephartAssignment2,
#         file = "Assignments/CurtisKephartAssignment2.RData")






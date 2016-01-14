# ---
# title: Assignment 2
# author: "Wenhan Zeng"
# date: "Jan.21.2016"
# assignment: https://github.com/EconomiCurtis/econ294_2015/blob/master/Assignments/Econ_294_Assignment_2.pdf
# ---


## Setup for rdata file ########### NOOOOOOOOOOT finished
setwd("/Users/Zephyr/Desktop/2015-2016Master@UCSC/294a Lab/Econ294-Wenhan/294Assignment2")

symbols<-c("firstName","lastName","email","studentID")
firstName<-  "Wenhan"
lastName<- "Zeng"
email<-  "wzeng4@ucsc.edu"
studentID<- 1504976
save(list=symbols,file="WenhanZengAssignment2.rdata")

require(datasets)
WenhanZengAssignment2<-unlist(as,list(WenhanZengAssignment2))

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# Question 0

WenhanZengAssignment2 <- list(
  firstName = "Wenhan",
  lastName  = "Zeng",
  email     = "wzeng4@ucsc.edu",
  studentID = 1504976
)






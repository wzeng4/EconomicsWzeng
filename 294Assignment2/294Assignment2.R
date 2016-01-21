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


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#    save(CurtisKephartAssignment2,
#         file = "Assignments/CurtisKephartAssignment2.RData")






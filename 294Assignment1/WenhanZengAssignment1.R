### Lab Assignment 1 ###
### Wenhan Zeng ###

print("Name: Wenhan Zeng")
print("Student ID: 1504976")

## 1 ## 
library("foreign")
#From .dta
df.dta<-read.dta(file = "https://github.com/EconomiCurtis/econ294_2015/raw/master/data/NHIS_2007_dta.dta")
#From CSV.
df.csv<-read.csv(file = "https://github.com/EconomiCurtis/econ294_2015/raw/master/data/NHIS_2007_CSV.csv")
#From Tab deliniated
df.td<-read.table(file = "https://github.com/EconomiCurtis/econ294_2015/raw/master/data/NHIS_2007_TSV.txt")
#From .RData.
load(url("https://github.com/EconomiCurtis/econ294_2015/raw/master/data/NHIS_2007_RData.RData"))
print("The name assigned to this RData file: NHIS_2007_RData")

## 2 ##
setwd("/Users/Zephyr/Desktop/2015-2016Master@UCSC/294a Lab/Econ294-Wenhan/DataAssignment1")
# I changed the working directory here for convinience purpose but this might not work on another pc.
download.file("github.com/EconomiCurtis/econ294_2015/raw/master/data/NHIS_2007_dta.dta",destfile = "df.dta")
download.file("github.com/EconomiCurtis/econ294_2015/raw/master/data/NHIS_2007_CSV.csv",destfile = "df.csv")
download.file("github.com/EconomiCurtis/econ294_2015/raw/master/data/NHIS_2007_TSV.txt",destfile = "df.tb")
download.file("github.com/EconomiCurtis/econ294_2015/raw/master/data/NHIS_2007_RData.RData",destfile = "NHIS_2007_RData")

print("As we can see on the right side of Rsudio:df.dta is 188.5kb, df.csv is 138.6kb, df.tb is 138.6kb, NHIS_2007_RData is 45.3kb, and we can tell that the NHIS is the smallest.")

## 3 ##
rdata<- NHIS_2007_RData
typeof(rdata)
class(rdata)
print("For this data, it has the structure with 'typeof'as list,and 'class' as data.frame")

print(paste0("length:", length(rdata)))
print(paste0("dim:", dim(rdata)))
print(paste0("nrow:", nrow(rdata)))
print(paste0("ncol:", ncol(rdata)))
print(paste0("summary:", summary(rdata)))

## 4 ##
df.dta<-read.dta(file = "https://github.com/EconomiCurtis/econ294_2015/raw/master/data/org_example.dta")
df<-df.dta
str(df)
print("There are 1119754 observations in df with 30 variables.")

summary(df$rw)
print("the min of rw is 1.8, the mean of rw is 19.8, the median of rw is 15.9,and the max of rw is 354.8")

## 5 ##
v<-c(1,2,3,4,5,6,7,4,NULL,NA)
print(paste0("The length of 'v' is:", length(v)))
print("The reason is that 'null' means that there is a blank variable in the vector")
vn<-as.numeric(v)

print(paste0("The mean without NA is ", mean(vn,na.rm=TRUE)))

## 6 ##
x<-matrix(1:9, nrow=3,ncol=3,byrow=TRUE)
print(x)
print("Changing the 'byrow' into FALSE and we get the transpose of matrix x")
x_trans<-matrix(1:9, nrow=3,ncol=3,byrow=FALSE)
print(x_trans)

#eigenvalue:
eigen(x)

## 6-matrix of y ##
yc<-c(1,2,3,3,2,1,2,3,0)
y<-matrix(yc, nrow=3, ncol=3, byrow=TRUE)
y

y_inverse<-solve(y) # Using solve() to calculate the inverse of a matrix
print(y_inverse)
I<-y%*%y_inverse
I
print("Above is an identity matrix")

## 7 ##
carat<-c(5,2,0.5,1.5,5,NA,3)
cut<-c("fair","good","very good","good","fair","ideal","fair")
clarity<-c("SI1","I1","VI1","VS1","IF","VVS2",NA)
price<-c(850,450,450,NA,750,980,420)
diamonds<-data.frame(carat,cut,clarity,price)
diamonds
### mean = 650
print(paste0("The mean price is ",mean(diamonds$price,na.rm=TRUE)))
### mean of cut "fair" = 673.3
diamondsfair<-subset(diamonds,(cut=="fair"))
diamondsfair
print(paste0("The mean price is ",mean(diamondsfair$price,na.rm=TRUE)))
### mean of cut "others" = 626.7
diamondsother<-subset(diamonds,(cut!="fair"))
diamondsother
print(paste0("The mean price is ",mean(diamondsother$price,na.rm=TRUE)))
### median price of diamonds with greater than 2 carats, and cut "Ideal" or "very good"
diamondsM<-subset(diamonds,(carat>2 & cut=="Ideal"& cut=="very good"))
diamondsM
print("There is no such diamond that meets the conditions")

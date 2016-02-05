#' Wenhan Zeng
#' Winter 2016
#' WenhanZengAssignment3.R
#' 


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 0 
print("Wenhan Zeng")
print(1504976)
print("wzeng4@ucsc.edu")


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 1
library(foreign)
rm(list = ls())
df.ex <- read.dta(
  "https://github.com/EconomiCurtis/econ294_2015/raw/master/data/org_example.dta"
)
#loaded this way, it's a data frae
class(df.ex)


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 2
require(dplyr)
df.ex.2 <- df.ex %>%
  dplyr::filter(
  year == 2013 & month == 12
)
print(nrow(df.ex.2))

df.ex.2 <- df.ex %>%
  dplyr::filter(
    year == 2013 & (month == 7 | month == 8 | month == 9)
)
print(nrow(df.ex.2))

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 3
df.ex.3a<-df.ex %>%
  arrange(year, month)
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 4

#new data frame with only columns `year` through `age`.
df.ex.4a<-df.ex %>%
  select(year:age)

#new data frame with only columns year, month, and columns that start with `i`.
df.ex.4b<-df.ex %>%
  select(year, month, starts_with("i"))

#For the variable `state` print the distinct set of values in the original df.ex.
print(distinct(select(df.ex,state)))
  
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 5
#new functions
stndz<-function(x){
  (x-mean(x,na.rm=T))/sd(x,na.rm=T)
}
nrmlz<-function(x){
  (x-min(x,na.rm=T))/(max(x,na.rm=T)-min(x,na.rm=T))
}
#new data frame
df.ex.5a<-df.ex %>%
  transmute(
    rw.stndz=stndz(rw),
    rw_nrmlz=nrmlz(rw)
  )
#new data frame
df.ex.5b<-df.ex %>%
  group_by(year,month) %>%
  transmute(
    rw_stndz=stndz(rw),
    rw_nrmlz=nrmlz(rw),
    count   =n()
  ) 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 6
df.ex.6<-df.ex %>%
  ungroup() %>%
  group_by(year, month, state) %>%
  summarize(
    rw_min   =min(rw,na.rm=T),
    rw_1stQnt=quantile(rw,0.25,na.rm=T),
    rw_mean  =mean(rw,na.rm=T),
    rw_median=median(rw,na.rm=T),
    rw_3rdQnt=quantile(rw,0.75,na.rm=T),
    rw_max   =max(rw,na.rm=T),
    count    =n()
  )
print(nrow(df.ex.6))
#highest mean real wage
df.ex.6b<-df.ex.6 %>%  
    ungroup() %>%
    arrange(desc(rw_mean)) %>%
    select(year,month,state,rw_mean) %>%
    head(1)
print(df.ex.6b)
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 7
state1<-as.character(df.ex$state)
df.ex.7a<-df.ex %>%
  arrange(year,month,desc(state1))

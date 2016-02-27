# load packages
library(foreign)
library(ggplot2)
library(knitr)
library(nycflights13)
library(dplyr)
library(RSQLite)
# require data from database
my_db<- src_sqlite("nycflights13.sqlite", create = T)
flights_sqlite <- copy_to(
  my_db, flights, temporary = FALSE, 
  indexes = list(
    c("year", "month", "day"), 
    "carrier", 
    "tailnum")
)
rm(flights)
remove(flights,envir=nycflights13)
rm(flights)

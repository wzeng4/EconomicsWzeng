# load packages
library(foreign)
library(ggplot2)
library(knitr)
library(nycflights13)
library(dplyr)
library(tidyr)
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
flights<-collect(flights_sqlite)

airlines_sqlite <- copy_to(
  my_db, airlines, temporary = FALSE, 
  indexes = list("carrier")
)
airlines<-collect(airlines_sqlite)

airports_sqlite <- copy_to(
  my_db, airports, temporary = FALSE, 
  indexes = list("faa")
)
airports<-collect(airports_sqlite)

planes_sqlite <- copy_to(
  my_db, planes, temporary = FALSE, 
  indexes = list("tailnum")
)
planes<-collect(planes_sqlite)

weather_sqlite <- copy_to(
  my_db, weather, temporary = FALSE, 
  indexes = list(
    c("year", "month","day","hour"),
    "origin")
)
weather<-collect(weather_sqlite)

# add carrier information from airlines to flights
final<-flights %>%
  left_join(airlines, by="carrier")

# creat column "date"
final<- final %>%
  mutate(canceled= ifelse(is.na(arr_time),1,0))%>%
  unite(
    col=date,
    ...=year,month,day,
    sep="-"
  )

weather<-weather %>%
  unite(
    col=date,
    ...=year,month,day,
    sep="-"
  ) %>%
  select(origin:wind_gust,visib)
names(final)[names(final) %in% names(weather)]
# we get "date""origin""hour" matched in two tables.
finalw<-final %>%
  left_join(weather, by=c('date','hour','origin'))

# keep all flights with weather information
finalw<-finalw %>%
  filter(is.na(temp)==F) %>%
  group_by(canceled)

finalw<finalw %>%
  group_by(canceled)
# reg
regdelay<-lm(dep_delay~temp+dewp+wind_speed+visib,finalw)
summary(reg)
regcancel<-glm(canceled~dep_delay+temp+dewp+humid+wind_speed+visib,finalw,family = binomial(logit))
summary(regcancel)

# find all the canceled flights
finalwcancel<-finalw %>%
  filter(canceled==1)



p1<-ggplot(
  data = finalw,
  aes(x = temp,y=dep_delay,size=wind_speed)
)+
  geom_point(aes(colour=visib), alpha=0.4)
p1

p2<-ggplot(
  data=finalw,
  aes(dep_delay,fill=factor(dewp))
)+
  geom_histogram(aes(dep_delay,..density..))+
  facet_grid("canceled~.")
p2








p3<-ggplot(
  data=final)
)+
  geom_histogram(aes(x=date,y=dep_delay))
p3
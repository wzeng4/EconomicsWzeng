print("First name: Wenhan")
print("Last name: Zeng")
print("Student ID: 1504976")

### Q1 ###
library(foreign)
flights<-read.csv("https://raw.githubusercontent.com/EconomiCurtis/econ294_2015/master/data/flights.csv",stringsAsFactors = F)
planes<-read.csv("https://raw.githubusercontent.com/EconomiCurtis/econ294_2015/master/data/planes.csv",stringsAsFactors = F)
weather<-read.csv("https://raw.githubusercontent.com/EconomiCurtis/econ294_2015/master/data/weather.csv",stringsAsFactors = F)
airports<-read.csv("https://raw.githubusercontent.com/EconomiCurtis/econ294_2015/master/data/airports.csv",stringsAsFactors = F)

### Q2 ###
flights$date <- as.Date(flights$date, "%Y-%m-%d %H:%M:%S")
class(flights$date)

weather$date <- as.Date(weather$date, "%Y-%m-%d")
class(weather$date)

### Q3 ###
library(dplyr)
flights2a <- flights %>%
  dplyr::filter(
    dest == "SFO" | dest == "OAK"
  )
flights2b <- flights %>%
  dplyr::filter(
    dep_delay >= 60 | arr_delay >= 60
  )
flights2c <- flights %>%
  dplyr::filter(
    (arr_delay > 2*as.numeric(dep_delay)) & (dep_delay>0)
  )

### Q4 ###
?select
flights %>%
  select(arr_delay,dep_delay)
flights %>%
  select(ends_with("delay"))
flights %>%
  select(contains("delay"))

### Q5 ###
## 5a ##
print(flights %>%
        arrange(-dep_delay) %>%
        head(5))

## 5b ##
print(flights %>%
        mutate(catup=dep_delay-arr_delay)%>%
        arrange(-catup)%>%
        select(time,dep_delay,arr_delay,plane,catup)%>%
        head(5)
)
### Q6 ###
flights$speed <- mutate(flights,speed=dist/time)
View(flights$speed)
flights$delta <- mutate(flights, delta=dep_delay-arr_delay)
View(flights$delta)

##a
print(
  flight%>%
    arrange(speed)%>%
    select(time,plane,speed)%>%
    head(5)
)
##b
print(
  flight%>%
    arrange(delta)%>%
    select(time,plane,dep_delay,arr_delay,delta)%>%
    head(5)
)

### Q7 ###
## 7a ##
flights7a <- flights %>%
  group_by(carrier) %>%               
  summarise(
    cancel = sum(cancelled),
    total = n(),
    ratio = cancel/total, 
    min_d = min(delta, na.rm = T),
    quarter1_d = quantile(delta, .25, na.rm = T),
    quarter2_d = quantile(delta, .75, na.rm = T),
    median_d = median(delta,na.rm = T),
    mean_d = mean(delta, na.rm = T),
    quantile3_d = quantile(delta, .90, na.rm = T),
    max_d = max(delta, na.rm = T)
  )

## 7b ##
print("this code find the rows in which the value of 'dep_delay' is not 'NA'")
print("and then group the data by data, summarize the mean value of 'dep_delay',count the number of obs")
#transform the original one using "%>%"
day_delay <- flights %>%
  dplyr::filter(!is.na(dep_delay))%>%
  group_by(date)%>%
  summarise(delay = mean(dep_delay),
            n = n()
  )%>%
  filter(n>10)
### Q8 ###
print(
  mutate(
    day_delay, differ = delay-lag(delay)
  )%>%
    arrange(
      -differ
    )%>%
    head(5)
)

### Q9 ###
dest_delay<-flights %>% 
  group_by(dest) %>%
  summarise (
    mean_ad = mean(arr_delay, na.rm = T),
    number=n()
  )
airports2<-airports %>%
  select(dest = iata, 
         name = airport,
         city,state, lat, long
)
# left join
df.9a<-dest_delay %>% 
  left_join(airports2,by="dest")
print(nrow(df.9a))
#116 obs

# inner join
df.9b<-dest_delay %>% 
  inner_join(airports2,by="dest")

print(df.9b%>%
        select(city,state,mean_ad)%>%
        head(5)
)
print(nrow(df.9b)) 
# they don't match because the inner join only keeps those shared variables,
# while the left join will leave those missing/unmatch value NA.

#right join
df.9c<- dest_delay%>% 
  right_join(airports2,by="dest")
print(nrow(df.9c)) 
# 3376 obs
# we have more obs in "airports2" than dest_delay. And all the unmatched rows in "airports2" will  show up in df.9c
# we have NA in arr_delay,because we don't have such variable in "airports2" called  mean_ad.
# unmatched data will show as NA.

#d. full_join
df.9d <- dest_delay%>% 
  full_join(airports2,by="dest")
print(nrow(df.9d)) 
## we have 3378 obs. Here we have all variables from both datasets. And no "NA"in arr_delay.

### Q10 ###

hourly_delay<- filter(flights,!is.na(dep_delay))%>%
  group_by(date,hour)%>%
  summarise(
    delay = mean(dep_delay),
    n = n()
  )%>%
  filter(n>10)

df.10<- hourly_delay%>% 
  inner_join(weather)

print(df.10%>%
        group_by(conditions)%>%
        summarise(
          max_dl=max(delay,na.rm=T)
        )
)

### Q11 ###
## 11a ##
df <- data.frame(
  treatment = c("a", "b"), 
  subject1 = c(3, 4), 
  subject2 = c(5, 6)
)

df.11a <- df %>% 
  gather(demo,value,
         ...= -treatment) %>%
  rename(subject=demo)%>%
  select(subject,treatment,value)

df.11a[1,"subject"]<- 1
df.11a[2,"subject"]<- 1
df.11a[3,"subject"]<- 2
df.11a[4,"subject"]<- 2
df.11a


## 11b ##
df <- data.frame(
  subject = c(1,1,2,2),
  treatment = c("a","b","a","b"),
  value = c(3,4,5,6)
)

df.11b <-df %>%
  arrange(treatment,subject)%>%
  spread(
    key = subject,
    value = value
  ) %>%
  rename(subject1=`1`,subject2=`2`)

## 11c ##

df <- data.frame(
  subject = c(1,2,3,4),
  demo = c("f_15_CA","f_50_NY","m_45_HI","m_18_DC"),
  value = c(3,4,5,6)
)
df.11c <- df %>%
  separate(
    demo, 
    c("sex", "age", "state"), #name of new column(s)
    "_"
  )

## 11d ##
df <- data.frame(
  subject = c(1,2,3,4),
  sex = c("f","f","m",NA),
  age = c(11,55,65,NA),
  city = c("DC","NY","WA",NA),
  value = c(3,4,5,6)
)

df11.d <- df %>%
  unite(
    col = demo, 
    ... = sex, age, city,
    sep = "."
  )
df11.d[4,2] = "<NA>"





# 294 Assignment5
# Wenhan Zeng
# 1504976

#1a
library(ggplot2)

str(diamonds)
a1<-ggplot(
  data = diamonds,
  aes(x = x*y*z,y=price,size=carat)
)+
  geom_point(aes(colour=clarity), alpha=0.4)+
  scale_x_log10()+
  scale_y_log10()
a1

#1b
b1<-ggplot(
  data=diamonds,
  aes(carat,..density..)
  )+
  geom_histogram(aes(colour=clarity,fill=clarity))+
  facet_grid("cut~.")
b1

#1c
c1<-ggplot(
  data=diamonds,
  aes(x=cut,y=price)
)+
  geom_violin()+
  geom_jitter(alpha=0.01)
  c1

#3a
library(foreign)
library(dplyr)
org_example<-read.dta("/Users/Zephyr/Desktop/2015-2016Master@UCSC/294a Lab/econ294_2015/data/org_example.dta")

org_example.plotprep<-org_example %>%
  group_by(year,month)%>%
  summarize(
    rw.med=median(rw,na.rm=T),
    rw.90=quantile(rw,0.9,na.rm=T),
    rw.10=quantile(rw,0.1,na.rm=T),
    rw.25=quantile(rw,0.25,na.rm=T),
    rw.75.1=quantile(rw,0.75,na.rm=T,type=1),
    rw.75.2=quantile(rw,0.75,na.rm=T,type=2),
    rw.75.3=quantile(rw,0.75,na.rm=T,type=3),
    rw.75.4=quantile(rw,0.75,na.rm=T,type=4),
    rw.75.5=quantile(rw,0.75,na.rm=T,type=5),
    rw.75.6=quantile(rw,0.75,na.rm=T,type=6),
    rw.75.7=quantile(rw,0.75,na.rm=T,type=7),
    rw.75.8=quantile(rw,0.75,na.rm=T,type=8),
    rw.75.9=quantile(rw,0.75,na.rm=T,type=9)) %>%
  mutate(
    date=paste(year,month,"01",sep="-"),
    date=as.Date(date,format="%Y-%m-%d")
  )
ggplot(org_example.plotprep,
       aes(
         x=date,y=rw.med
         )
    )+
  geom_line()+
  geom_ribbon(aes(ymin=rw.10,ymax=rw.90), alpha=0.2)+
  geom_ribbon(aes(ymin=rw.25,ymax=rw.75.1), alpha=0.2)

#3b
org_example3<-org_example%>%
  group_by(year,month,educ)%>%
  summarize(
    Median.RW=median(rw,na.rm=T)
  )%>%
  mutate(
    date=paste(year,month,"01",sep="-"),
    date=as.Date(date,format="%Y-%m-%d")
)

ggplot(org_example3, 
       aes(date, Median.RW, 
           color = educ,
           group=educ))+
  geom_line()
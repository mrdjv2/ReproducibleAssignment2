#unz(download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2", "data.bz2"), "data.csv")

library(dplyr)

storm_data<-read.csv("data.csv")

pop_health<-data.frame(cbind(data.frame(storm_data$EVTYPE), data.frame(storm_data$FATALITIES), data.frame(storm_data$INJURIES)))

pop_health_fat<-aggregate(pop_health$storm_data.FATALITIES, by=list(evtype=pop_health$storm_data.EVTYPE), FUN=sum )
pop_health_inj<-aggregate(pop_health$storm_data.INJURIES, by=list(evtype=pop_health$storm_data.EVTYPE), FUN=sum )

names(pop_health_fat)<-c("EVTYPE", "FATALITIES")
names(pop_health_inj)<-c("EVTYPE", "INJURIES")

pop_health_agg<-merge(pop_health_fat, pop_health_inj, by= "EVTYPE")

pop_health_agg<-mutate(pop_health_agg, sum_casualties = pop_health_agg$FATALITIES+pop_health_agg$INJURIES)

temp<-pop_health_agg[order(-pop_health_agg$FATALITIES),]

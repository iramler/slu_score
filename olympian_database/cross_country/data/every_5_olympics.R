library(tidyr)
library(readr)

cc_2022 <- read_csv("olympian_database/cross_country/data/mens_15k_beijing_2022.csv")

cc_2022<-cc_2022%>%
  mutate(Year = "2022")



####
salt_lake_2002 <- read_csv("~/Documents/salt_lake_2002.csv", col_types = cols(Time = col_character()))  
salt_lake_2002 <- salt_lake_2002%>%
  select(1,2,4,6)%>%
  slice(1:66)%>%
  mutate(Time = str_replace_all(Time, "\\.", ":"),
         Time = str_replace_all(Time, ",", "."),
         Time = ms(Time),
         Time_sec = period_to_seconds(Time),
         Time_min = Time_sec/60,
         Year = "2002")
####

sarajevo_1984 <- read_csv("~/Documents/sarajevo_1984.csv", col_types = cols(Time = col_character()))  
sarajevo_1984_1 <- sarajevo_1984%>%
  select(1,2,4,6)%>%
  slice(1:79)%>%
  mutate(Time = str_replace_all(Time, "\\.", ":"),
         Time = str_replace_all(Time, ",", "."),
         Time = ms(Time),
         Time_sec = period_to_seconds(Time),
         Time_min = Time_sec/60,
         Year = "1984")

sarajevo_1984_2 <- sarajevo_1984%>%
  select(1,2,4,6)%>%
  slice(80:83)%>%
  mutate(Time = str_replace_all(Time, "\\.", ":"),
         Time = str_replace_all(Time, ",", "."),
         Time = hms(Time),
         Time_sec = period_to_seconds(Time),
         Time_min = Time_sec/60,
         Year = "1984")

sarajevo_1984<- rbind(sarajevo_1984_1, sarajevo_1984_2)


####
innsbruck_1964 <- read_csv("~/Documents/Innsbruck_1964.csv", col_types = cols(Time = col_character()))  
innsbruck_1964_1 <- innsbruck_1964%>%
  select(1,2,4,6)%>%
  slice(1:53)%>%
  mutate(Time = str_replace_all(Time, "\\.", ":"),
         Time = str_replace_all(Time, ",", "."),
         Time = ms(Time),
         Time_sec = period_to_seconds(Time),
         Time_min = Time_sec/60,
         Year = "1964")

innsbruck_1964_2 <- innsbruck_1964%>%
  select(1,2,4,6)%>%
  slice(54:69)%>%
  mutate(Time = str_replace_all(Time, "\\.", ":"),
         Time = str_replace_all(Time, ",", "."),
         Time = hms(Time),
         Time_sec = period_to_seconds(Time),
         Time_min = Time_sec/60,
         Year = "1964")

innsbruck_1964 <- rbind(innsbruck_1964_1, innsbruck_1964_2)
##### can be continued

every5_cc <- rbind(cc_2022, salt_lake_2002, sarajevo_1984, innsbruck_1964)


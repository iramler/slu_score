cc_2022 <- 
  read_csv("olympian_database/cross_country/data/mens_15k_beijing_2022.csv")
cc_2022<- cc_2022%>%
  mutate(Year = "2022")
# 2022 clean

cc_2018 <- read_csv("~/Documents/mens_15km_crosscountry_2018.csv", 
                    col_types = cols(Time = col_character()))
cc_2018 <- cc_2018%>%
  select(1,2,4,5)%>%
  slice(1:116)%>%
  mutate(Time = str_replace_all(Time, "\\.", ":"),
         Time = str_replace_all(Time, ",", "."),
         Time = ms(Time),
         Time_sec = period_to_seconds(Time),
         Time_min = Time_sec/60,
         Year = "2018")
# 2018 clean

cc_2014 <- read_csv("~/Documents/mens_15km_crosscountry_2014.csv")
cc_2014_extra <-cc_2014%>%
  slice(87)%>%
  select(1,2,4,5)%>%
  mutate(Time = str_replace_all(Time, "\\.", ":"),
         Time = str_replace_all(Time, ",", "."),
         Time = hms(Time),
         Time_sec = period_to_seconds(Time),
         Time_min = Time_sec/60,
         Year = "2014")
  
cc_2014 <- cc_2014%>%
  select(1,2,4,5)%>%
  slice(1:86)%>%
  mutate(Time = str_replace_all(Time, "\\.", ":"),
         Time = str_replace_all(Time, ",", "."),
         Time = ms(Time),
         Time_sec = period_to_seconds(Time),
         Time_min = Time_sec/60,
         Year = "2014")
# 2014 clean

cc_2010 <- read_csv("~/Documents/mens_15km_crosscountry_2010.csv",
                    col_types = cols(Time = col_character()))
cc_2010 <- cc_2010%>%
  select(1,2,4,5)%>%
  slice(1:95)%>%
  mutate(Time = str_replace_all(Time, "\\.", ":"),
         Time = str_replace_all(Time, ",", "."),
         Time = ms(Time),
         Time_sec = period_to_seconds(Time),
         Time_min = Time_sec/60, 
         Year = "2010")
# 2010 clean



mens_cc_2010_22 <- rbind(cc_2010,cc_2014,cc_2014_extra,cc_2018,cc_2022)

write_csv(x = mens_cc_2010_22,
          file = "olympian_database/cross_country/data/mens_cc_ski_2010-22.csv")

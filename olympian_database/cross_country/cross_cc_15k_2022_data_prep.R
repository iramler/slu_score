cross_country <- read_csv("~/Documents/Mens_15km_crosscountry.csv")

cross_country<- cross_country%>%
  select(1,2,4,5)%>%
  slice(1:95)


cross_country<- cross_country%>%
  mutate(Time = str_replace_all(Time, "\\.", ":"),
         Time = str_replace_all(Time, ",", "."),
         Time = ms(Time),
         Time_sec = period_to_seconds(Time),
         Time_min = Time_sec/60)


  

         
write_csv(cross_country, 
          file = "olympian_database/data/mens_15k_beijing_2022.csv")
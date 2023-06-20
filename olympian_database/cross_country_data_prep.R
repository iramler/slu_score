cross_country <- read_csv("~/Documents/Mens_15km_crosscountry.csv")

cross_country<- cross_country%>%
  select(1,2,4,5)%>%
  slice(1:95)


cross_country<- cross_country%>%
  mutate(Time = parse_character(Time),
    Time = str_replace_all(Time, ",", "."))


cross_country<- cross_country%>%
  mutate(Time = strptime(Time, format = "%M:%OS"))
  

         



# In the data set there are 6 bashos (tournaments) per year 
# It shows the resulting record of all competitors in the top division (Makuuchi Banzuke)
# Data goes from 1957 to 2023 (only 4 have occurred so far in 2023 thus far)
# certain years, certain bashos did not occur, but rare

# change number after year in link for different bashos


sumo_function <- function(i){
  
  base_url <- "https://sumodb.sumogames.de/Banzuke.aspx?b="
  end_url <- "11&heya=-1&shusshin=-1&h=on&sh=on&bd=on&w=on&hl=on&c=on"
  
  
  
  url <- paste0(base_url, i, end_url)
  
  tryCatch({
    objs <- read_html(url)%>%
      html_nodes("table")%>%
      html_table()
    
    X <- objs[[6]]
    
    return(X)
  }, error = function(e) {
    message(paste("Error occurred for year", i, "- Skipping..."))
    return(NULL)
  })
}



kyushu <- sumo_function(i = 2022)

for(i in 1957:2021){
  Sys.sleep(rpois(1, 3)+1)
  additional_rows <- sumo_function(i)
  
  tryCatch({
    kyushu <- bind_rows(kyushu, additional_rows)
  }, error = function(e) {
    message(paste("Error occurred while binding rows for year", i, "- Skipping..."))
  })
}

write_csv(x = hatsu, file = "sumo/data/hatsu.csv") 
# hatsu data from 1957-2023 COMPLETE (01)
 
write_csv(x = haru, file = "sumo/data/haru.csv") 
# haru data from 1957-2023 COMPLETE (03)

write_csv(x = natsu, file = "sumo/data/natsu.csv") 
# natsu data from 1957-2023 COMPLETE (05)
 
write_csv(x = nagoya, file = "sumo/data/nagoya.csv") 
# nagoya data from 1957-2022 COMPLETE (07)

write_csv(x = aki, file = "sumo/data/aki.csv") 
# aki data from 1957-2022 COMPLETE (09)

write_csv(x = kyushu, file = "sumo/data/kyushu.csv") 
# kyushu data from 1957-2022 COMPLETE (11)



sumo_since_1957 <- rbind(hatsu, haru, natsu, nagoya, aki, kyushu)

sumo_since_1957 <-sumo_since_1957%>%
  separate(col = Result, sep = "-", into = c("wins", "losses", "ties"))%>%
  mutate(wins = parse_number(wins),
         losses = parse_number(losses),
         ties = parse_number(ties))%>%
  separate(col = `Height/Weight`, sep = "cm", into = c("height_cm", "weight_kg"))%>%
  mutate(height_cm = parse_number(height_cm),
         weight_kg = parse_number(weight_kg))

# write_csv(x = sumo_since_1957, file = "sumo/data/sumo_since_1957.csv")




sumo$ties[is.na(sumo$ties)] <- 0

write_csv(x = sumo, file = "sumo/data/sumo_since_1957.csv")





# future goal with data: 
# get more data from even further back in history 
# transform data to be grouped by wrestler and have total wins that are tracked by each year 
# can show how many total wins they have in their career and the path they took to get there

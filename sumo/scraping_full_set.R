library(tidyverse)
library(rvest)




# Scraping all data for all bashos since 1757
# Ending in 2023

# Disclaimers:
# - tournaments do not consistently occur every year
# - scraping can be improved by figuring out when each division was added and changing the scraping process for those sections of years
# - the data during this time did not get scraped
# lots of variation makes it very difficult

# Current goal is to get the most possible 
# filter to wins or losses being greater than zero 




# probably makes sense to redo this within the time period where all the tables are the same 
# but non-ranked sometimes occur. Could work from I believe 1956 to present


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



full_11 <- sumo_function(i = 2022)



for(i in 1757:2021){
  Sys.sleep(rpois(1, 3)+1)
  additional_rows <- sumo_function(i)
  
  tryCatch({
  full_11 <- bind_rows(full_11, additional_rows)
}, error = function(e) {
  message(paste("Error occurred while binding rows for year", i, "- Skipping..."))
})
}



# full_01<- full_01%>%
#  select(1:7)
# write_csv(x = full_01, file = "sumo/data/full_01.csv") # 01
# 01 COMPLETE


# full_03<-full_03%>%
#  select(1:7)
#write_csv(x = full_03, file = "sumo/data/full_03.csv") # 03
# 03 COMPLETE

# full_05<-full_05%>%
#  select(1:7)
# write_csv(x = full_05, file = "sumo/data/full_05.csv") # 05
# 05 COMPLETE

# full_07<-full_07%>%
#  select(1:7)
# write_csv(x = full_07, file = "sumo/data/full_07.csv") 
# 07 COMPLETE

# full_09<-full_09%>%
#  select(1:7)
# write_csv(x = full_09, file = "sumo/data/full_09.csv") 
# 09 COMPLETE

 full_11<-full_11%>%
  select(1:7)
 write_csv(x = full_11, file = "sumo/data/full_11.csv") 
# 11 COMPLETE

# still need to clean 

# need to do this for 01,02,03,04,05,07,09,11

# 02 HAS 1865 MOST RECENT

# 04 1867 MOST RECENT

# 06 1868

# 08



# JUST USE ONE OF THEM FOR BASE AND REMOVE LATER

# EVEN NUMBERS CLEANING 

full_02 <- sumo_function(i = tbd)



for(i in 1757:tbd){
  Sys.sleep(rpois(1, 3)+1)
  additional_rows <- sumo_function(i)
  
  tryCatch({
    full_02 <- bind_rows(full_02, additional_rows)
  }, error = function(e) {
    message(paste("Error occurred while binding rows for year", i, "- Skipping..."))
  })
}


for(i in tbd:2023){
  Sys.sleep(rpois(1, 3)+1)
  additional_rows <- sumo_function(i)
  
  tryCatch({
    full_07 <- bind_rows(full_07, additional_rows)
  }, error = function(e) {
    message(paste("Error occurred while binding rows for year", i, "- Skipping..."))
  })
}

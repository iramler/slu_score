library(tidyverse)
library(rvest)




# Scraping data from the top division for all Natsu bashos in history
# Division: Makuuchi Banzuke
# Starting in 1757
# Ending in 2023
sumo_function <- function(i){
  
  base_url <- "https://sumodb.sumogames.de/Banzuke.aspx?b="
  
  end_url <- "05&heya=-1&shusshin=-1&h=on&sh=on&bd=on&w=on&hl=on&c=on"
  
  
  url <- paste0(base_url, i, end_url)
  
  objs <- read_html(url)%>%
  html_nodes("table")%>%
  html_table()
  
X <- objs[[6]]
  
  return(X)
}


natsu_full <- sumo_function(i = 2023)




for(i in 1757:2022){
  Sys.sleep(rpois(1, 3)+1)
  additional_rows <- sumo_function(i)
  
  
  natsu_full <- bind_rows(natsu_full, additional_rows)
}







# scrape first one 
# change 2nd result name 
# do same for the rest in for loop 
# bind rows to original in the loop 
# clean after

# to get all tournaments do for loop inside for loop (with exception to 11)
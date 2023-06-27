library(tidyverse)
library(rvest)

# need to find a way so i dont have to change the basho number everytime 
# but its 01, not 1, and goes to 11. Another issue is they go up by 2


# currently best idea is to have one function for the first 5 then one for the last because it changes to 11


# 01-09

sumo_function <- function(i, year = 2019:2023){
  
  base_url <- "https://sumodb.sumogames.de/Banzuke.aspx?b="
  
  end_url <- "05&heya=-1&shusshin=-1&bd=on&w=on&hl=on"
  
  
  url <- paste0(base_url, i, end_url)
  
  objs <- read_html(url)%>%
  html_nodes("table")%>%
  html_table()
  
X <- objs[[6]]
  
  return(X)
}

# 2023
sumo_2023 <- sumo_function(i)
sumo_2023<-
  sumo_2023%>%
  as.data.frame()


for(i in 2019:2022){
  Sys.sleep(rpois(1, 3)+1)
  additional_rows <- sumo_function(i)
  
  additional_rows<- additional_rows%>%
    as.data.frame()
  
  natsu_2023 <- bind_rows("2023" = natsu_2023, "2022" = additional_rows, .id = "year")
}
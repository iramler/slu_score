library(tidyverse)
library(rvest)

# need to find a way so i dont have to change the basho number everytime 
# but its 01, not 1, and goes to 11. Another issue is they go up by 2


# currently best idea is to have one function for the first 5 then one for the last because it changes to 11

sumo_function <- function(i, year = 2019:2023, basho = 01:11){
  
  base_url <- "https://sumodb.sumogames.de/Banzuke.aspx?b="
  
  end_url <- "&search%5Bage_class%5D="
  
  
  url <- paste0(base_url, i, middle_url, sex, end_url, age)
  
  obs <- read_html(url) |> 
    html_nodes("li.list-group-item")
  
  tmp <- obs |> html_text(trim = TRUE)
  X <- tmp[-(1:2)] |> str_split(pattern = "(\n)+", simplify = TRUE)
  
  return(X)
}

# 2023
sumo_2023 <- sumo_function(i = 1, sex = "W", age = 1)
sumo_2023<-
  sumo_2023%>%
  as.data.frame()


for(i in seq(from=1, to=78, by=2)){
  Sys.sleep(rpois(1, 3)+1)
  additional_rows <- sumo_function(i, sex = "W", age = 1)
  
  additional_rows<- additional_rows%>%
    as.data.frame()
  
  sumo_2023 <- bind_rows("2023" = sumo_2023, "2022" = additional_rows, .id = "age_group")
}
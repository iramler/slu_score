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


# doesn't work great unless the pdf is quite clean

url <- "https://www.fis-ski.com/DB/general/results.html?sectorcode=CC&raceid=39416"
objs <- read_html(url)%>%
  html_nodes("table")%>%
  html_table()

library(pdftools)

url <- "https://medias4.fis-ski.com/pdf/2023/CC/4024/2023CC4024RL.pdf"
              

txt <- map(url, pdf_text)


clean_table <- function(raw){
  
  raw <- map(raw, ~ str_split(.x, "\\n")%>%unlist())
  
  raw <- reduce(raw, c)
  
  table_start <- stringr::str_which(str_to_lower(raw),"name")
  table_end <- stringr::str_which(str_to_lower(raw), "time")
  table_end <- table_end[min(which(table_end>table_start))]
  
  table <- raw[(table_start):(table_end)]
  table <- str_replace_all(table, "\\s{2,}", "|")
  text_con <- textConnection(table)
  data_table <- read.csv(text_con, sep = "|")
  
  colnames(data_table) <- c("x", "name", "racer_number", "FIS_licence", "YOB",
                             "country", "race_points", "lap1", "lap2", "lap3",
                             "lap4", "time")
  data_table
}

results <- map_df(txt, clean_table)
head(results)




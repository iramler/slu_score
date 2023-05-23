library("DBI")

batting2021 <- readr::read_csv("batting2021.csv")
batting2022 <- readr::read_csv("batting2022.csv")

con <- dbConnect(RSQLite::SQLite(), "softball_batting.sqlite")
dbWriteTable(con, "batting2021", batting2021)
dbWriteTable(con, "batting2022", batting2022)
dbListTables(con)
dbDisconnect(con)


con2 <- dbConnect(duckdb::duckdb(), dbdir = "softball_batting.duckdb")
dbWriteTable(con2, "batting2021", batting2021)
dbWriteTable(con2, "batting2022", batting2022)
dbListTables(con2)
dbDisconnect(con2)







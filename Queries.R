#Reto1 Sesion 7
install.packages("DBI")
library(DBI)

MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

install.packages("dplyr")
library(dplyr)

dbListTables(MyDataBase)
dbListFields(MyDataBase, 'CountryLanguage')

#porcentaje de personas que hablan español en todos los países

DataDB <- dbGetQuery(MyDataBase, "select * from CountryLanguage")
summary(DataDB)

espanol <- DataDB %>% filter (Language == "Spanish" ,
                             Percentage > 0)
#ggplot
install.packages("ggplot2")
library(ggplot2)

ggplot(espanol, aes(x=CountryCode, y= reorder(Percentage)+geom_col()+coord_flip))

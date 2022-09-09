library(dplyr)
library(ggplot2)
library(sqldf)
library(readr)

archivo <- readr::read_csv("C:/Users/rpfu1/OneDrive/Escritorio/UBB/2022-1/R/Proyecto Semestral/data_csv.csv")

# todo_df <- sqldf('SELECT * FROM archivo')
# head(todo_df)

# glimpse(archivo)



# ano_comercial <- sqldf('SELECT ano_comercial
#       FROM archivo')

# Razon_social <- sqldf('SELECT COUNT(Tramo_segun_ventas)
#       FROM archivo')

Razon_social <- sqldf('SELECT Ano_comercial, COUNT(Razon_social) AS num_cols
      FROM archivo
      GROUP BY Ano_comercial')

query_2 <- sqldf('SELECT Tramo_segun_ventas, COUNT(Razon_social) AS Empresas
      FROM archivo
      GROUP BY Tramo_segun_ventas')

query_3 <- sqldf('SELECT COUNT(Razon_social) AS Empresas, Region 
      FROM archivo
      GROUP BY Region')     

query_4 <- sqldf('SELECT COUNT(Razon_social) AS Empresas, Provincia 
      FROM archivo
      GROUP BY Provincia')   
query_5 <- sqldf('SELECT COUNT(Razon_social) AS Empresas, Comuna 
      FROM archivo
      GROUP BY Comuna')  

query_6 <- sqldf('SELECT COUNT(Razon_social) AS Empresas, Actividad_economica 
      FROM archivo
      GROUP BY Actividad_economica') 

query_7 <- sqldf('SELECT 
                SUM(Numero_de_trabajadores_dependientes_informados) as "Cantidad Trabajadores",                              
                Rubro_economico as "Rubro Economico",
                Region
      FROM archivo 
      GROUP BY Rubro_economico
      ORDER BY "Cantidad Trabajadores"')       

query_8 <- sqldf('SELECT Razon_social, Comuna 
      FROM archivo
      WHERE Comuna="CURANILAHUE"')      

query_9 <- sqldf("SELECT Rubro_economico FROM archivo GROUP BY Rubro_economico")

query_10 <- sqldf("SELECT Subtipo_de_contribuyente FROM archivo")

query_11 <- sqldf('SELECT count(Razon_social), Ano_comercial
      FROM archivo
      group by Ano_comercial')  

myplot <- ggplot(Razon_social, aes(x = Ano_comercial, y = num_cols)) +
    geom_bar(stat = "identity", fill = "blue") +
    ggtitle('My title')



# myplot <- ggplot(a) +
#     geom_col(aes(x = x, y = y)) +
#     ggtitle('My title')

# # print(myplot)

# myplot2 <- ggplot(myplot, aes(x = ano_comercial, y = dv)) +
#     geom_bar(stat = "identity")
    
# ggplot(archivo, aes(Ano_comercial, Ano_comercial)) + geom_col()


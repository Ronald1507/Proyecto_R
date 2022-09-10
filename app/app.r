library(dplyr)
library(ggplot2)
library(sqldf)
library(readr)
# options(scipen=3)
options(scipen=999)

archivo <- readr::read_csv("C:/Users/rpfu1/OneDrive/Escritorio/UBB/2022-1/R/Proyecto Semestral/data_csv.csv")

Razon_social <- sqldf('SELECT Ano_comercial, COUNT(Razon_social) AS num_cols
      FROM archivo
      GROUP BY Ano_comercial')

  

# query_02 <- sqldf('SELECT Tramo_segun_ventas, COUNT(Razon_social) AS Empresas
#       FROM archivo
#       GROUP BY Tramo_segun_ventas')

query_03 <- sqldf('SELECT COUNT(Razon_social) AS Empresas, Region 
      FROM archivo
      GROUP BY Region')     

query_04 <- sqldf('SELECT COUNT(Razon_social) AS Empresas, Provincia 
      FROM archivo
      GROUP BY Provincia')   

query_05 <- sqldf('SELECT COUNT(Razon_social) AS Empresas, Comuna 
      FROM archivo
      GROUP BY Comuna')  


query_06 <- sqldf('SELECT COUNT(Razon_social) AS Empresas, Actividad_economica 
      FROM archivo
      GROUP BY Actividad_economica') 

query_07 <- sqldf('SELECT 
                SUM(Numero_de_trabajadores_dependientes_informados) as CANTIDAD,                              
                Rubro_economico,
                Region
      FROM archivo       
      GROUP BY Rubro_economico
      ORDER BY CANTIDAD')    

query_07_prueba <- sqldf('SELECT 
                SUM(Numero_de_trabajadores_dependientes_informados) as CANTIDAD,                              
                Rubro_economico,
                Region
      FROM archivo   
      WHERE Region = "XIII REGION METROPOLITANA"    
      GROUP BY Rubro_economico
      ORDER BY CANTIDAD')       

graficoquery07 <- ggplot(query_07, aes(x=Region, y=CANTIDAD, fill=Rubro_economico)) +geom_col(position="dodge")
graficoquery07prueba <- ggplot(query_07_prueba, aes(x=Region, y=CANTIDAD, fill=Rubro_economico)) +geom_col(position="dodge")

# myplot <- ggplot(Razon_social, aes(x = Ano_comercial, y = num_cols)) +
#     geom_bar(stat = "identity", fill = "blue") +
#     ggtitle('My title')    

# # # myplot4 <- ggplot(query_07, aes(x=Region, 1, fill = Rubro_economico)) +
# # #     geom_bar(stat = "identity", position = "dodge") +
# # #     coord_flip()+
# # #     ggtitle('CANTIDAD DE TRABAJADORES POR RUBRO ECONOMICO DE CADA REGION')      

# query_08 <- sqldf('SELECT Razon_social, Comuna 
#       FROM archivo
#       WHERE Comuna="CURANILAHUE"')      

query_09 <- sqldf("SELECT Rubro_economico FROM archivo GROUP BY Rubro_economico")

query_10 <- sqldf("SELECT Subtipo_de_contribuyente FROM archivo")

query_11 <- sqldf('SELECT count(Razon_social), Ano_comercial
      FROM archivo
      group by Ano_comercial')  

query_12 <- sqldf('SELECT count(Razon_social) as cantidad, substr(Fecha_inicio_de_actividades_vigente, 7,4) as "anio"
      FROM archivo
      GROUP BY anio') 

    anio_int <- as.numeric(query_12$anio) 

    rango_1 <- sqldf("SELECT SUM(cantidad) as cantidad,  MIN(anio) || '-' || MAX(anio) as rangos_fechas FROM query_12 where anio BETWEEN 1901 AND 1911")    
    rango_2 <- sqldf("SELECT SUM(cantidad) as cantidad,  MIN(anio) || '-' || MAX(anio) as rangos_fechas  FROM query_12 where anio BETWEEN 1912 AND 1922")
    rango_3 <- sqldf("SELECT SUM(cantidad) as cantidad,  MIN(anio) || '-' || MAX(anio) as rangos_fechas  FROM query_12 where anio BETWEEN 1923 AND 1933")
    rango_4 <- sqldf("SELECT SUM(cantidad) as cantidad,  MIN(anio) || '-' || MAX(anio) as rangos_fechas  FROM query_12 where anio BETWEEN 1934 AND 1944")
    rango_5 <- sqldf("SELECT SUM(cantidad) as cantidad,  MIN(anio) || '-' || MAX(anio) as rangos_fechas  FROM query_12 where anio BETWEEN 1945 AND 1955")
    rango_6 <- sqldf("SELECT SUM(cantidad) as cantidad,  MIN(anio) || '-' || MAX(anio) as rangos_fechas  FROM query_12 where anio BETWEEN 1956 AND 1966")
    rango_7 <- sqldf("SELECT SUM(cantidad) as cantidad,  MIN(anio) || '-' || MAX(anio) as rangos_fechas  FROM query_12 where anio BETWEEN 1967 AND 1977")
    rango_8 <- sqldf("SELECT SUM(cantidad) as cantidad,  MIN(anio) || '-' || MAX(anio) as rangos_fechas  FROM query_12 where anio BETWEEN 1978 AND 1988")
    rango_9 <- sqldf("SELECT SUM(cantidad) as cantidad,  MIN(anio) || '-' || MAX(anio) as rangos_fechas  FROM query_12 where anio BETWEEN 1989 AND 1999")
    rango_10 <- sqldf("SELECT SUM(cantidad) as cantidad,  MIN(anio) || '-' || MAX(anio) as rangos_fechas  FROM query_12 where anio BETWEEN 2000 AND 2010")
    rango_11 <- sqldf("SELECT SUM(cantidad) as cantidad,  MIN(anio) || '-' || MAX(anio) as rangos_fechas  FROM query_12 where anio BETWEEN 2011 AND 2021")

    cantidad_rangos <- c(
      rango_1$cantidad,
      rango_2$cantidad,
      rango_3$cantidad,
      rango_4$cantidad,
      rango_5$cantidad,
      rango_6$cantidad,
      rango_7$cantidad,
      rango_8$cantidad,
      rango_9$cantidad,
      rango_10$cantidad,
      rango_11$cantidad
    )
    rangos_anios <- c(
      rango_1$rangos_fechas,
      rango_2$rangos_fechas,
      rango_3$rangos_fechas,
      rango_4$rangos_fechas,
      rango_5$rangos_fechas,
      rango_6$rangos_fechas,
      rango_7$rangos_fechas,
      rango_8$rangos_fechas,
      rango_9$rangos_fechas,
      rango_10$rangos_fechas,
      rango_11$rangos_fechas
    )

    datos <- data.frame(Periodos = rangos_anios , Cantidad = cantidad_rangos)

    inicioActividadesPeriodosTiempo <- ggplot(datos, aes(Periodos, Cantidad)) +
    geom_bar(stat = "identity", fill = "blue") +
    ggtitle('Inicio de actividades por periodos de tiempo')

query_13 <- sqldf('SELECT 
        COUNT(Razon_social) AS Cantidad, Rubro_economico, Region
        FROM archivo
        GROUP BY Rubro_economico, Region
        ORDER BY Region')   
        

query_14 <- sqldf('SELECT 
        COUNT(Razon_social) AS Cantidad, Rubro_economico, Provincia
        FROM archivo
        GROUP BY Rubro_economico, Provincia
        ORDER BY Provincia')  



query_15 <- sqldf('SELECT 
        COUNT(Razon_social) AS Cantidad, Rubro_economico, Comuna
        FROM archivo
        GROUP BY Rubro_economico, Comuna
        ORDER BY Comuna')  

      

query_7_Actividad_Economica <- sqldf('SELECT 
                  Region,
                  Actividad_economica as "Actividad Economica",
                  Count(Actividad_economica) as "Cantidad"
      FROM archivo 
      GROUP BY Actividad_economica
      ORDER BY "Cantidad" DESC')

query_8_Actividad_Economica_provincia <- sqldf('SELECT 
                  Provincia,
                  Actividad_economica as "Actividad Economica",
                  Count(Actividad_economica) as "Cantidad"
      FROM archivo 
      GROUP BY Actividad_economica
      ORDER BY "Cantidad" DESC
      LIMIT 7')


query_9_Actividad_Economica_comuna <- sqldf('SELECT 
                  Comuna,
                  Actividad_economica as "Actividad Economica",
                  Count(Actividad_economica) as "Cantidad"
      FROM archivo 
      GROUP BY Actividad_economica
      ORDER BY "Cantidad" DESC
      LIMIT 7') 

myplot <- ggplot(Razon_social, aes(x = Ano_comercial, y = num_cols)) +
    geom_bar(stat = "identity", fill = "blue") +
    ggtitle('My title')


actividadEconomicaRegion <- ggplot(query_7_Actividad_Economica, aes(x = Region, y = Cantidad)) +
    geom_bar(stat = "identity", fill = "blue") +
    coord_flip()+
    ggtitle('Actividad Economica Inicio Actividades Region')

actividadEconomicaProvincia <- ggplot(query_8_Actividad_Economica_provincia, aes(x = Provincia, y = Cantidad)) +
    geom_bar(stat = "identity", fill = "blue") +
    ggtitle('Actividad Economica Inicio Actividades Provincia')

actividadEconomicaComuna <- ggplot(query_9_Actividad_Economica_comuna, aes(x = Comuna, y = Cantidad)) +
    geom_bar(stat = "identity", fill = "blue") +
    ggtitle('Actividad Economica Inicio Actividades Comuna')

#
rubros_por_region <- ggplot(query_13, aes(x = Region, y = Cantidad)) +
    geom_bar(stat = "identity", fill = "blue") +
    ggtitle('Rubro para inicio actividades por region')

rubros_por_prov <- ggplot(query_14, aes(x = Provincia, y = Cantidad)) +
    geom_bar(stat = "identity", fill = "blue") +
    ggtitle('Rubro para inicio actividades por provincia')

rubros_por_comuna <- ggplot(query_15, aes(x = Comuna, y = Cantidad)) +
    geom_bar(stat = "identity", fill = "blue") +
    ggtitle('Rubro para inicio actividades por comuna')     
###############################
rubros_por_regionaaa <- ggplot(query_13, aes(x = Region, y = Cantidad)) +
    geom_bar(stat = "identity", fill = "blue") +
    coord_flip()+
    ggtitle('Rubro para inicio actividades por region')

rubros_por_provaa <- ggplot(query_14, aes(x = Provincia, y = Cantidad)) +
    geom_bar(stat = "identity", fill = "blue") +
    coord_flip()+
    ggtitle('Rubro para inicio actividades por provincia')

rubros_por_comunaaaa <- ggplot(query_15, aes(x = Comuna, y = Cantidad)) +
    geom_bar(stat = "identity", fill = "blue") +
    coord_flip()+
    ggtitle('Rubro para inicio actividades por comuna') 
  

library(dplyr)
library(ggplot2)
library(sqldf)
library(readr)
# options(scipen=3)
options(scipen=999)

archivo <- readr::read_csv("C:/Users/Hellmuth/Documents/INTRO A R/Proyecto_R/data_csv.csv")

# Razon_social <- sqldf('SELECT Ano_comercial, COUNT(Razon_social) AS num_cols
#       FROM archivo
#       GROUP BY Ano_comercial')

# query_03 <- sqldf('SELECT COUNT(Razon_social) AS Empresas, Region 
#       FROM archivo
#       GROUP BY Region')     

# query_04 <- sqldf('SELECT COUNT(Razon_social) AS Empresas, Provincia 
#       FROM archivo
#       GROUP BY Provincia')   

# query_05 <- sqldf('SELECT COUNT(Razon_social) AS Empresas, Comuna 
#       FROM archivo
#       GROUP BY Comuna')  


# query_06 <- sqldf('SELECT COUNT(Razon_social) AS Empresas, Actividad_economica 
#       FROM archivo
#       GROUP BY Actividad_economica') 
# ----------------------------------------------------------------------------------------------
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

query_07_ULTIMA <- sqldf('SELECT 
                SUM(Numero_de_trabajadores_dependientes_informados) as CANTIDAD,                              
                Actividad_economica      
      FROM archivo      
      GROUP BY Actividad_economica
      ORDER BY CANTIDAD
      LIMIT 10')      

graficoquery07 <- ggplot(query_07, aes(x=Region, y=CANTIDAD, fill=Rubro_economico)) +geom_col(position="dodge")
graficoquery07prueba <- ggplot(query_07_prueba, aes(x=Region, y=CANTIDAD, fill=Rubro_economico)) +geom_col(position="dodge")


# GRAFICOQUERY7ULTIMA2 <- ggplot(data = query_07_ULTIMA, aes(x = Actividad_economica, fill = as.factor(Actividad_economica))) + 
#   geom_bar() + 
#   xlab("Actividad_economica") + 
#   ylab("CANTIDAD") + 
#   ggtitle("Gráfico de Barras") +
#   labs(fill = "Actividad_economica") + 
#   theme_minimal()

# GRAFICOQUERY7ULTIMA22 <- ggplot(query_07_ULTIMA,  aes(x=Actividad_economica, y=CANTIDAD, fill=Actividad_economica)) + 
#   geom_bar(stat="identity", position = "dodge") + ylab("Normalized count")+xlab("Actividad_economica")+
#   scale_fill_brewer(palette = "Set1")
# ggsave('~/saved_image.png', width = 1304, height = 722, dpi = 100)

# GRAFICOQUERY7ULTIMA <- ggplot(query_07_ULTIMA, aes(x = Actividad_economica, y = CANTIDAD)) +
#     geom_bar(stat = "identity", fill = "red") +
#     ggtitle('Número de trabajadores por actividad económica')



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

# cantidad de empresas por region
 query_08_cantidad_empresas <- sqldf('SELECT 
                Region,
                Count(Razon_social) as CANTIDAD                                   
      FROM archivo      
      GROUP BY Region
      ORDER BY CANTIDAD')  

      empresas_por_region <- ggplot(query_08_cantidad_empresas, aes(x = Region, y = CANTIDAD)) +
    geom_bar(stat = "identity", fill = "red") +
    coord_flip()+
    ggtitle('Cantidad de empresas por región')   




# query_11 <- sqldf('SELECT count(Razon_social), Ano_comercial
#       FROM archivo
#       group by Ano_comercial')  


####INICIO DE ACTIVIDADDES POR PERIODOS DE TIEMPO
query_12 <- sqldf('SELECT count(Actividad_economica) as cantidad, substr(Fecha_inicio_de_actividades_vigente, 7,4) as "anio"
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

# ----------------------------------------------------------------------------------------------
####INDICES DE INICIO DE ACTIVIDADES POR 
##TIPO RUBRO ECONOMIOC Y 
##POR REGION 
query_13 <- sqldf('SELECT 
        COUNT(Rubro_economico) AS Cantidad, Rubro_economico, Region
        FROM archivo
        GROUP BY Rubro_economico, Region
        ORDER BY Region')   

rubros_por_regionaaa <- ggplot(query_13, aes(x = Region, y = Cantidad)) +
    geom_bar(stat = "identity", fill = "#00ffd9") +
    coord_flip()+
    ggtitle('Índice de Rubro economico por región')

query_13_ver2 <- sqldf('SELECT 
        COUNT(Rubro_economico) AS Cantidad, Rubro_economico, Region
        FROM archivo
        GROUP BY Rubro_economico
        ORDER BY Cantidad Desc
        LIMIT 10')   

cantidad_rubro <- ggplot(query_13_ver2, aes(x = Rubro_economico, y = Cantidad)) +
    geom_bar(stat = "identity", fill = "yellow") +
    coord_flip()+
    ggtitle('Índice de Rubro economico')

####INDICES DE INICIO DE ACTIVIDADES POR 
##TIPO RUBRO ECONOMIOC Y 
##POR PROVINCIA 
query_14 <- sqldf('SELECT 
        COUNT(Rubro_economico) AS Cantidad, Rubro_economico, Provincia
        FROM archivo
        GROUP BY Rubro_economico, Provincia
        ORDER BY Provincia')  

rubros_por_provaa <- ggplot(query_14, aes(x = Provincia, y = Cantidad)) +
    geom_bar(stat = "identity", fill = "#00ffd9") +
    coord_flip()+
    ggtitle('Rubro para inicio actividades por provincia')


####INDICES DE INICIO DE ACTIVIDADES POR 
##TIPO RUBRO ECONOMIOC Y 
##POR Comuna 
query_15 <- sqldf('SELECT 
        COUNT(Rubro_economico) AS Cantidad, Rubro_economico, Comuna
        FROM archivo
        GROUP BY Rubro_economico, Comuna
        ORDER BY Cantidad desc limit 10' )  

rubros_por_comunaaaa <- ggplot(query_15, aes(x = Comuna, y = Cantidad)) +
    geom_bar(stat = "identity", fill = "#00ffd9") +
    coord_flip()+
    ggtitle('Rubro para inicio actividades por comuna') 

# ----------------------------------------------------------------------------------------------   

####INDICES DE INICIO DE ACTIVIDADES POR 
##ACTIVIDAD ECONOMICA Y 
##POR Region 
query_7_Actividad_Economica <- sqldf('SELECT 
                  Region,
                  Actividad_economica as "Actividad Economica",
                  Count(Actividad_economica) as "Cantidad"
      FROM archivo 
      GROUP BY Actividad_economica
      ORDER BY "Cantidad" DESC')

actividadEconomicaRegion <- ggplot(query_7_Actividad_Economica, aes(x = Region, y = Cantidad)) +
    geom_bar(stat = "identity", fill = "green") +
    coord_flip()+
    ggtitle('Índices de Actividad Economica por Región')

####INDICES DE INICIO DE ACTIVIDADES POR 
##ACTIVIDAD ECONOMICA Y 
##POR Provincia 
query_8_Actividad_Economica_provincia <- sqldf('SELECT 
                  Provincia,
                  Actividad_economica as "Actividad Economica",
                  Count(Actividad_economica) as "Cantidad"
      FROM archivo 
      GROUP BY Actividad_economica
      ORDER BY "Cantidad" DESC 
      LIMIT 10')
actividadEconomicaProvincia <- ggplot(query_8_Actividad_Economica_provincia, aes(x = Provincia, y = Cantidad)) +
    geom_bar(stat = "identity", fill = "green") +
    ggtitle('Índices de Actividad Economica por Provincia')


####INDICES DE INICIO DE ACTIVIDADES POR 
##ACTIVIDAD ECONOMICA Y 
##POR Comuna 
query_9_Actividad_Economica_comuna <- sqldf('SELECT 
                  Comuna,
                  Actividad_economica as "Actividad Economica",
                  Count(Actividad_economica) as "Cantidad"
      FROM archivo 
      GROUP BY Actividad_economica
      ORDER BY "Cantidad" DESC
      LIMIT 10') 


actividadEconomicaComuna <- ggplot(query_9_Actividad_Economica_comuna, aes(x = Comuna, y = Cantidad)) +
    geom_bar(stat = "identity", fill = "green") +
     coord_flip()+
    ggtitle('Índices de Actividad Economica por Comuna')

# ----------------------------------------------------------------------------------------------   

# actividadEconomicaRegion <- ggplot(query_7_Actividad_Economica, aes(x = Region, y = Cantidad)) +
#     geom_bar(stat = "identity", fill = "blue") +
#     coord_flip()+
#     ggtitle('Índices de Actividad Economica por Región')

# actividadEconomicaProvincia <- ggplot(query_8_Actividad_Economica_provincia, aes(x = Provincia, y = Cantidad)) +
#     geom_bar(stat = "identity", fill = "blue") +
#     ggtitle('Índices de Actividad Economica por Provincia')

# actividadEconomicaComuna <- ggplot(query_9_Actividad_Economica_comuna, aes(x = Comuna, y = Cantidad)) +
#     geom_bar(stat = "identity", fill = "blue") +
#     ggtitle('Índices de Actividad Economica por Comuna')

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
# rubros_por_regionaaa <- ggplot(query_13, aes(x = Region, y = Cantidad)) +
#     geom_bar(stat = "identity", fill = "blue") +
#     coord_flip()+
#     ggtitle('Rubro para inicio actividades por region')

# rubros_por_provaa <- ggplot(query_14, aes(x = Provincia, y = Cantidad)) +
#     geom_bar(stat = "identity", fill = "blue") +
#     coord_flip()+
#     ggtitle('Rubro para inicio actividades por provincia')

# rubros_por_comunaaaa <- ggplot(query_15, aes(x = Comuna, y = Cantidad)) +
#     geom_bar(stat = "identity", fill = "blue") +
#     coord_flip()+
#     ggtitle('Rubro para inicio actividades por comuna') 
  

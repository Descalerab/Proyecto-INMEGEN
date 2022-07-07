#Librerias a ocupar
library(shiny)
library(shinydashboard)
library(readr)
library(tidyr)
library(DT)

#Este apartado es dedicado a recolectar los documentos con los que vamos a trabajar
#Como son las tablas, los archivos PFD y los textos
Cambio <- read_csv("Divisas_pandemia.csv")# Esta es la tabla dirigida al apartado de usuarios
#Aqui ocupamos la ruta del archivo .txt, para posteriormente entregar los parametros al objeto Bienvenida
ruta<-"/home/descalera/Documentos/App-1/PryctIsra2/Brenda.txt"
Bienvenida_txt <- read.table(ruta, header=T, sep = "\t")
#De igual manera, para los problemas
ruta1<-"/home/descalera/Documentos/App-1/PryctIsra2/Problemas.txt"
Problemas_txt <- read.table(ruta1, header=T, sep = "\t")
#El material para la tabla de nodos
Nodal <- read_csv("RiesgosPI2.csv")

#
#Inicio de la programación
#Creamos una pagina
ui<-dashboardPage(title= "Ejemplo", skin= "blue",
                  dashboardHeader(title="PROYECTO",
                                  dropdownMenu(type = "messages",
                                               messageItem(from = "Diego",
                                                           "Bienvenido"))
                  ),
                  #Creamos el menú a un costado
                  dashboardSidebar(
                    sidebarSearchForm("searchText","buttonSearch","Buscar"),
                    sidebarMenu(id="sidebarID",
                                #Listado de elementos dentro del menu
                                menuItem("Inicio", tabName = "Inicio", icon = icon("house")), # Texto
                                menuItem("Usuarios", tabName = "datos", icon = icon("user")),# Tabla
                                menuItem("Nodos", tabName = "Nodos", icon = icon("bars")), # Tabla
                                menuItem("Reglamento", tabName = "Regla",  icon = icon("book")),# Texto
                                menuItem("Problemas", tabName = "Problemas", icon = icon("hammer")), # Tabla
                                menuItem("Contacto", tabName="Contacto", icon = icon("address-book")), # Imagen
                                menuItem("Agradecimientos", tabName = "imag", icon = icon("heart")) # Texto
                    )
                  ),
                  #Contenido de los elemtos dentro del menu
                  dashboardBody(
                    
                    tabItems(
                      
                      tabItem(tabName = "Inicio",
                              DT::dataTableOutput("Inicio")),
                      
                      tabItem(tabName = "datos", 
                              DT::dataTableOutput("datos")
                      ),
                      
                      tabItem(tabName = "Problemas",
                              DT::dataTableOutput("Problemas")),
                      
                      tabItem("Regla",
                              tags$iframe(style="height:400px; width:100%; scrolling=yes",
                                          src="Copy.pdf"
                              )
                      ),
                      
                      tabItem(tabName = "Nodos",
                                      DT::dataTableOutput("Nodos")
                      ),
                      
                      tabItem(tabName = "Contacto",
                              fluidRow(
                                box(title = "Contacto", tags$image(
                                type="image/jpg",src="Contactos.jpg",
                                contols="controls"), width = 4, status = "primary", solidHeader = T),
                                box(title = "Información de Contacto", 
                                    h1(strong("ISRAEL AGUILAR ORDOÑEZ")),
                                    h3("Telefono: 5544647428"),
                                    h3("Correo: descalerab@gmail.com")))
                              ),
                      
                      tabItem(tabName="imag",
                              fluidRow(
                                box(title="Agradecimientos", tags$image(type = "image/jpg",src = "Agradecimientos.jpg",
                                                                      controls = "controls", height="400px", width="600px"), 
                                  width=4, status="primary", solidHeader=T),
                                box(title = "Agradecimientos",
                                    p("El",strong(h3("IINSTITUTO NACIONAL DE MEDICINA GENOMICA (INMEGEN)"))))
                              ))
                    )
                  ))
server <- function(input, output) { 
  output$Inicio <- DT::renderDataTable(Bienvenida_txt)
  output$datos <- DT::renderDataTable(Cambio)
  output$Nodos <- DT::renderDataTable(Nodal)
  output$Problemas <- DT::renderDataTable(Problemas_txt)
  output$imag <- renderImage({
    return(list(src = "Agradecimientos.jpg", contentType = "image/jpg"))
  })
  output$Contacto <- renderImage({
    return(list(src = "Contactos.jpg", contentType="image/jpg"))
  })
  
}


shinyApp(ui, server)
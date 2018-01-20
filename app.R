##############################################
## to-do                                  ####
##############################################
# 



##############################################
## debugging                              ####
##############################################

## printf ##
# x    <- faithful[, 2] 
# bins <- seq(min(x), max(x), length.out = input$bins + 1)
# cat(file=stderr(), "drawing histogram with", input$bins, "bins", "\n")

## reactlog ##
# options(shiny.reactlog=TRUE) #copy into console then run app, then press Ctrl+F3 in the running app




library(shiny)
library(tidyverse)
# library(lubridate)
library(shinythemes)


Sys.setenv(TZ='Europe/Berlin')




##################################################################################
##################################################################################
## UI                                                                         ####
##################################################################################
##################################################################################


ui <- 
  
  navbarPage(
    theme = shinytheme("flatly"),
    "EA Movement Growth",
    
    ## Input-Tab ##
    tabPanel("input",
             fluidRow(
               
               column(4, offset=4,
                      wellPanel(##
                      )
               )
               
             )
    )
  )

##################################################################################
##################################################################################
## server                                                                     ####
##################################################################################
##################################################################################

server <- 
  
  function(input, output) {
    #
  }


shinyApp(ui = ui, server = server)
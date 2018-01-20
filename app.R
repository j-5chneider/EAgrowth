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
library(DT)
library(shinythemes)


Sys.setenv(TZ='Europe/Berlin')

anchors <- c("I strongly<br />disagree", "&nbsp;", "&nbsp;", "&nbsp;", "&nbsp;", "I strongly<br />agree")

awareness <- c("awareness item 1",
               "awareness item 2",
               "awareness item 3",
               "awareness item 4",
               "awareness item 5")

inclination <- c("inclination item 1",
                 "inclination item 2",
                 "inclination item 3",
                 "inclination item 4",
                 "inclination item 5")



##################################################################################
##################################################################################
## UI                                                                         ####
##################################################################################
##################################################################################


ui <- 
  
  navbarPage(
    theme = shinytheme("sandstone"),
    "EA Movement Growth",
    
    ## Input-Tab ##
    tabPanel("input",
             fluidRow(
               
               column(8, offset=2,
                      DT::dataTableOutput("likert_matrix_aware"),
                      DT::dataTableOutput("likert_matrix_inclin")
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
    ## Render Likert-Matrix awareness
      # setting up matrix
      m_aw <- matrix(
        anchors, nrow = 5, ncol = 6, byrow = TRUE,
        dimnames = list(awareness, anchors)
      )
      
      # 
      for (i in seq_len(nrow(m_aw))) {
        m_aw[i, ] = sprintf(
          '<input type="radio" name="%s" value="%s"/>',
          awareness[i], m_aw[i, ]
        )
      }
      
      #
      output$likert_matrix_aware = DT::renderDataTable(
        m_aw, escape = FALSE, selection = 'none', server = FALSE,
        options = list(dom = 't', paging = FALSE, ordering = FALSE, 
                       autoWidth = TRUE,
                       columnDefs = list(list(className = 'dt-center', width = '75px', targets = c(1:6)))),
        callback = JS("table.rows().every(function(i, tab, row) {
                  var $this = $(this.node());
                  $this.attr('id', this.data()[0]);
                  $this.addClass('shiny-input-radiogroup');
                  });
                  Shiny.unbindAll(table.table().node());
                  Shiny.bindAll(table.table().node());")
      )
      
    ## Render Likert-Matrix awareness
      # setting up matrix
      m_aw <- matrix(
        anchors, nrow = 5, ncol = 6, byrow = TRUE,
        dimnames = list(awareness, anchors)
      )
      
      # 
      for (i in seq_len(nrow(m_aw))) {
        m_aw[i, ] = sprintf(
          '<input type="radio" name="%s" value="%s"/>',
          awareness[i], m_aw[i, ]
        )
      }
      
      #
      output$likert_matrix_aware = DT::renderDataTable(
        m_aw, escape = FALSE, selection = 'none', server = FALSE,
        options = list(dom = 't', paging = FALSE, ordering = FALSE, 
                       autoWidth = TRUE,
                       columnDefs = list(list(className = 'dt-center', width = '75px', targets = c(1:6)))),
        callback = JS("table.rows().every(function(i, tab, row) {
                      var $this = $(this.node());
                      $this.attr('id', this.data()[0]);
                      $this.addClass('shiny-input-radiogroup');
                      });
                      Shiny.unbindAll(table.table().node());
                      Shiny.bindAll(table.table().node());")
      )
      
    ## Render Likert-Matrix inclination
      # setting up matrix
      m_in <- matrix(
        anchors, nrow = 5, ncol = 6, byrow = TRUE,
        dimnames = list(inclination, anchors)
      )
      
      # 
      for (i in seq_len(nrow(m_in))) {
        m_in[i, ] = sprintf(
          '<input type="radio" name="%s" value="%s"/>',
          inclination[i], m_in[i, ]
        )
      }
      
      #
      output$likert_matrix_inclin = DT::renderDataTable(
        m_in, escape = FALSE, selection = 'none', server = FALSE,
        options = list(dom = 't', paging = FALSE, ordering = FALSE, 
                       autoWidth = TRUE,
                       columnDefs = list(list(className = 'dt-center', width = '75px', targets = c(1:6)))),
        callback = JS("table.rows().every(function(i, tab, row) {
                      var $this = $(this.node());
                      $this.attr('id', this.data()[0]);
                      $this.addClass('shiny-input-radiogroup');
                      });
                      Shiny.unbindAll(table.table().node());
                      Shiny.bindAll(table.table().node());")
      )
  }


shinyApp(ui = ui, server = server)
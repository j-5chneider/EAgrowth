##############################################
## to-do                                  ####
##############################################
# Anschreiben, ob bereits instrument entwickelt: https://futureoflife.org/ai-researcher-owen-cotton-barratt/
# inclination skala von -3 bis +3


##############################################
## if github push doesn not work          ####
##############################################
#



##############################################
## debugging example                      ####
##############################################

## printf ##
# x    <- faithful[, 2] 
# bins <- seq(min(x), max(x), length.out = input$bins + 1)
# cat(file=stderr(), "drawing histogram with", input$bins, "bins", "\n")

## reactlog ##
# options(shiny.reactlog=TRUE) #copy into console then run app, then press Ctrl+F3 in the running app




library(shiny)
library(dplyr)
library(plotly)
library(DT)
library(shinythemes)


Sys.setenv(TZ='Europe/Berlin')


## setting up the likert scales
# anchors (6-point-Likert-scale)
anchors <- c("I strongly<br />disagree", "&nbsp;", "&nbsp;", "&nbsp;", "&nbsp;", "I strongly<br />agree")

# items for awareness
awareness <- c("awareness item 1",
               "awareness item 2",
               "awareness item 3",
               "awareness item 4",
               "awareness item 5")

# items for inclination
inclination <- c("inclination item 1",
                 "inclination item 2",
                 "inclination item 3",
                 "inclination item 4",
                 "inclination item 5")



##############################
## plotly                 ####
##############################

## simulate example data
exampledata <- data.frame(
  name = c("Hellen", "Sophie", "Lil Wayne", "Herb", "Sam"),
  incli = c(0.00, -0.70, 0.60, 0.20, -1.30, 0.40, -0.60, 0.77, 0.20, -1.05, 0.80, -0.55,  0.94,  0.50, -0.95,  0.80, -0.50,  1.11,  0.70,  0.20,  0.90,  0.20, 1.28, -1.00, 0.40, 1.00, 0.40, 1.45, -1.30, 0.70, 1.20, 0.40, 1.62, -1.50,  0.90,  1.80,  0.60,  1.79, -1.20,  1.00,  1.90,  0.70,  1.96, -1.50, 1.10, 2.00, 0.70, 2.13, -1.70, 1.15, 2.00, 0.80, 2.30, -1.80, 1.20),
  aware = c(1.1, 2, 2.9, 1.25, 1.75, 1.57, 2.2, 3.16, 1.66, 1.9, 2.04, 2.3, 3.42, 2.37, 2.75, 2.51, 2.6, 3.68, 2.98, 3.1, 2.98, 2.8, 3.94, 3.2, 3.2, 3.45, 3, 4.2, 3.3, 3.25, 3.92, 3.2, 4.46, 3.5, 3.55, 4.39, 3.4, 4.72, 4.12, 3.85, 4.86, 3.4, 4.98, 4.53, 4.15, 5.33, 3.5, 5.24, 4.94, 4.45, 5.8, 3.5, 5.5, 5.35, 4.75),
    year = c(2008, 2008, 2008, 2008, 2008, 2009, 2009, 2009, 2009, 2009, 2010, 2010, 2010, 2010, 2010, 2011, 2011, 2011, 2011, 2011, 2012, 2012, 2012, 2012, 2012, 2013, 2013, 2013, 2013, 2013, 2014, 2014, 2014, 2014, 2014, 2015, 2015, 2015, 2015, 2015, 2016, 2016, 2016, 2016, 2016, 2017, 2017, 2017, 2017, 2017, 2018, 2018, 2018, 2018, 2018)
)







## set axis
xaxis_template <- list(
  showgrid = F ,
  zeroline = F ,
  range = list(1,6),
  nticks = 6 ,
  showline = F ,
  title = "awareness" ,
  mirror = "all")

yaxis_template <- list(
  showgrid = F ,
  zeroline = F ,
  range = list(-2.5,2.5),
  nticks = 6 ,
  showline = F ,
  title = "inclination" ,
  mirror = "all")



##################################################################################
##################################################################################
## UI                                                                         ####
##################################################################################
##################################################################################


ui <- 
  
  navbarPage(
    title = "EA Movement Growth",
    id ="eaGrowth",
    theme = shinytheme("sandstone"),
    
    ## Input-Tab ##
    tabPanel(title = "input",
             value = "inputTab",
             fluidRow(
               column(8, offset=2,
                      h1("Behold peasants"),
                      p("this is the all new instrument to assess awareness and inclination in movements. I assume awareness will (in this case) best be measured using \"criteria\" rather than self-perceived estimation. Self-perceived ratings for inclination on the other hand may produce highly valid measurements.")
               )
             ),
             fluidRow(
               column(8, offset=2,
                      DT::dataTableOutput("likert_matrix_aware"),
                      br(),
                      br(),
                      br(),
                      br(),
                      DT::dataTableOutput("likert_matrix_inclin")
               )
             ),
             br(),
             br(),
             br(),
             fluidRow(
               column(2, offset=3,
                      selectInput("addToGroup", "save data for group:",
                        c("please select" = "",
                          "EA Tübingen" = "eaTueb",
                          "EA Stuttgart" = "eaStu",
                          "EA Berlin" = "eaBer",
                          "EA London" = "eaLon",
                          "create new group" = "new")
                      ),
                      conditionalPanel(condition = "input.addToGroup == 'new'",
                                       textInput("newGroup",
                                         "name your new group"
                                       )
                      )
               ),
               column(2,
                      textInput("nameSave",
                                "your name (optional)"
                      )
               ),
               br(),
               column(2,
                      actionButton("goButton", label = div(icon("save", lib = "font-awesome")), icon = icon("line-chart", lib = "font-awesome"))
               )
             )
    ),
    tabPanel(title = "output",
             value = "outputTab",
             fluidRow(
               column(2, offset = 2,
                      sliderInput("year2", "Jahr", 2008, 2018, value = 2008, step = 1, animate=animationOptions(interval=1500, loop=T, playButton="► automatisch abspielen"), ticks=T, sep="")
               ),
               column(4,
                      plotlyOutput("plot1")
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
      
      
      ## Render plotly output
      output$plot1 <- renderPlotly({
        
        exampledata <- exampledata%>%
          filter(year == input$year2)
        
        plot_ly(exampledata, 
                x = ~aware, y = ~incli, 
                # text = ~name, 
                type = 'scatter', 
                mode = 'markers',
                marker = list(size = 16, opacity = 0.7),
                color = ~name) %>%
          layout(title = 'Your awareness and inclination scores over time',
                 xaxis = xaxis_template,
                 yaxis = yaxis_template,
                 plot_bgcolor = "#f2f6f7",
                 paper_bgcolor = "#fff"#,
                 # autosize = F, 
                 # width = "55%", 
                 # height = "50%"
                 )
        
      })
      

    observeEvent(input$goButton, {
      updateNavbarPage(session, inputId = "eaGrowth", selected = "outputTab")
    })
  }


shinyApp(ui = ui, server = server)
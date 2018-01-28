########################
# uCount Visualizer    #
# by Alessio Benedetti #
# ui.R file            #
########################

#load libraries
library(shiny)
library(shinyjs)
library(markdown)

shinyUI(fluidPage(theme = "darkly.css",
 
 #load google analytics
 tags$head(includeScript("www/google-analytics-uCountVis.js")),
 
 useShinyjs(),
 
 fluidRow(
                    
  column(12,
   navbarPage(
          
    strong("uCount Visualizer"),
    footer = includeMarkdown("www/footer.md"),
    windowTitle = "uCount Visualizer",
    tabPanel("Home", includeMarkdown("www/home.md")),
          
    tabPanel("Data",
     wellPanel(
      fluidRow(
       #[begin fix 1.5]
       column(1, offset=1, selectInput("idYearD", "", selected=NULL, multiple=FALSE, choice=c('Year' = '', seq(2016,as.numeric(format(Sys.Date(),"%Y")),1)))),
       #[end fix 1.5]
       column(2, selectInput("idMonthD", "", selected=NULL, multiple=FALSE, choice=c('Month' = '', c("January","February","March","April","May","June","July","August","September","October","November","December")))),
       column(1, selectInput("idWeekD", "", selected=NULL, multiple=FALSE, choice=c('Week' = '', seq(1,52)))),
       column(3, dateRangeInput('idRangeD', label = "", start = "2016-03-12", end = Sys.Date(), separator = " - ", format = "yyyy-mm-dd", weekstart = 1)),
       tags$head(tags$style(HTML('#idResD{background-color:red; margin-top: 16px;}'))),
       column(1, offset=1, align="center", actionButton("idResD", "Reset filters")),
       tags$head(tags$style(HTML('#idDwn{background-color:blue; margin-top: 16px;}'))),
       column(1, align="center", downloadButton('idDwn', "Download"))
      )
      
     ),
     
     hr(),
     
     fluidRow(
      tags$head(tags$style(HTML('#idVarN{text-align: center;}'))),
      column(1, id="idVarN", offset = 4, strong("Variation:")),
      tags$head(tags$style(HTML('#sumVarN{text-align: center;}'))),
      column(1, textOutput("sumVarN")),
      tags$head(tags$style(HTML('#idVarP{text-align: center;}'))),
      column(1, id="idVarP", strong("Variation %:")),
      tags$head(tags$style(HTML('#sumVarP{text-align: center;}'))),
      column(1, textOutput("sumVarP"))
     ),
           
     hr(),
     
     fluidRow(
      column(12, dataTableOutput('dataTable'))
     )
     
    ),                                              
    
    tabPanel("Charts",
             
     tabsetPanel(
      
      tabPanel("Visualizer charts",
       tabsetPanel(
        
        tabPanel(em("Charts 1 & 2"),
         
         #Chart 1 (Visualizer 1)
         br(),
         h4("Chart 1: Mean variation and max/min delta per day"),
         fluidRow(
          #[begin fix 1.5]
          column(1, selectInput("idYearC1", "", selected=NULL, multiple=FALSE, choice=c('Year' = '', seq(2016,as.numeric(format(Sys.Date(),"%Y")),1)))),
          #[end fix 1.5]
          column(2, selectInput("idMonthC1", "", selected=NULL, multiple=FALSE, choice=c('Month' = '', c("January","February","March","April","May","June","July","August","September","October","November","December")))),
          column(1, selectInput("idWeekC1", "", selected=NULL, multiple=FALSE, choice=c('Week' = '', seq(1,52)))),
          column(2, offset = 1, dateRangeInput('idRangeC1', label = "", start = "2016-03-12", end = Sys.Date(), separator = " - ", format = "yyyy-mm-dd", weekstart = 1)),
          tags$head(tags$style(HTML('#idResC1{background-color:red; margin-top: 16px;}'))),
          column(1, offset = 1, align="center", actionButton("idResC1", "Reset Chart 1")),
          br()
         ),
         fluidRow(
          column(11, htmlOutput("chart1"))
         ),
         
         #Chart 2 (Visualizer 2)
         br(),
         h4("Chart 2: Mean per day"),
         fluidRow(
          #[begin fix 1.5]
          column(1, selectInput("idYearC2", "", selected=NULL, multiple=FALSE, choice=c('Year' = '', seq(2016,as.numeric(format(Sys.Date(),"%Y")),1)))),
          #[end fix 1.5]
          column(2, selectInput("idMonthC2", "", selected=NULL, multiple=FALSE, choice=c('Month' = '', c("January","February","March","April","May","June","July","August","September","October","November","December")))),
          column(1, selectInput("idWeekC2", "", selected=NULL, multiple=FALSE, choice=c('Week' = '', seq(1,52)))),
          column(2, offset = 1, dateRangeInput('idRangeC2', label = "", start = "2016-03-12", end = Sys.Date(), separator = " - ", format = "yyyy-mm-dd", weekstart = 1)),
          tags$head(tags$style(HTML('#idResC2{background-color:red; margin-top: 16px;}'))),
          column(1, offset = 1, align="center", actionButton("idResC2", "Reset Chart 2")),
          br()
         ),
         fluidRow(
          column(11, htmlOutput("chart2"))
         )
        )
       
       )
      ),
        
      tabPanel("Katung's charts",
       tabsetPanel(
        
        tabPanel(em("Chart 3"),
        
         #Chart 3 (Katung 1)
         fluidRow(
          br(),
           #[begin fix 1.2]
           column(5, h4("Chart 3: Mean per weekday grouped by week starting on the 13th of march 2016"))
           #[end fix 1.2]
         ),
         fluidRow(
          tags$head(tags$style(HTML('#idWeekdayC3{text-align: center;}'))),
          #[begin fix 1.8]
          column(4, checkboxGroupInput(inputId="idWeekdayC3", label="", selected=c("Sun.","Mon.","Tue.","Wed.","Thu.","Fri.","Sat."), inline = TRUE, choices=c("Sun.","Mon.","Tue.","Wed.","Thu.","Fri.","Sat."))),
          #[end fix 1.8]
          tags$head(tags$style(HTML('#idResC3{background-color:red; margin-top: 6px;}'))),
          column(1, align="center", actionButton("idResC3", "Reset Chart 3")),
          br()
         ),
         fluidRow(
          column(6, htmlOutput("chart3"))
         )
        ),
        
        tabPanel(em("Chart 4"),
        
         #Chart 4 (Katung 2)
         fluidRow(
          br(),
           #[begin fix 1.2]
           column(5, h4("Chart 4: Mean variation per weekday grouped by week starting on the 13th of march 2016"))
           #[end fix 1.2]
         ),
         fluidRow(
          tags$head(tags$style(HTML('#idWeekdayC4{text-align: center;}'))),
          #[begin fix 1.8]
          column(4, checkboxGroupInput(inputId="idWeekdayC4", label="", selected=c("Sun.","Mon.","Tue.","Wed.","Thu.","Fri.","Sat."), inline = TRUE, choices=c("Sun.","Mon.","Tue.","Wed.","Thu.","Fri.","Sat."))),
          #[end fix 1.8]
          tags$head(tags$style(HTML('#idResC4{background-color:red; margin-top: 6px;}'))),
          column(1, align="center", actionButton("idResC4", "Reset Chart 4")),
          br()
         ),
         fluidRow(
          column(6, htmlOutput("chart4"))
         )
        )
        
       )
      ),
     
      tabPanel("uCount's charts",
       tabsetPanel(
        
        tabPanel(em("Chart 5"),
        
         #Chart 5 (uCount 1)
         fluidRow(
          br(),
          column(5, h4("Chart 5: Monthly mean variation"))
         ),
         fluidRow(
          #[begin fix 1.5]
          column(1, selectInput("idYearC5", "", selected=NULL, multiple=FALSE, choice=c('Year' = '', seq(2016,as.numeric(format(Sys.Date(),"%Y")),1)))),
          #[end fix 1.5]
          column(2, selectInput("idMonthC5", "", selected=NULL, multiple=FALSE, choice=c('Month' = '', c("January","February","March","April","May","June","July","August","September","October","November","December")))),
          tags$head(tags$style(HTML('#idResC5{background-color:red; margin-top: 15px;}'))),
          column(1, offset=1, align="center", actionButton("idResC5", "Reset Chart 5")),
          br()
         ),
         fluidRow(
          column(6, htmlOutput("chart5"))
         )         
                 
        ),
        
        tabPanel(em("Chart 6"),
        
         #Chart 6 (uCount 2)
         fluidRow(
          br(),
          column(5, h4("Chart 6: Yearly mean variation"))
         ),
         fluidRow(
          #[begin fix 1.5]
          column(1, selectInput("idYearC6", "", selected=NULL, multiple=FALSE, choice=c('Year' = '', seq(2016,as.numeric(format(Sys.Date(),"%Y")),1)))),
          #[end fix 1.5]
          tags$head(tags$style(HTML('#idResC6{background-color:red; margin-top: 15px;}'))),
          column(1, offset=1, align="center", actionButton("idResC6", "Reset Chart 6")),
          br()
         ),
         fluidRow(
          column(6, htmlOutput("chart6"))
         )
        )
        
       )
      )
      
     )
     
    ),
    
    tabPanel("?", includeMarkdown("www/help.md"))
    
   )
   
  ) 
 ) 
))
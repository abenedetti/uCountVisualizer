########################
# uCount Visualizer    #
# by Alessio Benedetti #
# server.R file        #
########################

#load libraries
library(shiny)
library(gsheet)
library(googleVis)
library(rCharts)
library(reshape2)

#set locale for filters
Sys.setlocale("LC_TIME", "C")

#load fresh uCount raw data
url <- "https://docs.google.com/spreadsheets/d/1zlB1XxdITwGejHKXyL_yd8XCxkoCVh5RatQeaH2CJ4Q/edit#gid=0"
dataRaw <- gsheet2tbl(url)

#clean raw data
#skip first 4 rows
dataRaw <- tail(dataRaw,-4)
#substitute comma with decimal point in the colum number nine
dataRaw$X.9 <- gsub(',', '.', dataRaw$X.9)
#format date field
dataClean <- as.Date(dataRaw$X,"%d/%m/%Y %H:%M:%S")
#set the appropriate data types
dataClean <- as.data.frame(dataClean)
#data bind 
dataClean <- cbind (
  dataClean,
  as.numeric(format(dataClean$dataClean,"%W")),
  as.numeric(dataRaw$X.1),
  as.numeric(dataRaw$X.2),
  as.numeric(dataRaw$X.3),
  as.numeric(dataRaw$X.4),
  as.numeric(dataRaw$X.5),
  as.numeric(dataRaw$X.6),
  as.numeric(dataRaw$X.7),
  as.numeric(dataRaw$X.8),
  as.numeric(dataRaw$X.9),
  as.numeric(dataRaw$X.10)
)

#rename data columns
colnames(dataClean)[1] <- "Date"
colnames(dataClean)[2] <- "Week"
colnames(dataClean)[3] <- "University"
colnames(dataClean)[4] <- "Projects"
colnames(dataClean)[5] <- "Events"
colnames(dataClean)[6] <- "Tools"
colnames(dataClean)[7] <- "Community"
colnames(dataClean)[8] <- "Platform"
colnames(dataClean)[9] <- "Mean"
colnames(dataClean)[10] <- "Variation"
colnames(dataClean)[11] <- "Variation %"
colnames(dataClean)[12] <- "Max/Min delta"

#add year 2014 [for testing purposes]
# data20 <- dataClean[dataClean$Week == 20,]
# data20 <- cbind(data20,c("2014-05-16","2014-05-17","2014-05-18","2014-05-19","2014-05-20","2014-05-21","2014-05-22"))
# colnames(data20)[13] <- "Date"
# data20 <- data20[,-c(1)]
# data20 <- cbind(data20$Date,data20[,-c(12)])
# colnames(data20)[1] <- "Date"
# data20$Date <- as.Date(data20$Date)
# dataNO20 <- dataClean[dataClean$Week != 20,]
# dataClean <- rbind(data20,dataNO20)

#format numbers [to fix]
#dataClean$University <-prettyNum(dataClean$University, decimal.mark = ",", big.mark = ".")
#dataClean$Projects <-prettyNum(dataClean$Projects, decimal.mark = ",", big.mark = ".")
#dataClean$Events <-prettyNum(dataClean$Events, decimal.mark = ",", big.mark = ".")
#dataClean$Tools <-prettyNum(dataClean$Tools, decimal.mark = ",", big.mark = ".")
#dataClean$Community <-prettyNum(dataClean$Community, decimal.mark = ",", big.mark = ".")
#dataClean$Platform <-prettyNum(dataClean$Platform, decimal.mark = ",", big.mark = ".")
#dataClean$Mean <-prettyNum(dataClean$Mean, decimal.mark = ",", big.mark = ".") --> to be fixed

#define server logic
shinyServer(function(input, output) {
  
   #filters
   datasetInputFilters <- reactive(
    if (input$idYearD != '' & input$idMonthD == '' & input$idWeekD == '') {dataClean[format(dataClean$Date,"%Y") == input$idYearD & dataClean$Date >= input$idRangeD[1] & dataClean$Date <= input$idRangeD[2],]}
    else if (input$idYearD != '' & input$idMonthD != '' & input$idWeekD == '') {dataClean[format(dataClean$Date,"%Y") == input$idYearD & format(dataClean$Date,"%B") == input$idMonthDD & dataClean$Date >= input$idRangeD[1] & dataClean$Date <= input$idRangeD[2],]}
    else if (input$idYearD != '' & input$idMonthD == '' & input$idWeekD != '') {dataClean[format(dataClean$Date,"%Y") == input$idYearD & dataClean$Week == input$idWeekD & dataClean$Date >= input$idRangeD[1] & dataClean$Date <= input$idRangeD[2],]}
    else if (input$idYearD != '' & input$idMonthD != '' & input$idWeekD != '') {dataClean[format(dataClean$Date,"%Y") == input$idYearD & format(dataClean$Date,"%B") == input$idMonthD & dataClean$Week == input$idWeekD & dataClean$Date >= input$idRangeD[1] & dataClean$Date <= input$idRangeD[2],]}
    else if (input$idYearD == '' & input$idMonthD != '' & input$idWeekD == '') {dataClean[format(dataClean$Date,"%B") == input$idMonthD & dataClean$Date >= input$idRangeD[1] & dataClean$Date <= input$idRangeD[2],]}
    else if (input$idYearD == '' & input$idMonthD == '' & input$idWeekD != '') {dataClean[dataClean$Week == input$idWeekD & dataClean$Date >= input$idRangeD[1] & dataClean$Date <= input$idRangeD[2],]}
    else if (input$idYearD == '' & input$idMonthD != '' & input$idWeekD != '') {dataClean[format(dataClean$Date,"%B") == input$idMonthD & dataClean$Week == input$idWeekD & dataClean$Date >= input$idRangeD[1] & dataClean$Date <= input$idRangeD[2],]}
    else {dataClean[dataClean$Date >= input$idRangeD[1] & dataClean$Date <= input$idRangeD[2],]}
   )
   
   output$dataTable <- renderDataTable(
    datasetInputFilters(),
    options = list(order = list(list(0, 'asc')), pageLength = 10, searching = FALSE, dom = 'ltip')
   )
  
   #variation
   datasetInputSumVarN <- reactive(
    if (input$idYearD != '' & input$idMonthD == '' & input$idWeekD == '') {dataClean[format(dataClean$Date,"%Y") == input$idYearD & dataClean$Date >= input$idRangeD[1] & dataClean$Date <= input$idRangeD[2], c(10)]}
    else if (input$idYearD != '' & input$idMonthD != '' & input$idWeekD == '') {dataClean[format(dataClean$Date,"%Y") == input$idYearD & format(dataClean$Date,"%B") == input$idMonthD & dataClean$Date >= input$idRangeD[1] & dataClean$Date <= input$idRangeD[2], c(10)]}
    else if (input$idYearD != '' & input$idMonthD == '' & input$idWeekD != '') {dataClean[format(dataClean$Date,"%Y") == input$idYearD & dataClean$Week == input$idWeekD & dataClean$Date >= input$idRangeD[1] & dataClean$Date <= input$idRangeD[2], c(10)]}
    else if (input$idYearD != '' & input$idMonthD != '' & input$idWeekD != '') {dataClean[format(dataClean$Date,"%Y") == input$idYearD & format(dataClean$Date,"%B") == input$idMonthD & dataClean$Week == input$idWeekD & dataClean$Date >= input$idRangeD[1] & dataClean$Date <= input$idRangeD[2], c(10)]}
    else if (input$idYearD == '' & input$idMonthD != '' & input$idWeekD == '') {dataClean[format(dataClean$Date,"%B") == input$idMonthD & dataClean$Date >= input$idRangeD[1] & dataClean$Date <= input$idRangeD[2], c(10)]}
    else if (input$idYearD == '' & input$idMonthD == '' & input$idWeekD != '') {dataClean[dataClean$Week == input$idWeekD & dataClean$Date >= input$idRangeD[1] & dataClean$Date <= input$idRangeD[2],c(10)]}
    else if (input$idYearD == '' & input$idMonthD != '' & input$idWeekD != '') {dataClean[format(dataClean$Date,"%B") == input$idYearD & dataClean$Week == input$idWeekD & dataClean$Date >= input$idRangeD[1] & dataClean$Date <= input$idRangeD[2], c(10)]}
    else {dataClean[dataClean$Date >= input$idRangeD[1] & dataClean$Date <= input$idRangeD[2], c(10)]}
   )
   
   output$sumVarN <- renderText(sum(datasetInputSumVarN(), na.rm=T))
   
   #variation %
   datasetInputSumVarP <- reactive(
    if (input$idYearD != '' & input$idMonthD == '' & input$idWeekD == '') {dataClean[format(dataClean$Date,"%Y") == input$idYearD & dataClean$Date >= input$idRangeD[1] & dataClean$Date <= input$idRangeD[2], c(11)]}
    else if (input$idYearD != '' & input$idMonthD != '' & input$idWeekD == '') {dataClean[format(dataClean$Date,"%Y") == input$idYearD & format(dataClean$Date,"%B") == input$idMonthD & dataClean$Date >= input$idRangeD[1] & dataClean$Date <= input$idRangeD[2], c(11)]}
    else if (input$idYearD != '' & input$idMonthD == '' & input$idWeekD != '') {dataClean[format(dataClean$Date,"%Y") == input$idYearD & dataClean$Week == input$idWeekD & dataClean$Date >= input$idRangeD[1] & dataClean$Date <= input$idRangeD[2], c(11)]}
    else if (input$idYearD != '' & input$idMonthD != '' & input$idWeekD != '') {dataClean[format(dataClean$Date,"%Y") == input$idYearD & format(dataClean$Date,"%B") == input$idMonthD & dataClean$Week == input$idWeekD & dataClean$Date >= input$idRangeD[1] & dataClean$Date <= input$idRangeD[2], c(11)]}
    else if (input$idYearD == '' & input$idMonthD != '' & input$idWeekD == '') {dataClean[format(dataClean$Date,"%B") == input$idMonthD & dataClean$Date >= input$idRangeD[1] & dataClean$Date <= input$idRangeD[2], c(11)]}
    else if (input$idYearD == '' & input$idMonthD == '' & input$idWeekD != '') {dataClean[dataClean$Week == input$idWeekD & dataClean$Date >= input$idRangeD[1] & dataClean$Date <= input$idRangeD[2],c(11)]}
    else if (input$idYearD == '' & input$idMonthD != '' & input$idWeekD != '') {dataClean[format(dataClean$Date,"%B") == input$idYearD & dataClean$Week == input$idWeekD & dataClean$Date >= input$idRangeD[1] & dataClean$Date <= input$idRangeD[2], c(11)]}
    else {dataClean[dataClean$Date >= input$idRangeD[1] & dataClean$Date <= input$idRangeD[2], c(11)]}
   )
   
   output$sumVarP <- renderText(sum(datasetInputSumVarP(), na.rm=T))
   
   #data reset button
   observeEvent(input$idResD, {reset("idYearD")})
   observeEvent(input$idResD, {reset("idMonthD")})
   observeEvent(input$idResD, {reset("idWeekD")})
   observeEvent(input$idResD, {reset("idRangeD")})
   
   #data download button
   output$idDwn <- downloadHandler(
    filename = function() { 
     paste('uCount ', format(Sys.time(), "%Y-%m-%d %H.%M.%S"), '.csv', sep='')
    },
    content = function(file) {
     write.csv(datasetInput(), file)
    }
   )
   
   
   #Visualizer charts
   #chart 1 (visualizer1)
   datasetInputVisualizer1 <- reactive(
    if (input$idYearC1 != '' & input$idMonthC1 == '' & input$idWeekC1 == '') {dataClean[dataClean$Date >= input$idRangeC1[1] & dataClean$Date <= input$idRangeC1[2] & format(dataClean$Date,"%Y") == input$idYearC1,]}
    else if (input$idYearC1 != '' & input$idMonthC1 != '' & input$idWeekC1 == '') {dataClean[dataClean$Date >= input$idRangeC1[1] & dataClean$Date <= input$idRangeC1[2] & format(dataClean$Date,"%Y") == input$idYearC1 & format(dataClean$Date,"%B") == input$idMonthC1,]}
    else if (input$idYearC1 != '' & input$idMonthC1 == '' & input$idWeekC1 != '') {dataClean[dataClean$Date >= input$idRangeC1[1] & dataClean$Date <= input$idRangeC1[2] & format(dataClean$Date,"%Y") == input$idYearC1 & dataClean$Week == input$idWeekC1,]}
    else if (input$idYearC1 != '' & input$idMonthC1 != '' & input$idWeekC1!= '') {dataClean[dataClean$Date >= input$idRangeC1[1] & dataClean$Date <= input$idRangeC1[2] & format(dataClean$Date,"%Y") == input$idYearC1 & format(dataClean$Date,"%B") == input$idMonthC1 & dataClean$Week == input$idWeekC1,]} 
    else if (input$idYearC1 == '' & input$idMonthC1 != '' & input$idWeekC1 == '') {dataClean[dataClean$Date >= input$idRangeC1[1] & dataClean$Date <= input$idRangeC1[2] & format(dataClean$Date,"%B") == input$idMonthC1,]} 
    else if (input$idYearC1 == '' & input$idMonthC1 == '' & input$idWeekC1 != '') {dataClean[dataClean$Date >= input$idRangeC1[1] & dataClean$Date <= input$idRangeC1[2] & dataClean$Week == input$idWeekC1,]} 
    else if (input$idYearC1 == '' & input$idMonthC1 != '' & input$idWeekC1 != '') {dataClean[dataClean$Date >= input$idRangeC1[1] & dataClean$Date <= input$idRangeC1[2] & format(dataClean$Date,"%B") == input$idMonthC1 & dataClean$Week == input$idWeekC1,]} 
    else {dataClean[dataClean$Date >= input$idRangeC1[1] & dataClean$Date <= input$idRangeC1[2],]}
   )
   
   output$chart1 <- renderGvis(gvisLineChart(datasetInputVisualizer1(), "Date", c("Variation","Max/Min delta"), options=list(gvis.language="en", series="[{targetAxisIndex: 0}, {targetAxisIndex:1}]", vAxes="[{title:'Variation'}, {title:'Max/Min delta'}]")))

   #chart 2 (visualizer2)
   datasetInputVisualizer2 <- reactive(
    if (input$idYearC2 != '' & input$idMonthC2 == '' & input$idWeekC2 == '') {dataClean[dataClean$Date >= input$idRangeC2[1] & dataClean$Date <= input$idRangeC2[2] & format(dataClean$Date,"%Y") == input$idYearC2,]}
    else if (input$idYearC2 != '' & input$idMonthC2 != '' & input$idWeekC2 == '') {dataClean[dataClean$Date >= input$idRangeC2[1] & dataClean$Date <= input$idRangeC2[2] & format(dataClean$Date,"%Y") == input$idYearC2 & format(dataClean$Date,"%B") == input$idMonthC2,]}
    else if (input$idYearC2 != '' & input$idMonthC2 == '' & input$idWeekC2 != '') {dataClean[dataClean$Date >= input$idRangeC2[1] & dataClean$Date <= input$idRangeC2[2] & format(dataClean$Date,"%Y") == input$idYearC2 & dataClean$Week == input$idWeekC2,]}
    else if (input$idYearC2 != '' & input$idMonthC2 != '' & input$idWeekC2!= '') {dataClean[dataClean$Date >= input$idRangeC2[1] & dataClean$Date <= input$idRangeC2[2] & format(dataClean$Date,"%Y") == input$idYearC2 & format(dataClean$Date,"%B") == input$idMonthC2 & dataClean$Week == input$idWeekC2,]} 
    else if (input$idYearC2 == '' & input$idMonthC2 != '' & input$idWeekC2 == '') {dataClean[dataClean$Date >= input$idRangeC2[1] & dataClean$Date <= input$idRangeC2[2] & format(dataClean$Date,"%B") == input$idMonthC2,]} 
    else if (input$idYearC2 == '' & input$idMonthC2 == '' & input$idWeekC2 != '') {dataClean[dataClean$Date >= input$idRangeC2[1] & dataClean$Date <= input$idRangeC2[2] & dataClean$Week == input$idWeekC2,]} 
    else if (input$idYearC2 == '' & input$idMonthC2 != '' & input$idWeekC2 != '') {dataClean[dataClean$Date >= input$idRangeC2[1] & dataClean$Date <= input$idRangeC2[2] & format(dataClean$Date,"%B") == input$idMonthC2 & dataClean$Week == input$idWeekC2,]} 
    else {dataClean[dataClean$Date >= input$idRangeC2[1] & dataClean$Date <= input$idRangeC2[2],]}
   )
   
   output$chart2 <- renderGvis(gvisColumnChart(datasetInputVisualizer2(), "Date", "Mean", options=list(gvis.language="en", legend="none", series="[{color:'green', targetAxisIndex: 0}]")))
    

   #Katung's charts
   katung <- cbind (paste0(substr(weekdays(dataClean$Date),1,3),"."), dataClean[,c("Date","Week","Mean","Variation")])
   colnames(katung)[1] <- "Weekday"
   katung$Weekday <- factor(katung$Weekday, levels = c("Sun.","Mon.","Tues.","Wed.","Thu.","Fri.","Sat."))
   katung1 <- dcast(data = katung, formula = Weekday~Week, value.var = "Mean")
   katung2 <- dcast(data = katung, formula = Weekday~Week, value.var = "Variation")
   katung1 <- katung1[order(katung1$Weekday),]
   katung2 <- katung2[order(katung2$Weekday),]
   vertSize <- 600
   
   #chart 3 (katung1)
   output$chart3 <- renderGvis({gvisLineChart(katung1[katung1$Weekday %in% input$idWeekdayC3,], options=list(height=vertSize))})
   
   #chart 4 (katung2)
   output$chart4 <- renderGvis({gvisLineChart(katung2[katung2$Weekday %in% input$idWeekdayC4,], options=list(height=vertSize))})
   
   
   #uCount's charts
   monthlyAgg <- aggregate(dataClean[,c(10)], by=list(format(dataClean$Date, "%Y%m")), FUN=sum, na.rm=TRUE)
   colnames(monthlyAgg)[1] <- "Date"
   colnames(monthlyAgg)[2] <- "Monthly count"
   yearlyAgg <- aggregate(dataClean[,c(10)], by=list(format(dataClean$Date, "%Y")), FUN=sum, na.rm=TRUE)
   colnames(yearlyAgg)[1] <- "Date"
   colnames(yearlyAgg)[2] <- "Yearly count"
   
   #chart 5 (ucount1)
   output$chart5 <- renderGvis({
     
    if (input$idYearC5 != '' & input$idMonthC5 == '') {
     gvisBarChart(monthlyAgg[as.numeric(substr(monthlyAgg$Date,1,4)) == input$idYearC5,], options=list(height=vertSize, legend="none", series="[{color:'blue'}]"))
    } else if (input$idYearC5 == '' & input$idMonthC5 != '') {
     gvisBarChart(monthlyAgg[as.numeric(substr(monthlyAgg$Date,5,6)) == match(substr(input$idMonthC5,1,3),month.abb),], options=list(height=vertSize, legend="none", series="[{color:'blue'}]"))
    } else if (input$idYearC5 != '' & input$idMonthC5 != '') {
     gvisBarChart(monthlyAgg[as.numeric(substr(monthlyAgg$Date,1,4)) == input$idYearC5 & as.numeric(substr(monthlyAgg$Date,5,6)) == match(substr(input$idMonthC5,1,3),month.abb),], options=list(height=vertSize, legend="none", series="[{color:'blue'}]"))
    } else {
     gvisBarChart(monthlyAgg, options=list(height=vertSize, legend="none", series="[{color:'blue'}]"))
    }
   
   })
   
   #chart 6 (ucount2)
   output$chart6 <- renderGvis({
     
    if (input$idYearC6 != '') {
     gvisColumnChart(yearlyAgg[as.numeric(substr(yearlyAgg$Date,1,4)) == input$idYearC6,], options=list(height=vertSize, legend="none", series="[{color:'red'}]"))
    } else {
     gvisColumnChart(yearlyAgg, options=list(height=vertSize, legend="none", series="[{color:'red'}]"))
    }
     
   })
   
   #Charts reset button
   observeEvent(input$idResC1, {reset("idYearC1")})
   observeEvent(input$idResC1, {reset("idMonthC1")})
   observeEvent(input$idResC1, {reset("idWeekC1")})
   
   observeEvent(input$idResC2, {reset("idYearC2")})
   observeEvent(input$idResC2, {reset("idMonthC2")})
   observeEvent(input$idResC2, {reset("idWeekC2")})
   
   observeEvent(input$idResC3, {reset("idWeekdayC3")})
   
   observeEvent(input$idResC4, {reset("idWeekdayC4")})
   
   observeEvent(input$idResC5, {reset("idYearC5")})
   observeEvent(input$idResC5, {reset("idMonthC5")})
   
   observeEvent(input$idResC6, {reset("idYearC6")})
  
})
#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# install.packages("shiny")
# install.packages("dplyr")
# install.packages("quantmod")
library(shiny)
library(dplyr)
library(quantmod)

# Define server logic required to draw a histogram
shinyServer(function(input, output,session) {
    v<-reactiveValues(dataupload = FALSE)
    
    observeEvent(input$button1,{ v$dataupload = TRUE})
    
    output$stext<-renderText({
        if (v$dataupload == FALSE) return ()
        upload()
        "Data Upload complete"})
    
    upload<-function(){
        stock_name <- as.character(input$Stock_Name)
        stocks <- getSymbols(stock_name, auto.assign=FALSE)
        return(stocks)
    }
    
    output$distPlot <- renderPlot({
        stocks<- upload()
        Start_Date <- input$date_range[1]
        end_date <- input$date_range[2]
        df<-stocks %>%
            subset(index(.)> Start_Date & index(.)< end_date)
        chartSeries(df,name = input$stock_name)
        addEMA(as.numeric(input$MA),overlay = TRUE,col = "red")
        
    })

})

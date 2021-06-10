 #
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
#install.packages("shiny")
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Shiny Stock Dashboard"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            tags$form(
                textInput("Stock_Name","Stock Name",value = "^NSEI"),
                tags$head(tags$script(src = "message-handler.js")),
                actionButton("button1", "Get Data")),
            tags$form(
                dateRangeInput("date_range","Enter Date",start = Sys.Date() - 365, end = Sys.Date(),),
                numericInput("MA","Moving Average",value = 100)
        )),

        # Show a plot of the generated distribution
        mainPanel(
            textOutput("stext"),
            plotOutput("distPlot")
        )
    )
))


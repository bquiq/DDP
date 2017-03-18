#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(caret)
library(randomForest)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predict iris species with petal length and petal width"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       h3("Define the predictors"),
       numericInput("lgth", "Petal length",value = 0,min = 0,max=8,step = 0.1),
       numericInput("wdth", "Petal width",value = 0,min = 0,max=3,step = 0.1),
       submitButton("Submit"),
       h3("Prediction of Species: "),
       h3(textOutput("species"))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotlyOutput("distPlot"),
       h2("How to?"),
       h4("Define petal length and width on the left and click submit in order to predict the iris species. Your prediction will be displayed on the plot.")
       
       
    )
  )
))

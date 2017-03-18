#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(caret)
library(randomForest)
library(e1071)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    #Load and prepare data
    set.seed(284)
    data(iris)
    md<-iris[,-c(1,2)]
    
    #Fit a prediction model
    tc<-trainControl(method="cv",5)
    fit<-train(data =  md, Species~.,method="rf", trainControl=tc)
    
    rfpred<- reactive({
        toPredict<-data.frame(Petal.Length=input$lgth,Petal.Width=input$wdth)
        toPredict$Species<-predict(fit,toPredict)
        return(toPredict)
    })
    
  output$distPlot <- renderPlotly({
      all<-rbind(md,rfpred())
      a <- list(
          x = rfpred()$Petal.Length,
          y = rfpred()$Petal.Width,
          text = "My prediction",
          xref = "Petal.Length",
          yref = "Petal.Width",
          showarrow = TRUE,
          arrowhead = 1,
          ax = 120,
          ay = -50
      )
      
      plot_ly(all, x = ~Petal.Length, y = ~Petal.Width, mode = "markers", color = ~Species) %>%
          layout(annotations=a)
    
  })
  
  output$species<- renderText({
      levels(rfpred()$Species)[rfpred()$Species]
  })
  
})

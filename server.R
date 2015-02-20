library(shiny)
library(datasets)

mpgData <- mtcars
#mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))

shinyServer(function(input, output) {
  formulaString <- reactive({
    paste("mpg ~ ", input$variable)
  })

  fit <- reactive({
    lm(as.formula(formulaString()), data = mpgData)
  })
  
  output$summaryFit <- renderPrint({
    summary(fit())
  })
  
  output$mpgPlot <- renderPlot({
    with(mpgData, {
      plot(as.formula(formulaString()), main = formulaString())
      abline(fit(), col = 4)
    })
  })
})
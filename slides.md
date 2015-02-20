---
title       : MPG predictors
author      : Paul Cuciureanu
email       : paulcu@gmail.com
job         : Part 2 - Reproducible Pitch Presentation
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [bootstrap]   # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Explore mtcars

### Part 1: Shiny App
Discover which variables predict miles per gallon (MPG)

*https://pcuci.shinyapps.io/devdataprod-mtcars*

### Part 2: Reproducible Pitch Presentation  

*http://pcuci.github.io/*
  
### Clone the repo
```
git clone https://github.com/pcuci/devdataprod-mtcars.git
```

--- .class #id

## Dataset

### Motor Trend Car Road Tests
The data was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973–74 models).

### Source
Henderson and Velleman (1981), Building multiple regression models interactively. Biometrics, 37, 391–411.


```r
library(datasets)
head(mtcars, 2)
```

```
##               mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4      21   6  160 110  3.9 2.620 16.46  0  1    4    4
## Mazda RX4 Wag  21   6  160 110  3.9 2.875 17.02  0  1    4    4
```

---

## Format
  
A data frame with 32 observations on 11 variables.
  
1. `mpg` Miles/(US) gallon
1. `cyl` Number of cylinders 
1. `disp` Displacement (cu.in.) 
1. `hp` Gross horsepower 
1. `drat` Rear axle ratio 
1. `wt` Weight (lb/1000) 
1. `qsec` 1/4 mile time 
1. `vs` V-engine / Standard 
1. `am` Transmission (0 = automatic, 1 = manual) 
1. `gear` Number of forward gears 
1. `carb` Number of carburetors 

---

## Reactive Server Code
  
```r
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
```

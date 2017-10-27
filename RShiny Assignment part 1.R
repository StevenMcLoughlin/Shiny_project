#Steven McLoughlin
#17235399
#MA5111
#Assingment_1_Part1

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  titlePanel("Distribution"),
  
  sidebarPanel(
  numericInput(inputId = "sampleSize",
              label = "Enter Sample Size",
              value = 10, min=1, max=1000),
  
  sliderInput(inputId = "mean", 
              label = "Adjust Mean", 
              value = 5, min =1 , max = 700),
  
  
  sliderInput(inputId = "sd", 
              label = "Adjust Standard Deviation", 
              value = 1, min = 1, max = 50)),
  
  mainPanel(
  plotOutput("hist"))
  
  )

server <- function(input, output){
  output$hist <-renderPlot(({
    
    hist(rnorm(input$sampleSize, mean=input$mean, sd=input$sd), 
         main = 'Distribution Graph', xlab = 'SD from Mean', 
         col = "black", border = "white")
    
  
    }))
}

shinyApp(ui=ui, server=server)
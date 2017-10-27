#Steven McLoughlin
#17235399
#MA5111
#Assig_1_RShiny


#Load Shiny Library
library(shiny)

# Develop ui for shiny app via fluid page
ui <- fluidPage(
  
  # Title panel, sidebar panel comprising .csv file input,
  #select input to isolate variables in .csv file, radiobuttons to 
  #select colours of box plot, and set up main page for displaying the rendered 
  #table and box plots.
  titlePanel("Patient Data"),
  sidebarLayout(
    sidebarPanel(
      fileInput("data_file", "Choose CSV File",
                accept = c(
                  "text/csv",
                  "text/comma-separated-values,text/plain",
                  ".csv")
      ),
      tags$hr(), 
      checkboxInput("header", "Header", TRUE)
      ,
      
      selectInput("var", "Select a variable:",
                  c("Age" = "age",
                    "Height" = "height",
                    "Weight" = "weight",
                    "Bmi" = "bmi")),
      
      radioButtons("cols", "Colours", 
                   c("Yellow",
                     "Purple",
                     "Red",
                     "Blue")))
    
    ,
    mainPanel(
      tableOutput("data"),
      plotOutput("variables")
    )))

#server code to the build app from ui objects  

server <- function(input, output){
  output$data <-renderTable({ 
    infile <-input$file1
    if (is.null(infile))
      return(NULL)
    c <-read.csv(infile$datapath, header = input$header)
    
  })
  output$variables <-renderPlot({
    (req(input$data_file))
    file <- input$data_file
    data <-read.csv(file$datapath, header=input$header)
    var <-input$var
    col <-input$cols
    boxplot(data[,var], col=col, main=paste("Selected Variable", var))
  })}





# Combine ui and server to run the app
shinyApp(ui = ui, server = server)

#}
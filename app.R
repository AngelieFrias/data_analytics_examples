#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
#
# DATA 200 HW 7 - Question 1 App
# Ángelie A. Heredia Frías
# Novermber 13, 2020
#
# sources: https://shiny.rstudio.com/gallery/telephones-by-region.html, lab files
#  

library(shiny)
library(datasets)

shinyApp(
    # Use a fluid Bootstrap layout
    ui <- fluidPage(    
        
        # Page a title
        titlePanel("Number of Telephones by Region"),
        
        # Generate a row with a sidebar
        sidebarLayout(      
            
            # Define sidebar input
            sidebarPanel(
                hr(),
                helpText("Use the dropdown tool below to choose a region for the data."),
                
                selectInput("region", "Region:", 
                            choices=colnames(WorldPhones)),
                
                hr(),
                helpText("Use the buttons below to choose a color for the graph."),
                
                # Radio Buttons for color
                radioButtons(
                    "radio",
                    label = "Set Histogram Color:",
                    choices = c("Light Green", "Pink", "Light Blue"),
                    select = "Pink"
                ),
            ),
            
            # Create a spot for the barplot
            mainPanel(
                textOutput("text3color"),
                plotOutput("phonePlot")
            )
            
        )
    ),
    
    server <- function(input, output) {
        
        output$textcolor <- renderText({
            paste("Histogram Color: ", input$radio)
        })
        
        # Fill in the spot we created for a plot
        output$phonePlot <- renderPlot({
            
            # Render a barplot
            barplot(WorldPhones[,input$region]*1000, 
                    main=input$region,
                    ylab="Number of Telephones",
                    xlab="Year",
                    col = input$radio)
        })
    }
)

shinyApp(ui, server)


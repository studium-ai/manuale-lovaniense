#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(dplyr)
library(magrittr)
library(dplyr)
library(readr)
library(plotly)

ml_records = read_csv('/Users/ghum-m-ae231206/odis-exporter/2024-01-16_ml_sources_table.csv')


ml_records %>% 
  group_by(y1, format) %>% 
  summarise(n = n()) %>%
  filter(y1 %in% 1450:1800) %>% 
  ggplot() + geom_col(aes(y1, n, fill = format))

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1400,
                        max = 1800,
                        value = c(1400,1800))
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
      
      
      ml_records %>% filter(y1 >= input$bins[1]  & y1 <= input$bins[2]) %>% 
        group_by(y1, format) %>% 
        summarise(n = n()) %>%
        filter(y1 %in% 1450:1800) %>% 
        ggplot() + geom_col(aes(y1, n, fill = format))
    })
}

# Run the application 
shinyApp(ui = ui, server = server)

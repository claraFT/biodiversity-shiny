# Biodiversity in poland - Shiny App
# Load required libraries
library(shiny)
library(leaflet)
library(dplyr)
library(tidyr)
library(ggplot2)
library(RColorBrewer)
library(testthat)
#Load modules and functions
source("R/mod_map.R")
source("R/mod_plot.R")
source("R/format_function.R")

# Load and process data data
poland_data <- read.csv(file = "./data/Poland_occurences.csv") %>% 
  format_biodiversity_data()

ui <- fluidPage(
  titlePanel("Biodiversity Information - Poland"),
  sidebarLayout(
    sidebarPanel(
      selectizeInput("species", "Select Species name:", choices = unique(poland_data$species_name), options = list(maxOptions = 1000)),
      sliderInput("dateRange", "Select Date Range:",
                  min = min(poland_data$eventDate, na.rm = TRUE),
                  max = max(poland_data$eventDate, na.rm = TRUE),
                  value = c(min(poland_data$eventDate, na.rm = TRUE), max(poland_data$eventDate, na.rm = TRUE)),
                  timeFormat = "%Y")
    ),
    
    mainPanel(
      mod_plot_ui("plot1"),
      mod_map_ui("map1"),
    )
  )
)

server <- function(input, output, session) {
  colors <- c("dodgerblue", "dodgerblue4")
  pal <- colorFactor(colors, poland_data$year)
  custom_palette <- colorRampPalette(brewer.pal(name = "YlOrRd", n = 9))(30)
  
  updateSelectizeInput(session, "species", choices = unique(poland_data$species_name), server = TRUE)
  filtered_data <- reactive({
    data <- poland_data
    if (!is.null(input$species) && length(input$species) > 0) {
      data <- data[data$species_name %in% input$species, ]
    }
    data
  })
  
  final_filtered_data <- reactive({
    data <- filtered_data()
    if (!is.null(input$dateRange)) {
      data <- data[data$eventDate >= input$dateRange[1] & data$eventDate <= input$dateRange[2], ]
    }
    data
  })
  
  mod_map_server("map1", final_filtered_data, pal)
  mod_plot_server("plot1", final_filtered_data)

}

shinyApp(ui = ui, server = server)



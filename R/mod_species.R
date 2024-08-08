# species selection module
mod_species_ui <- function(id) {
  ns <- NS(id)
  tagList(
    selectizeInput(ns("species"), "Select Species name:", choices = unique(poland_data$species_name), options = list(maxOptions = 1000))
  )
}

# server function
mod_species_server <- function(id, poland_data) {
  moduleServer(id, function(input, output, session) {
    updateSelectizeInput(session, "species", choices = unique(poland_data$species_name), server = TRUE)
    
    filtered_data <- reactive({
      data <- poland_data
      if (length(input$species) > 0) {
        data <- data[data$species_name %in% input$species, ]
      }
    })
    

    return(filtered_data)
  })
}




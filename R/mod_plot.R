mod_plot_ui <- function(id) {
  ns <- NS(id)
  plotOutput(ns("plot2"), height = "90px")
}

mod_plot_server <- function(id, filtered_data) {
  moduleServer(id, function(input, output, session) {
    output$plot2 <- renderPlot({
      data <- filtered_data()
      unique_dates <- unique(data$eventDate)
      
      if (length(unique_dates) == 1) {
        ggplot(data, aes(x = eventDate, y = species_name, color = year)) +
          geom_point(size = 3.5, alpha = 0.5, color = "dodgerblue4") +
          guides(color = FALSE) +
          theme_minimal() +
          theme(
            axis.text.x = element_text(angle = 45, hjust = 1),
            axis.title.x = element_blank(),
            axis.title.y = element_blank()
          ) +
          scale_x_date(date_labels = "%Y-%m-%d")
      } else {
        ggplot(data, aes(x = eventDate, y = species_name, color = year)) +
          geom_point(size = 3.5, alpha = 0.5, color = "dodgerblue4") +
          guides(color = FALSE) +
          theme_minimal() +
          theme(
            axis.text.x = element_text(angle = 45, hjust = 1),
            axis.title.x = element_blank(),
            axis.title.y = element_blank()
          )
      }
    })
  })
}
mod_map_ui <- function(id) {
  ns <- NS(id)
  leafletOutput(ns("mymap"))
}

mod_map_server <- function(id, filtered_data, pal) {
  moduleServer(id, function(input, output, session) {
    output$mymap <- renderLeaflet({
      leaflet() %>%
        addTiles() %>%
        setView(lng = 20.00, lat = 53.00, zoom = 5) %>%
        addCircleMarkers(data = filtered_data(), ~longitudeDecimal, ~latitudeDecimal, radius = ~3, opacity = 5, popup = ~popup_info, color = ~pal(year))
    })
  })
}
# format function
format_biodiversity_data <- function(data) {
  data$eventDate = as.Date(data$eventDate)
  formatted_data <- data %>%  
    mutate(vernacularName = case_when(is.na(vernacularName) & !is.na(scientificName)  ~ scientificName,
                                      TRUE ~ vernacularName),
           scientificName = case_when(is.na(scientificName) & !is.na(vernacularName)  ~ vernacularName,
                                      TRUE ~ scientificName)) %>% 
    pivot_longer(cols = c(vernacularName, scientificName), names_to = "type_name", values_to = "species_name") %>% 
    mutate(year = format(eventDate, "%Y"),
           popup_info = paste0("Species name: ", species_name, "<br/>", "Type of name: ", type_name, "<br/>", "Event date: ", eventDate, "<br/>", "Country: ", country, "<br/>", "Latitude: ", latitudeDecimal, "<br/>", "Longitude: ", longitudeDecimal))
  
  return(formatted_data)
}
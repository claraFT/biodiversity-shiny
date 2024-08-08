
# Load packages
library(readr)
library(data.table)

file_path <-  "./biodiversity-data/occurence.csv"

list_of_data <- list()
# Since the data is quite big, download data by chunks. Only useful columns and Poland data.
process_chunk <- function(chunk, pos) {
  # Select only necessary columns
  chunk_selected <- chunk[, c("id", "scientificName", "vernacularName", 
                              "longitudeDecimal", "latitudeDecimal", "country", 
                              "eventDate")]
  
  # Filter for rows where country is "Poland"
  chunk_filtered <- chunk_selected[chunk_selected$country == "Poland", ]
  
  list_of_data <<- c(list_of_data, list(chunk_filtered))
}
read_csv_chunked(file_path, callback = SideEffectChunkCallback$new(process_chunk), 
                 chunk_size = 10000) 

# combine and save
final_data <- do.call(rbind, list_of_data)
write.csv(final_data, file = "./data/Poland_occurences.csv", row.names = FALSE)

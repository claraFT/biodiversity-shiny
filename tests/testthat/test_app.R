
library(testthat)
library(dplyr)

# Test input data structure is correct
test_that("Input data has necessary columns.", {
  head_data <- read.csv(file = "../../data/Poland_occurences.csv") %>% 
    head(55)
  expected_colnames = c("id", "scientificName", "vernacularName", "longitudeDecimal", "latitudeDecimal", "country", "eventDate")
  expect_true(unique(expected_colnames %in% colnames(head_data)))
})

# Test that the data formatting function works correctly
test_that("Formatting functions works.", {
  head_data <- read.csv(file = "../../data/Poland_occurences.csv") %>% 
    head(55)
  source("../../R/format_function.R")
  formatted <- format_biodiversity_data(data = head_data)
  expect_false(unique(is.na(formatted$species_name)))
  expect_true(class(formatted$eventDate) == "Date")
})

# Test the input selection
test_that("selectizeInput updates correctly", {
  head_data <- read.csv(file = "../../data/Poland_occurences.csv") %>% 
    head(55)
  source("../../R/format_function.R")
  formatted <- format_biodiversity_data(data = head_data)
  formatted <- format_biodiversity_data(data = head_data)
  
  server <- function(input, output, session) {
    observeEvent(input$species, {
      filtered_data <- formatted[formatted$species_name %in% input$species, ]
    })
  }
  test_input <- list(
    species =  "Lacerta agilis"   # random species name found in the data
  )
  # test server logic
  testServer(server, {
    session$setInputs(species = test_input$species)
    Sys.sleep(0.5)
    # check the input it OK
    expect_equal(input$species, test_input$species)
    # check the data is filtered OK for map and plot
    filtered_data <- poland_data[poland_data$species_name %in% input$species, ]
    expect_true(nrow(filtered_data) > 0)
  })
})

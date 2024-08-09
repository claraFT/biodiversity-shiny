## Description

The app provides an interactive visualization of biodiversity data in
Poland as available in <https://www.gbif.org/>. Users can select
different species using their scientific or vernacular name to plot them
on a map and view a timeline showing when they were observed. Detailed
information about each observation can be accessed by clicking on the
markers on the map.

## Table of Contents

- [Description](#description)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Limitations and future work](#limitations_and_future_work)

## Features

- **Interactive Map**: Select and display different species on a map.
- **Timeline Plot**: Visualize the timeline of species observations.
- **Data Filtering**: Filter data by species, both scientific and
  vernacular names are available.
- **Event date Filtering**: Filter by specific year range to visualize
  species observations within a chosen time window.

## Installation

This app is available at the following link: https://claraft.shinyapps.io/appsilon_assignment/
If you want to run this Shiny app locally, please follow these steps:

1.  Clone the repository:

<!-- -->

       git clone https://github.com/claraft/biodiversity-shiny-appsilon.git

2.  Install and load the required packages:

<!-- -->

    setwd("~/biodiversity-shiny-appsilon")
    install.packages(c("shiny", "leaflet", "ggplot2", "dplyr", "tidyr", "RColorBrewer", "testthat"))
    library(shiny)

3.  Run the app

<!-- -->

    runApp()

## Usage

1.  Launch the app by running the above command.
2.  Select species from the dropdown menu.
3.  Interact with the map to see the geographical distribution of the
    selected species.
4.  View the timeline plot to know when the different species
    observations happened.
5.  Select specific time windows to focus on species observation groups over
    time

## Testing

To run unit test for this repo run then following code

<!-- -->

    test_dir("tests/testthat")

## Limitations and future work

Due to time constraints, this application has limited features. Below
are some suggestions for improvement:

1.  **Expand Number of Countries**: Currently, the application includes
    only one country (Poland). The script to filter the complete dataset
    by country, selecting only the most relevant columns, is available
    in this repository as format_data.R. With more computational
    resources, the map could be expanded to include biodiversity
    information for a larger number of countries. Integrating a database
    connection would facilitate the retrieval of large data volumes
    using queries, thereby creating a faster, more comprehensive Shiny
    application.

2. **Enhance Testing**: Expand the unit tests to cover the map and plot modules more thoroughly, and develop more targeted tests specifically for Shiny functions to ensure robust and reliable functionality. 

4.  **Enhanced Event Visualization**: The time slider could be made
    reactive to adapt to the species selected in the first filter.
    Additionally, integrating a play button to display how observations
    change over time on the map would provide a more dynamic and
    informative visualization.

5.  **Aesthetic Improvements**: Using a CSS file to modify the app’s
    appearance could make it more aesthetically pleasing, personalized,
    and user-friendly. This would enhance the overall user experience.

These enhancements would significantly increase the application’s
functionality and user engagement.

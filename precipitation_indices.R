# Load required libraries
library(precintcon)  # Precipitation indices computation
library(tidyverse)   # Data manipulation
library(writexl)     # Write data to Excel files

# -------------------------------------------------------------------------
# STEP 1: Load and transform daily rainfall data
# -------------------------------------------------------------------------

# Read input CSV file
data <- read_csv("clmto.csv")

# Prepare daily data in wide format
daily_data <- data %>%
  select(
    Station_Name,
    year = Year,
    month = Month,
    Day,
    Rain = RR
  ) %>%
  filter(between(year, 1991, 2024)) %>%
  mutate(Day = paste0("d", Day)) %>%
  pivot_wider(
    id_cols = c(Station_Name, year, month),
    names_from = Day,
    values_from = Rain,
    names_sort = TRUE,
    values_fill = NA
  )

# Extract unique station names
unique_stations <- unique(daily_data$Station_Name)

# -------------------------------------------------------------------------
# STEP 2: Define computation functions for each index
# -------------------------------------------------------------------------

# Compute PCD (Precipitation Concentration Degree)
func_pcd <- function(station, data = daily_data) {
  result <- data %>%
    filter(Station_Name == station) %>%
    select(-Station_Name) %>%
    as.daily() %>%
    pcd()
  
  result$station <- station
  result %>% select(station, everything())
}

# Compute PCI (Precipitation Concentration Index) - Seasonal
func_pci_seasonal <- function(station, data = daily_data) {
  result <- data %>%
    filter(Station_Name == station) %>%
    select(-Station_Name) %>%
    as.daily() %>%
    pci.seasonal(hemisthere = "n")
  
  result$station_name <- station
  as_tibble(result) %>% select(station_name, everything())
}

# Compute PCI - Supraseasonal
func_pci_supraseasonal <- function(station, data = daily_data) {
  result <- data %>%
    filter(Station_Name == station) %>%
    select(-Station_Name) %>%
    as.daily() %>%
    pci.supraseasonal(hemisthere = "n")
  
  result$station <- station
  as_tibble(result) %>% select(station, everything())
}

# Compute PCP (Precipitation Concentration Period)
func_pcp <- function(station, data = daily_data) {
  result <- data %>%
    filter(Station_Name == station) %>%
    select(-Station_Name) %>%
    as.daily() %>%
    pcp()
  
  result$station <- station
  as_tibble(result) %>% select(station, everything())
}

# Compute SPI (Standardized Precipitation Index) over 3-month periods
func_spi <- function(station, data = daily_data, period = 3) {
  result <- data %>%
    filter(Station_Name == station) %>%
    select(-Station_Name) %>%
    as.daily() %>%
    as.monthly() %>%
    spi(period = period) %>%
    as_tibble()
  
  result$station <- station
  result %>% select(station, everything())
}

# Compute RAI (Rainfall Anomaly Index) at monthly granularity
func_rai <- function(station, data = daily_data) {
  result <- data %>%
    filter(Station_Name == station) %>%
    select(-Station_Name) %>%
    as.daily() %>%
    rai(granularity = "m") %>%
    as_tibble()
  
  result$station <- station
  result %>% select(station, everything())
}

# Compute TII (Temporal Irregularity Index)
func_tii <- function(station, data = daily_data) {
  result <- data %>%
    filter(Station_Name == station) %>%
    select(-Station_Name) %>%
    as.daily() %>%
    tii() %>%
    as_tibble()
  
  result$station <- station
  result %>% select(station, everything())
}

# -------------------------------------------------------------------------
# STEP 3: Apply all functions to each station and export results
# -------------------------------------------------------------------------

# Compute and export results for all indices
pcd_data <- map_dfr(unique_stations, func_pcd)
write_xlsx(pcd_data, "pcd_result.xlsx")

pci_seasonal_data <- map_dfr(unique_stations, func_pci_seasonal)
write_xlsx(pci_seasonal_data, "pci_seasonal_result.xlsx")

pci_supraseasonal_data <- map_dfr(unique_stations, func_pci_supraseasonal)
write_xlsx(pci_supraseasonal_data, "pci_supraseasonal_result.xlsx")

pcp_data <- map_dfr(unique_stations, func_pcp)
write_xlsx(pcp_data, "pcp_result.xlsx")

spi_data <- map_dfr(unique_stations, func_spi)
write_xlsx(spi_data, "spi_result.xlsx")

rai_data <- map_dfr(unique_stations, func_rai)
write_xlsx(rai_data, "rai_result.xlsx")

tii_data <- map_dfr(unique_stations, func_tii)
write_xlsx(tii_data, "tii_result.xlsx")

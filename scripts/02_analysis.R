# Setup -------------------------------------------------------------------
library(tidyverse)

# Load cleaned data
clean_data <- read_csv("data/processed/clean_data.csv")

# Calculate key metrics ---------------------------------------------------
# For Sturges' Rule
n_obs <- nrow(clean_data)
sturges_bins <- round(1 + 3.322 * log10(n_obs))

# For Freedman-Diaconis Rule
iqr_value <- IQR(clean_data$PTOTAL)
fd_binwidth <- 2 * iqr_value / (n_obs^(1 / 3))

# Save analysis outputs (optional)
dir.create("outputs/tables", recursive = TRUE, showWarnings = FALSE)
saveRDS(
  list(sturges_bins = sturges_bins, fd_binwidth = fd_binwidth),
  "outputs/tables/bin_calculations.rds"
)
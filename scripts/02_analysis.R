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

## Calculate the range for the intervals
min_score <- min(clean_data$PTOTAL)
max_score <- max(clean_data$PTOTAL)
range_score <- max_score - min_score

## Calculate class width (rounded to nearest 5 for readability)
class_width <- ceiling(range_score / sturges_bins / 5) * 5

class_width_no_rounding <- ceiling(range_score / sturges_bins)

breaks <- seq(
  from = floor(min_score / 10) * 10,  
  to = ceiling(max_score / 10) * 10,
  by = class_width
)

labels <- paste(
  head(breaks, -1), 
  tail(breaks, -1),
  sep = " - "
)

# Create frequency table
frequency_table <- clean_data %>%
  mutate(Score_Interval = cut(PTOTAL, breaks = breaks, labels = labels)) %>%
  count(Score_Interval) %>%
  mutate(
    Percentage = n / sum(n) * 100,
    Cumulative_Percentage = cumsum(Percentage)
  )

# Save frequency table
write_csv(frequency_table, "outputs/tables/score_frequency_table.csv")

# Save analysis outputs (optional)
dir.create("outputs/tables", recursive = TRUE, showWarnings = FALSE)
saveRDS(
  list(sturges_bins = sturges_bins, fd_binwidth = fd_binwidth),
  "outputs/tables/bin_calculations.rds"
)


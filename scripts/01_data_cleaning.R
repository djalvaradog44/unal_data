library(tidyverse)

# Define paths (relative to project root)
raw_data_path <- "data/raw/Microdatos_Aspirantes_y_Admitidos_en_la_UNAL_20250215.csv" # nolint: line_length_linter.
processed_data_path <- "data/processed/clean_data.csv"

# Load raw data
data_unal <- read_csv(raw_data_path)

# Preprocess Data using 
data_unal <- data_unal %>%
  mutate(across(where(is.character), as.factor)

# Filter for "Pregrado" and clean PTOTAL
clean_data <- data_unal %>%  # nolint
  filter(
    TIPO_NIVEL == "Pregrado",
    !is.na(PTOTAL),
    PTOTAL > 0
  ) %>%
  select(-TIPO_NIVEL)

# Save cleaned data
dir.create(dirname(processed_data_path), recursive = TRUE, showWarnings = FALSE)
write_csv(clean_data, processed_data_path)
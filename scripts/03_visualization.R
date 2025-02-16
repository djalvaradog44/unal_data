# Setup -------------------------------------------------------------------
library(tidyverse)
library(ggplot2)
library(scales)
library(RColorBrewer)

# Define paths
clean_data_path <- "data/processed/clean_data.csv"
figure_path <- "outputs/figures"

# Load data ---------------------------------------------------------------
clean_data <- read_csv(clean_data_path)
bin_calculations <- readRDS("outputs/tables/bin_calculations.rds")

# Create figures directory
dir.create(figure_path, recursive = TRUE, showWarnings = FALSE)

# Figure 1: Score distribution by level (raw data) ------------------------
# Load raw data for comparison (optional)
raw_data <- read_csv("data/raw/Microdatos_Aspirantes_y_Admitidos_en_la_UNAL_20250215.csv") # nolint: line_length_linter.

plot_raw_level <- ggplot(raw_data, aes(x = TIPO_NIVEL, fill = TIPO_NIVEL)) +
  geom_bar() +
  scale_fill_brewer(palette = "Set2") +
  labs(title = "Applicants by Program Level (Raw Data)")

ggsave(file.path(figure_path, "raw_program_level.png"), plot_raw_level)

# Figure 2: Histograms ---------------------------------------------------
hist_sturges <- ggplot(clean_data, aes(x = PTOTAL)) +
  geom_histogram(bins = bin_calculations$sturges_bins, fill = "skyblue") +
  labs(title = "Admission Scores (Sturges' Bins)")

hist_fd <- ggplot(clean_data, aes(x = PTOTAL)) +
  geom_histogram(binwidth = bin_calculations$fd_binwidth, fill = "steelblue") +
  labs(title = "Admission Scores (Freedman-Diaconis Bins)")

ggsave(file.path(figure_path, "histogram_sturges.png"), hist_sturges)
ggsave(file.path(figure_path, "histogram_fd.png"), hist_fd)

# Figure 3: Boxplots ------------------------------------------------------
# Overall boxplot
boxplot_overall <- ggplot(clean_data, aes(y = PTOTAL)) +
  geom_boxplot(fill = "#69b3a2") +
  labs(title = "Admission Scores Distribution")

# Boxplots by year/department
boxplot_year <- ggplot(clean_data, aes(x = factor(YEAR), y = PTOTAL, fill = factor(YEAR))) + # nolint: line_length_linter.
  geom_boxplot() +
  labs(title = "Scores by Admission Year") +
  theme(legend.position = "none")

boxplot_dept <- ggplot(clean_data, aes(x = DEP_NAC, y = PTOTAL, fill = DEP_NAC)) + # nolint: line_length_linter.
  geom_boxplot() +
  labs(title = "Scores by Department") +
  theme(legend.position = "none")

ggsave(file.path(figure_path, "boxplot_overall.png"), boxplot_overall)
ggsave(file.path(figure_path, "boxplot_year.png"), boxplot_year)
ggsave(file.path(figure_path, "boxplot_dept.png"), boxplot_dept)
install.packages("RColorBrewer")
install.packages("tidyverse")
install.packages("scales")


data_unal <- read.csv("C:/Users/tesla/Documents/Estadistica descriptiva/Datasets/Microdatos_Aspirantes_y_Admitidos_en_la_UNAL_20250215.csv")

factor_variables <- sapply(data_unal, is.character)

data_unal[factor_variables] <- lapply(data_unal[factor_variables], as.factor)

levels(data_unal$ESTRATO)

summary(data_unal$PTOTAL)

levels(data_unal$TIPO_NIVEL)


library(RColorBrewer)
coul <- brewer.pal(5, "Set2")
barplot(table(data_unal$TIPO_NIVEL), main="Nivel de Programa", col=coul, xlab="Nivel")

library(ggplot2)
library(scales)
ggplot(data_unal, aes(x=TIPO_NIVEL, fill = TIPO_NIVEL)) +
  geom_bar( ) + scale_y_continuous(labels = label_number()) +
  scale_fill_hue(c = 40) +
  theme(legend.position="none")  

library(dplyr)
data_pregrado <- data_unal %>%
  filter(TIPO_NIVEL == "Pregrado")

levels(data_pregrado$TIPO_NIVEL)
View(data_pregrado)

ggplot(data_pregrado, aes(x=TIPO_NIVEL, fill = TIPO_NIVEL)) +
  geom_bar( ) + scale_y_continuous(labels = label_number()) +
  scale_fill_hue(c = 40) +
  theme(legend.position="none")  

summary(data_pregrado$PTOTAL)


## Removing negative, 0 or null values in PTOTAL as we're assuming these values are not valid for our study


clean_data <- data_pregrado %>%
  filter(
    !is.na(PTOTAL),
    PTOTAL > 0
  )
summary(clean_data$PTOTAL)

number_of_rows <- nrow(clean_data)

## Plot using Sturges Rule 
# bin width = 1 + 3.322log10(n)

sturges_bin_width <- round(1 + 3.322*(log10(number_of_rows)), digits = 0)

ggplot(clean_data, aes(x = PTOTAL)) +
  geom_histogram(
    bins = sturges_bin_width,      # Adjust number of bins
    fill = "skyblue",              # Bar color
    color = "black",               # Border color
    alpha = 0.7                    # Transparency (0-1)
  ) +
  labs(
    title = "Distribution of Admission Test Scores",
    x = "Test Score",
    y = "Frequency"
  ) +
  theme_minimal()     

## Plot using Freedman-Diaconis Rule 
# bin width = 2*IQR(x)/n^1/3

iqr_value <- IQR(clean_data$PTOTAL)

bin_width <- 2 * iqr_value / (number_of_rows^(1/3))

ggplot(clean_data, aes(x = PTOTAL)) +
  geom_histogram(
    binwidth = bin_width,      # Use calculated bin width
    fill = "steelblue",
    color = "white"
  ) +
  labs(
    title = "Admission Test Scores (Freedman-Diaconis Bins)",
    x = "Score",
    y = "Frequency"
  ) +
  theme_minimal()

## boxplot


ggplot(clean_data, aes(y = PTOTAL)) +
  geom_boxplot(
    fill = "#69b3a2",
    color = "#2c728e",
    outlier.color = "#bf2c2c"
  ) +
  labs(
    title = "Admission Test Scores Distribution",
    y = "Score"
  ) +
  theme_bw() +  # Black-and-white theme
  theme(
    axis.title.x = element_blank(),  # Remove unused x-axis label
    plot.title = element_text(hjust = 0.5)  # Center title
  )

## boxplot per year

ggplot(clean_data, aes(x = factor(YEAR), y = PTOTAL, fill = factor(YEAR))) +
  geom_boxplot() +
  scale_fill_viridis_d() +
  labs(title = "Scores by Year (colored)") +
  theme(legend.position = "none")

## boxplot per department

ggplot(clean_data, aes(x = DEP_NAC, y = PTOTAL, fill = DEP_NAC)) +
  geom_boxplot() +
  scale_fill_viridis_d() +
  labs(title = "Scores by Department (colored)") +
  theme(legend.position = "none")

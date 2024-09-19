# Load necessary libraries
library(dplyr)
library(xtable)

# Load the dataset
data <- read.csv("C:\\Users\\rcpsi\\source\\repos\\UncertaintyQuantificationForGeocodingServices\\EffectOfStorageOnCost\\tempos_tcc_sistema.csv")


# Clean the 'tempo' column by converting it to numeric (replacing commas with dots)
data$tempo <- as.numeric(gsub(",", ".", data$tempo))

# 1. operacao x sistema
summary_sistema <- data %>%
  group_by(operacao, sistema) %>%
  summarize(
    mean_tempo = mean(tempo, na.rm = TRUE),
    sd_tempo = sd(tempo, na.rm = TRUE)
  )

# 2. operacao x tabelas_temporarias
summary_tabelas_temporarias <- data %>%
  group_by(operacao, tabelas_temporarias) %>%
  summarize(
    mean_tempo = mean(tempo, na.rm = TRUE),
    sd_tempo = sd(tempo, na.rm = TRUE)
  )

# 3. operacao x views
summary_views <- data %>%
  group_by(operacao, views) %>%
  summarize(
    mean_tempo = mean(tempo, na.rm = TRUE),
    sd_tempo = sd(tempo, na.rm = TRUE)
  )

# 4. operacao == 'PERT' x variacao
summary_pert_variacao <- data %>%
  filter(operacao == 'PERT') %>%
  group_by(variacao) %>%
  summarize(
    mean_tempo = mean(tempo, na.rm = TRUE),
    sd_tempo = sd(tempo, na.rm = TRUE)
  )

# Convert each summary to a LaTeX table using xtable
latex_sistema <- xtable(summary_sistema, caption = "Operacao x Sistema (Mean and SD of Tempo)")
latex_tabelas_temporarias <- xtable(summary_tabelas_temporarias, caption = "Operacao x Tabelas Temporarias (Mean and SD of Tempo)")
latex_views <- xtable(summary_views, caption = "Operacao x Views (Mean and SD of Tempo)")
latex_pert_variacao <- xtable(summary_pert_variacao, caption = "Operacao == 'PERT' x Variacao (Mean and SD of Tempo)")

# Print LaTeX tables
print(latex_sistema, type = "latex")
print(latex_tabelas_temporarias, type = "latex")
print(latex_views, type = "latex")
print(latex_pert_variacao, type = "latex")

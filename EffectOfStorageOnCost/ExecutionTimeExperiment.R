# Load necessary libraries
library(dplyr)
library(tidyr)
library(ggplot2)
library(coin)  # For permutation tests
library(xtable)
library(RColorBrewer)  # For custom color palettes

# Load the dataset
data <- read.csv("C:\\Users\\rcpsi\\source\\repos\\UncertaintyQuantificationForGeocodingServices\\EffectOfStorageOnCost\\tempos_tcc - Página1.csv")
# Clean the dataset by converting 'tempo' to numeric and replacing commas with dots
data$tempo <- as.numeric(gsub(",", ".", data$tempo))

# Drop rows where 'tempo' is NA
data <- data %>% drop_na(tempo)

# Convert factors to categorical variables
data$index <- as.factor(data$index)
data$views <- as.factor(data$views)
data$tabelas_temporarias <- as.factor(data$tabelas_temporarias)
data$operacao <- as.factor(data$operacao)

# 1. Run a permutation test for the interaction model
print("Running permutation test (non-parametric approach).")
perm_test <- independence_test(tempo ~ index * views * tabelas_temporarias * operacao, data = data)
print(perm_test)

# Manually extract results for LaTeX output
perm_results <- data.frame(
  Statistic = statistic(perm_test),
  PValue = pvalue(perm_test)
)

# Convert results to LaTeX
perm_latex <- xtable(perm_results, caption = "Permutation Test Results for Interaction Model")
print(perm_latex, type = "latex")

# 2. Visualize the non-parametric results using Violin Plots
# Automatically generate a color palette that matches the number of levels in each factor
color_palette <- function(n) {
  brewer.pal(n, "Set3")
}

# Violin plot for Operation types
ggplot(data, aes(x = operacao, y = tempo, fill = operacao)) + 
  geom_violin(trim = FALSE, color = "black", size = 0.8) + 
  stat_summary(fun.data = "mean_sdl", fun.args = list(mult = 1), geom = "pointrange", color = "black") + 
  theme_minimal() +
  labs(title = "Effect of Operation Types on Execution Time (Non-parametric)", x = "Operation", y = "Execution Time (s)") +
  theme(legend.position = "none", text = element_text(size = 14)) +
  scale_fill_manual(values = color_palette(length(unique(data$operacao))))

# Violin plot for Index types
ggplot(data, aes(x = index, y = tempo, fill = index)) + 
  geom_violin(trim = FALSE, color = "black", size = 0.8) + 
  stat_summary(fun.data = "mean_sdl", fun.args = list(mult = 1), geom = "pointrange", color = "black") + 
  theme_minimal() +
  labs(title = "Effect of Index on Execution Time (Non-parametric)", x = "Index", y = "Execution Time (s)") +
  theme(legend.position = "none", text = element_text(size = 14)) +
  scale_fill_manual(values = color_palette(length(unique(data$index))))

# Violin plot for Views
ggplot(data, aes(x = views, y = tempo, fill = views)) + 
  geom_violin(trim = FALSE, color = "black", size = 0.8) + 
  stat_summary(fun.data = "mean_sdl", fun.args = list(mult = 1), geom = "pointrange", color = "black") + 
  theme_minimal() +
  labs(title = "Effect of Views on Execution Time (Non-parametric)", x = "Views", y = "Execution Time (s)") +
  theme(legend.position = "none", text = element_text(size = 14)) +
  scale_fill_manual(values = color_palette(length(unique(data$views))))

# Violin plot for Temporary Tables
ggplot(data, aes(x = tabelas_temporarias, y = tempo, fill = tabelas_temporarias)) + 
  geom_violin(trim = FALSE, color = "black", size = 0.8) + 
  stat_summary(fun.data = "mean_sdl", fun.args = list(mult = 1), geom = "pointrange", color = "black") + 
  theme_minimal() +
  labs(title = "Effect of Temporary Tables on Execution Time (Non-parametric)", x = "Temporary Tables", y = "Execution Time (s)") +
  theme(legend.position = "none", text = element_text(size = 14)) +
  scale_fill_manual(values = color_palette(length(unique(data$tabelas_temporarias))))

# 3. Interaction Plots

# Interaction between Index and Operation
ggplot(data, aes(x = operacao, y = tempo, group = index, color = index)) + 
  stat_summary(fun = "mean", geom = "line", size = 1.2) +
  stat_summary(fun = "mean", geom = "point", size = 3, shape = 21, fill = "white") +
  labs(title = "Interaction between Index and Operation", x = "Operation", y = "Mean Execution Time (s)") +
  theme_minimal() +
  theme(legend.position = "right", text = element_text(size = 14)) +
  scale_color_manual(values = color_palette(length(unique(data$index))))

# Interaction between Views and Operation
ggplot(data, aes(x = operacao, y = tempo, group = views, color = views)) + 
  stat_summary(fun = "mean", geom = "line", size = 1.2) +
  stat_summary(fun = "mean", geom = "point", size = 3, shape = 21, fill = "white") +
  labs(title = "Interaction between Views and Operation", x = "Operation", y = "Mean Execution Time (s)") +
  theme_minimal() +
  theme(legend.position = "right", text = element_text(size = 14)) +
  scale_color_manual(values = color_palette(length(unique(data$views))))

# Interaction between Temporary Tables and Operation
ggplot(data, aes(x = operacao, y = tempo, group = tabelas_temporarias, color = tabelas_temporarias)) + 
  stat_summary(fun = "mean", geom = "line", size = 1.2) +
  stat_summary(fun = "mean", geom = "point", size = 3, shape = 21, fill = "white") +
  labs(title = "Interaction between Temporary Tables and Operation", x = "Operation", y = "Mean Execution Time (s)") +
  theme_minimal() +
  theme(legend.position = "right", text = element_text(size = 14)) +
  scale_color_manual(values = color_palette(length(unique(data$tabelas_temporarias))))

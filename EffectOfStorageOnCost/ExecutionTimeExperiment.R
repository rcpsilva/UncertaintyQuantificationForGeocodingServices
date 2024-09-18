# Load necessary libraries
library(dplyr)
library(tidyr)
library(ggplot2)
library(coin)  # For permutation tests
library(xtable)
library(RColorBrewer)  # For custom color palettes
library(lmPerm)
options(repr.plot.width = 10, repr.plot.height = 6) 

# Load the dataset
data <- read.csv("C:\\Users\\rcpsi\\source\\repos\\UncertaintyQuantificationForGeocodingServices\\EffectOfStorageOnCost\\tempos_tcc_sistema.csv")
# Clean the dataset by converting 'tempo' to numeric and replacing commas with dots
data$tempo <- as.numeric(gsub(",", ".", data$tempo))

# Drop rows where 'tempo' is NA
data <- data %>% drop_na(tempo)

# Convert factors to categorical variables
data$index <- as.factor(data$index)
data$views <- as.factor(data$views)
data$tabelas_temporarias <- as.factor(data$tabelas_temporarias)
data$operacao <- as.factor(data$operacao)


#perm_anova <- aovp(tempo ~ index * tabelas_temporarias * operacao + iteracao, data = data)

#summary(perm_anova)

# Extract the ANOVA table from the summary object
#anova_table <- summary_perm_anova[[1]]

# Convert the ANOVA table to a data frame
#anova_df <- as.data.frame(anova_table)

# Use xtable to convert the data frame to LaTeX format
#latex_table <- xtable(anova_df)
#print(latex_table, type = "latex")


ggplot(data, aes(x = operacao, y = tempo, colour = sistema, fill = sistema)) + 
  geom_boxplot(position = position_dodge(width = 0.9)) +
  stat_summary(fun = median, geom = "point", shape =20, size = 3, color = "black", position = position_dodge(0.9),) +  # Add mean as a point
  theme_minimal(base_size = 16) +
  scale_y_continuous(breaks = seq(0, max(data$tempo), by = 20)) +
  scale_x_discrete(expand = c(0.05, 0.05)) +  # Adjust the space between categories
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  #


# Visualize interaction between index, views, tabelas_temporarias, and operacao
# We will use facet wrapping to visualize the interactions across different factors
ggplot(data, aes(x = operacao, y = tempo, colour = index, fill = index)) + 
  geom_boxplot(position = position_dodge(width = 0.9)) +
  stat_summary(fun = median, geom = "point", shape =20, size = 3, color = "black", position = position_dodge(0.9),) +  # Add mean as a point
  theme_minimal(base_size = 16) +
  scale_y_continuous(breaks = seq(0, max(data$tempo), by = 20)) +
  scale_x_discrete(expand = c(0.05, 0.05)) +  # Adjust the space between categories
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  #

pertinencia_data <- data %>% filter(operacao == "pertinencia")

ggplot(pertinencia_data, aes(x = operacao, y = tempo, colour = variacao, fill = variacao)) + 
  geom_boxplot(position = position_dodge(width = 0.9)) +
  stat_summary(fun = mean, geom = "point", shape =20, size = 3, color = "black", position = position_dodge(0.9),) +  # Add mean as a point
  theme_minimal(base_size = 16) +
  scale_y_continuous(breaks = seq(0, max(data$tempo), by = 20)) +
  scale_x_discrete(expand = c(0.05, 0.05)) +  # Adjust the space between categories
  theme(axis.text.x = element_text(angle = 0, hjust = 0.5))  #

ggplot(data, aes(x = operacao, y = tempo, colour = views, fill = views)) + 
  geom_boxplot(position = position_dodge(width = 0.9)) +
  stat_summary(fun = mean, geom = "point", shape =20, size = 3, color = "black", position = position_dodge(0.9),) +  # Add mean as a point
  theme_minimal(base_size = 16) +
  scale_y_continuous(breaks = seq(0, max(data$tempo), by = 20)) +
  scale_x_discrete(expand = c(0.05, 0.05)) +  # Adjust the space between categories
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  #

ggplot(data, aes(x = operacao, y = tempo, colour = tabelas_temporarias, fill = tabelas_temporarias)) + 
  geom_boxplot(position = position_dodge(width = 0.9)) +
  stat_summary(fun = mean, geom = "point", shape =20, size = 3, color = "black", position = position_dodge(0.9),) +  # Add mean as a point
  theme_minimal(base_size = 16) +
  scale_y_continuous(breaks = seq(0, max(data$tempo), by = 20)) +
  scale_x_discrete(expand = c(0.05, 0.05)) +  # Adjust the space between categories
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  #


no_disjoint_data <- data %>% 
  filter(operacao == "pertinencia" & variacao != "ST_disjoint")

ggplot(no_disjoint_data, aes(x = operacao, y = tempo, colour = index, fill = index)) + 
  geom_boxplot(position = position_dodge(width = 0.9)) +
  stat_summary(fun = mean, geom = "point", shape =20, size = 3, color = "black", position = position_dodge(0.9),) +  # Add mean as a point
  theme_minimal(base_size = 16) +
  scale_y_continuous(breaks = seq(0, max(data$tempo), by = 20)) +
  scale_x_discrete(expand = c(0.05, 0.05)) +  # Adjust the space between categories
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  #

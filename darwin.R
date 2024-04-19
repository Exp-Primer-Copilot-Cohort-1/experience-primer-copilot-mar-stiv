install.packages("vcd")
library(vcd)
install.packages(ggplot2)
library(ggplot2)

expected <- c(1/3, 2/3)

observedLight <- c(170,380)
totalLight <- sum(observedLight)


#Then run this code for all your factors. 
#(242,151,28,111,5)
#(94,176,87,115,44,146,13,9,7,40)
observedHeat <- c(537,731)
totalHeat <- sum(observedHeat)

#(222,499,204,56,17)
#(9,5,10,54,336,19,26,0,158,7)
observedLandmark <- c(998,624)
totalLandmark <- sum(observedLandmark)


#(1,18,18,16,9)
#(2,109,19,19,7,1,15,20,35,14)
observedWind <- c(62,241)
totalWind <- sum(observedWind)


#(40,2,1)
#(18,7,1,1,0,3)
observedMagnetism <- c(43,30)
totalMagnetism <- sum(observedMagnetism)



# Assuming you have all your observed and expected data defined

# Combine categories (already defined)
categories <- c("Light", "Heat", "Landmark", "Wind", "Magnetism")

# Combine observed data
all_observed <- c(observedLight[1], observedHeat[1], observedLandmark[1], observedWind[1], observedMagnetism[1],
                  observedLight[2], observedHeat[2], observedLandmark[2], observedWind[2], observedMagnetism[2])

# Combine expected data (assuming same proportion for all categories)
expected <- c(1/3, 2/3)
all_expected <- c(totalLight * expected[1], totalHeat * expected[1], totalLandmark * expected[1], 
                  totalWind * expected[1], totalMagnetism * expected[1],
                  totalLight * expected[2], totalHeat * expected[2], totalLandmark * expected[2], 
                  totalWind * expected[2], totalMagnetism * expected[2])

# Data frame (reshape to create separate entries for observed/expected)
data <- data.frame(
  Category = rep(categories, each = 2),
  Feeding = rep(c("Fed", "Unfed"), times = length(categories)),
  Value = c(all_observed, all_expected),  # Combine observed and expected
  Type = rep(c("Observed", "Expected"), each = length(categories))
)

  # Grouped bar chart with stacked bars for observed and expected
  ggplot(data, aes(x = Category, y = Value, fill = Feeding)) +
    geom_col(position = position_dodge(width = 0.9), width = 0.8, alpha = 0.5, color = "black") +
    labs(fill = "Type", y = "Number of Ants") +
    scale_fill_manual(values = c("blue", "red"), 
                      guide = guide_legend(override.aes = list(alpha = c(0.5, 0.5))))

# Display the plot
ggsave("observed_vs_expected_grouped.png", width = 8, height = 6)  # Save the plot (optional)
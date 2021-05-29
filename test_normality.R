# Input: frequency table
# Computes informative statistics and determines whether 
# points are normally distributed using Shapiro-Wilk

library(moments)
library(ggplot2)

df <- read.csv("file.csv") # Replace with the path to frequency table
# The table should have the values in the first column and frequencies in second.
# In this format, convert to a numeric vector
v <- rep(df[, 1], df[, 2])

## Creating informative plots

# Start with a histogram
ggplot(df, aes(x = factor(df[, 1]),y = df[, 2])) + geom_col() + xlab("Size") + 
    ylab("Counts")

# Generate Q-Q Plot
qqnorm(v)

# Add Q-Q Line
qqline(v, lwd = 2)
# Function to compute first five moments
moments <- function(x) {
    return(list("Mean" = mean(x), "Median" = median(x), "SD" = sd(x), 
                "Skew" = skewness(x), "Kurtosis" = kurtosis(x)))
}
m <- moments(v)
# Perform Shapiro Test
# If p < alpha, may be non normal distro
shapiro.test(v)

# Large number of samples may bias the p-value
# Check number of samples
length(v)
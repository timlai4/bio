############
# Given a table of paired-ended reads from diploid cells
# Performs a chi-squared test on the number of reads from each allele
# Determines whether the reads are statistically significantly (un)balanced.
############

library(tidyr)

# Read in df
df <- read.csv("example.tsv", header = TRUE, stringsAsFactors = FALSE, sep = '\t')

# Separate dp4 into four columns 
df <- separate(data = df, col = dp4, into = c("f1", "r1", "f2", "r2"), sep = ",")

# Convert to numerical values
df$f1 <- as.numeric(df$f1)
df$f2 <- as.numeric(df$f2)
df$r1 <- as.numeric(df$r1)
df$r2 <- as.numeric(df$r2)

# Compute sum of paired end reads to get one variable per allele
df$first <- df$f1 + df$r1
df$second <- df$f2 + df$r2

# Compute the chi squared value
df$chisq <- (df$first - df$depth / 2)^2 / (df$depth / 2) + 
    (df$second - df$depth / 2)^2 / (df$depth / 2)

# Test Null hypothesis with df = 1
df$result <- ifelse(df$chisq >= 3.84, "Unbalanced", "Balanced")
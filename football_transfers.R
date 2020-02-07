# Import the necessary packages
library(dplyr)
library(ggplot2)

# Import our data. Note, this data is in my current R project directory
transfers <- read.csv("footballvalues.csv", header = TRUE)

# Drop the first column that was added when CSV imported
transfers[1] <- NULL

# View a sample of the data to see what we are working with
head(transfers)

# Print quick summary statistics of the 'Value' category, which we are using as a proxy for transfer fee
summary(transfers['Value'])

# Group the data by position, and view counts by position
pos_group <- group_by(transfers, Position)
summarise(pos_group, Count = n())

# View the average (mean) transfer value of each position
pos_df <- summarise(pos_group, Avg_Value = mean(Value))
pos_df

# Lastly, we can visualise the distributions with boxplots.
# Plots are ordered by highest average value to lowest, showing that forwards (LF, RF, and LS) have the highest valuations while defensive positions (RB, LB, and CB) have the lowest.

ggplot(transfers, aes(x = reorder(Position, Value, FUN = mean), y = Value)) +
  geom_boxplot() +
  xlab("Position") +
  ylab("Fee/Value ($ Million)") +
  ggtitle("Transfer Fee/Value")

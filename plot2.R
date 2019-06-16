" 
        Script to create plot2.png (A time series for Global Active Power)
"
library(dplyr)

# Read Data from File as per the specifics provided in the Instructions
df <- read.csv("household_power_consumption.txt", sep = ";",as.is = TRUE, na.strings = "?")

# Convert to Tibble for convenience
df <- tbl_df(df)

# First convert df$Time to time (POSIXlt) format (chose to concatenate with the relevant Date for the sake of accuracy)
df$Time <- strptime(paste(df$Date,df$Time), "%d/%m/%Y %T")

# Then, convert df$Date to Date format
df$Date <- as.Date(df$Date, "%d/%m/%Y")

# Subset the data to only include 1/2/07 and 2/2/07
set <- subset(df, df$Date == as.Date("2007-02-01") | df$Date == as.Date("2007-02-02"))

# Set the chart grid to 1x1
par(mfrow = c(1,1))

# Create a time series chart of GA Power
plot(set$Time, set$Global_active_power, type = "S", ylab = "Global Active Power (kilowatts)", xlab = "")

# Copy it to a png file and save it (default size is 480x480)
dev.copy(png, file = "plot2.png")
dev.off()
" 
        Script to create plot3.png (Time series for sub metering corresponding to 3 different categories)
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

# Set up plotting area based on sub_metering_1 because it has the largest range of values for ESM
plot(set$Time, set$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")

# Superimpose 3 plots on the chart
lines(set$Time, set$Sub_metering_1, type = "s")
lines(set$Time, set$Sub_metering_2, type = "s", col="red")
lines(set$Time, set$Sub_metering_3, type = "s", col="blue")

#Create Legend
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd = c(1,1,1))

# Copy it to a png file and save it (default size is 480x480)
dev.copy(png, file = "plot3.png")
dev.off()
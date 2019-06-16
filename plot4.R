" 
        Script to create plot4.png (Four time series plots of varying quantities)
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

# Set the chart grid to 2x2
par(mfrow = c(2,2))

# Plot the charts, adding relevant attributes and annotations one by one
plot(set$Time, set$Global_active_power, ylab = "Global Active Power", xlab = "", type = "l")                    #1
plot(set$Time, set$Voltage, ylab = "Voltage", type = "l", xlab = "datetime")                         #2
plot(set$Time, set$Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "n")                         #3
lines(set$Time, set$Sub_metering_1, type = "s")
lines(set$Time, set$Sub_metering_2, type = "s", col="red")
lines(set$Time, set$Sub_metering_3, type = "s", col="blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lwd = c(1,1,1), cex = 0.6, box.lwd = 0)
plot(set$Time, set$Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", type = "l")        #4

# Copy it to a png file and save it (default size is 480x480)
dev.copy(png, file = "plot4.png")
dev.off()

# Exploratory Data Analysis
#   Course Project 1 - Plot 4

# This script places its output in the current working directory and
# uses data stored in the data sub-directory of the working directory.

if (!file.exists("data")) {
    dir.create("data")
}

if (!file.exists("./data/exdata-data-household_power_consumption.zip")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip"
    download.file(fileUrl, destfile = "./data/exdata-data-household_power_consumption.zip", method = "curl")
}

if (!file.exists("./data/household_power_consumption.txt")) {
    unzip("./data/exdata-data-household_power_consumption.zip", exdir ="./data")
}

powerFile <- "./data/household_power_consumption.txt"
powerRaw <- read.table(powerFile, header=T, sep=";", na.strings="?")

# Reduce data set to rows for the desired days
twoDays <- subset(powerRaw, 
                    (as.Date(powerRaw$Date,format="%d/%m/%Y") == "2007-02-01" | 
                     as.Date(powerRaw$Date,format="%d/%m/%Y") == "2007-02-02"))

# Combine the Date and Time columns into a single list
datetime <- strptime( paste(twoDays$Date,twoDays$Time), format="%d/%m/%Y %H:%M:%S")

# Setup 2x2 matrix for displaying 4 plots
par(mfcol = c(2,2), mar = c(4, 4, 2, 1), oma = c(1, 1, 1, 0))
with(twoDays, {
    #1st plot
    plot(datetime, Global_active_power,
         type="l",
         xlab="",
         ylab="Global Active Power")
    #2nd plot
    plot(datetime, Sub_metering_1,
         type="l",
         xlab="",
         ylab="Energy sub metering")
    lines(datetime, twoDays$Sub_metering_2, col="red")
    lines(datetime, twoDays$Sub_metering_3, col="blue")
    legend("topright", bty="n", cex=0.75, lwd=2, 
        col = c("black","red","blue"), 
        legend = c("Sub_metering_1 ","Sub_metering_2 ","Sub_metering_3 "))
    #3rd plot
    plot(datetime, Voltage,
         type="l",
         xlab="datetime",
         ylab="Voltage")
    #4th plot
    plot(datetime, Global_reactive_power,
         type="l",
         xlab="datetime",
         ylab="Global_reactive_power")  
      })

# Copy the plot to a PNG file
dev.copy(png, file = "plot4.png", width=480, height=480, units="px") 
dev.off()


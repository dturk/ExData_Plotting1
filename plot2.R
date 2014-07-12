# Exploratory Data Analysis
#   Course Project 1 - Plot 2

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
# Plot using concatenated datetime
with(twoDays, plot(datetime, Global_active_power,
                   type="l",
                   xlab="",
                   ylab="Global Active Power (kilowatts)"))

# Copy the plot to a PNG file
dev.copy(png, file = "plot2.png", width=480, height=480, units="px") 
dev.off()


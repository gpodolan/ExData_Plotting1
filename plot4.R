library(data.table)
library(lubridate)

## Check if files exist, download and unzip
if(!file.exists("household_power_consumption.zip")){ 
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "household_power_consumption.txt")
    file <- unzip(zipfile = "household_power_consumption.zip", files = "household_power_consumption.txt", overwrite = T)
}

## Load data into R and convert dates to Date format
powerConsumption <- fread(file, na.strings = "?")
powerConsumption$Date <- dmy(powerConsumption$Date)

## Select relevant data and generate DateTime column in POSIXct formathead
relevantData <- powerConsumption[powerConsumption$Date >= "2007-02-01" & Date <= "2007-02-02",]
relevantData <- mutate(relevantData, DateTime = as.POSIXct(paste(relevantData$Date, relevantData$Time)))

## Create the device, write the plot and close the device
png(filename = "plot4.png")
par(mfcol = c(2,2))
plot(relevantData$DateTime, relevantData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
with(relevantData, plot(DateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(relevantData, lines(Sub_metering_2 ~ DateTime, type = "l", col = "red"))
with(relevantData, lines(Sub_metering_3 ~ DateTime, type = "l", col = "blue"))
legend("topright", legend = names(relevantData)[grepl("^Sub_", names(relevantData))], col = c("black", "red", "blue"), lty = c(1, 1, 1))
with(relevantData, plot(DateTime, Voltage, xlab = "datetime", ylab = "Voltage", type = "l"))
with(relevantData, plot(DateTime, Global_reactive_power, xlab = "datetime", type = "l"))
dev.off()

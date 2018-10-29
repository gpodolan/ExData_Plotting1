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

## Select relevant data
relevantData <- powerConsumption[powerConsumption$Date >= "2007-02-01" & Date <= "2007-02-02",]

## Create the device, write the plot and close the device
png(filename = "plot1.png")
hist(relevantData$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()

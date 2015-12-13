## plot2.R - Histogram of Global Active Power
## Output: plot2.png

## Obtain data from source
## it requires 20MB memory and internet connection
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), 
                   sep=';', header=TRUE, 
                   colClasses = c('character', 'character', 'numeric',
                                  'numeric', 'numeric', 'numeric',
                                  'numeric', 'numeric', 'numeric'),
                   na.strings='?')
unlink(temp)

## Complete clean and tidy data
message("Processing data")
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
data <- subset(data, as.Date(DateTime) >= as.Date("2007-02-01") & as.Date(DateTime) <= as.Date("2007-02-02"))

## Generate plot
message("Creating plot")	
png(filename = "plot2.png", width = 480, height = 480, units = "px", bg = "white")

plot(data$DateTime, data$Global_active_power, type = "l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()
message("Plot saved")
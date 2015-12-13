## plot4.R - 4 plots
## Output: plot4.png


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
png(filename="plot4.png", width=480, height=480, units = "px", bg = "white")
par(mfrow=c(2,2))

##from plot2
plot(data$DateTime, data$Global_active_power, type = "l", xlab="", ylab="Global Active Power (kilowatts)")


plot(data$Voltage, type="l", xlab="datetime", xaxt="n", ylab="Voltage")
axis(1, at=c(1,1440,2880), labels=c("Thu", "Fri", "Sat"))

##from plot3
plot(data$Sub_metering_1, type="l", xlab="", xaxt="n", ylab="Energy sub metering")
lines(data$Sub_metering_2, col="red")
lines(data$Sub_metering_3, col="blue")
axis(1, at=c(1,1440,2880), labels=c("Thu", "Fri", "Sat"))
legend("topright", lty=1, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"))


plot(data$Global_reactive_power, type="l", xlab="datetime", xaxt="n", ylab="Global_reactive_power")
axis(1, at=c(1,1440,2880), labels=c("Thu", "Fri", "Sat"))

dev.off()
message("Plot saved")

## plot3.R - Energy Sub metering
## Output: plot3.png


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
png(filename = "plot3.png", width = 480, height = 480, units = "px", bg = "white")

plot(data$Sub_metering_1, type="l", xlab="", xaxt="n", ylab="Energy sub metering")
lines(data$Sub_metering_2, col="red")
lines(data$Sub_metering_3, col="blue")
axis(1, at=c(1,1440,2880), labels=c("Thu", "Fri", "Sat"))
legend("topright", lty=1, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"))
dev.off()
message("Plot saved")
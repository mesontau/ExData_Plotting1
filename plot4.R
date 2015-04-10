rm(list=ls())
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "household_power_consumption.zip"
datafile <- "household_power_consumption.txt"

if(!file.exists(datafile)){
    download.file(url = url, dest = destfile, method ="curl")
    unzip(destfile)    
}


#get header names
epc.header <- names(read.table(file = datafile, header = T, nrows = 1, sep = ";"))

# Read data between 2007-02-01 and 2007-02-02
epc <- read.table(file = datafile,col.names = epc.header, 
                  sep = ";",
                  na.strings="?",
                  skip=66637,
                  nrows= 2880,
                  colClasses = c("character", "character", "numeric", 
                                 "numeric", "numeric", "numeric",
                                 "numeric", "numeric", "numeric")) 

epc$timestamp = as.POSIXct(paste(epc$Date, epc$Time), format="%d/%m/%Y %H:%M:%S")

###################################################################################
# Plot4


png(filename = "plot4.png", width = 480, height = 480)

par(mfcol = c(2,2))

#plot4.1
plot(epc$timestamp,epc$Global_active_power, type = "l", 
     ylab = "Global Active Power", 
     xlab = "") 

#plot4.2
plot(epc$timestamp, epc$Sub_metering_1, type = "l", 
     ylab = "Energy sub metering", 
     xlab = "") 
lines(epc$timestamp, epc$Sub_metering_2, col="red")
lines(epc$timestamp, epc$Sub_metering_3, col="blue")
legend("topright",
       lty = rep(1,3), bty = "n",
       col = c("black", "red", "blue") , 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#plot4.3
plot(epc$timestamp, epc$Voltage, type = "l", 
     ylab = "Voltage", xlab = "datetime")

#plot4.4
plot(epc$timestamp, epc$Global_reactive_power, type = "l", 
     ylab = "Global_reactive_power", xlab = "datetime")

dev.off()

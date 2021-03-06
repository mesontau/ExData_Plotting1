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
# Plot1

png(filename = "plot1.png", width = 480, height = 480)

hist(epc$Global_active_power, col="red", 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

dev.off()

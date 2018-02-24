library("data.table")

#import data 
powerDT <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

#change the types
powerDT$Global_active_power <- as.numeric(powerDT$Global_active_power)
powerDT$Global_reactive_power <- as.numeric(powerDT$Global_reactive_power)
powerDT$Voltage <- as.numeric(powerDT$Voltage)
powerDT$Global_intensity <- as.numeric(powerDT$Global_intensity)
powerDT$Sub_metering_1 <- as.numeric(powerDT$Sub_metering_1)
powerDT$Sub_metering_2 <- as.numeric(powerDT$Sub_metering_2)
powerDT$Sub_metering_3 <- as.numeric(powerDT$Sub_metering_3)

powerDT[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

#subset data
powerDT <- powerDT[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot2.png", width=480, height=480)

#plotting
plot(x = powerDT[, dateTime]
     , y = powerDT[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()
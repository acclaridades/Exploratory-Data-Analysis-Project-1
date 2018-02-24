library("data.table")

powerDT <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

powerDT[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

powerDT$Global_active_power <- as.numeric(powerDT$Global_active_power)
powerDT$Global_reactive_power <- as.numeric(powerDT$Global_reactive_power)
powerDT$Voltage <- as.numeric(powerDT$Voltage)
powerDT$Global_intensity <- as.numeric(powerDT$Global_intensity)
powerDT$Sub_metering_1 <- as.numeric(powerDT$Sub_metering_1)
powerDT$Sub_metering_2 <- as.numeric(powerDT$Sub_metering_2)
powerDT$Sub_metering_3 <- as.numeric(powerDT$Sub_metering_3)

powerDT <- powerDT[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot4.png", width=480, height=480)

#plotting
par(mfrow=c(2,2))

plot(powerDT[, dateTime], powerDT[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

plot(powerDT[, dateTime],powerDT[, Voltage], type="l", xlab="datetime", ylab="Voltage")

plot(powerDT[, dateTime], powerDT[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(powerDT[, dateTime], powerDT[, Sub_metering_2], col="red")
lines(powerDT[, dateTime], powerDT[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

plot(powerDT[, dateTime], powerDT[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
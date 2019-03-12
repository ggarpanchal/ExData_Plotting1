file_name <- "household_power_consumption.zip"

if (!file.exists(file_name)){
  URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip "
  download.file( URL, file_name, method= "curl" )
}  
if (!file.exists("household_power_consumption.txt")) { 
  unzip(file_name) 
}

power_c_df <- data.table::fread("household_power_consumption.txt")
trim_df <- (dplyr::filter(power_c_df, Date == "1/2/2007"| Date == "2/2/2007" ))
trim_df$Global_active_power <- as.numeric(trim_df$Global_active_power)
trim_df$timedate <- lubridate::dmy(trim_df$Date) + lubridate::hms(trim_df$Time)
 
png( filename = "plot4.png", bg = "transparent", width = 480, height = 480)
par(mfcol = c(2,2))

plot( trim_df$timedate, trim_df$Global_active_power, type = "l", xlab = NA, 
     ylab = "Global Active Power (kilowatts)")
plot( trim_df$timedate, trim_df$Sub_metering_1 , type = "l", ylab = "Energy sub metering", xlab = NA)
points(trim_df$timedate, trim_df$Sub_metering_2, col= "Red",type = "l")
points(trim_df$timedate, trim_df$Sub_metering_3, col= "Blue",type = "l")
legend("topright",  col = c("black", "Red", "Blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd = 2)
plot(trim_df$timedate, trim_df$Voltage, type = "l", ylab = "Voltage", xlab = "Datetime")
plot(trim_df$timedate, trim_df$Global_reactive_power, type = "l", ylab = "Global reactive power", xlab = "Datetime")
dev.off()

file_name <- "household_power_consumption.zip"

if (!file.exists(file_name)){
  URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file( URL, file_name, method= "curl" )
}  
if (!file.exists("household_power_consumption.txt")) { 
  unzip(file_name) 
}

# Load whole data frame to variable "power_c_df"
power_c_df <- data.table::fread("household_power_consumption.txt")

# Fatch "1/2/2007" & "2/2/2007" day from data frame and store in "trim_df"
trim_df <- (dplyr::filter(power_c_df, Date == "1/2/2007"| Date == "2/2/2007" ))
trim_df$Global_active_power <- as.numeric(trim_df$Global_active_power)

# "plot1.png" named png file graphic device ON
png(filename = "plot3.png", bg = "transparent", width = 480, height = 480)

with(trim_df, plot( timedate,Sub_metering_1 , type = "l", 
                     ylab = "Energy sub metering", xlab = NA))
with(trim_df, points(timedate,Sub_metering_2, col= "Red",type = "l"))
with(trim_df, points(timedate,Sub_metering_3, col= "Blue",type = "l"))
legend("topright",  col = c("black", "Red", "Blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd = 2)
dev.off()

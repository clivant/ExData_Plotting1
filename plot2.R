# Read only the required data to speed things up, assuming that data file is located in the working directory
data <- read.table(file='household_power_consumption.txt'
                   , header = TRUE
                   , sep = ';'
                   , skip = 66636
                   , nrows = 2880
                   , col.names = c(
                     'Date', 'Time', 'Global_active_power'
                     , 'Global_reactive_power', 'Voltage'
                     , 'Global_intensity', 'Sub_metering_1'
                     , 'Sub_metering_2', 'Sub_metering_3'
                   )
                   , colClasses= c(
                     'character', 'character', 'numeric'
                     , 'numeric', 'numeric', 'numeric'
                     , 'numeric', 'numeric', 'numeric'
                   )
)

# Merge the date and time columns into a new one with a time type
dateTimeStrings <- character()
for (i in 1:2880) {
  dateTimeStrings <- c(dateTimeStrings, paste(data$Date[i], data$Time[i])) 
}
data$DateTime <- strptime(dateTimeStrings, format="%d/%m/%Y %H:%M:%S")

# Plot graph
png('plot2.png', height = 480, width = 480)
plot(x = data$DateTime, y = data$Global_active_power, type = 'l', xlab = '', ylab = 'Global Active Power (kilowatts)')
dev.off()
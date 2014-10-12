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

# Plot graph 
png('plot1.png', height = 480, width = 480)
hist(data$Global_active_power, xlab = 'Global Active Power (kilowatts)', col='red')
dev.off()


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

#Plot graph
png(file = 'plot3.png', height = 450, width = 450)

# Start the initial plot and plot sub metering 1 against date time
plot(x = data$DateTime, y = data$Sub_metering_1, xlab = '', ylab = 'Energy sub metering', type = 'l')
# Plot sub metering 2 against date time
lines(x = data$DateTime, y = data$Sub_metering_2, col = 'red')
# Plot sub metering 3 against date time
lines(x = data$DateTime, y = data$Sub_metering_3, col = 'blue')

#Add the legend
legend(x= "topright", y=0.92, legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3') ,  
      lty=c(1, 1, 1), # Use lines as the symbols
      lwd=c(1, 1, 1), # set 2.5 to the symbols widths
      col=c('black', 'red','blue')) # gives the legend lines the correct color and width

dev.off()
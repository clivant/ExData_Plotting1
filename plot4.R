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

png(file = 'plot4.png', height = 480, width = 480)

# Set the graphics device to accept 4 plots, 2 by 2
par(mfrow = c(2, 2))

############# Plot (1, 1): line graph for global active power against date time #############

plot(x = data$DateTime, y = data$Global_active_power, type = 'l', xlab = '', ylab = 'Global Active Power')

############# End plot (1, 1) #############

############# Plot (1, 2): line graph for voltage against date time #############

plot(x = data$DateTime, y = data$Voltage, type = 'l', xlab = 'datetime', ylab = 'Voltage')

############# End plot (1, 2) #############

############# Plot (2, 1):  line graph for Energy sub metering against date time #############

# Start the initial plot and plot sub metering 1 against date time
plot(x = data$DateTime, y = data$Sub_metering_1, xlab = '', ylab = 'Energy sub metering', type = 'l')
# Plot sub metering 2 against date time
lines(x = data$DateTime, y = data$Sub_metering_2, col = 'red')
# Plot sub metering 3 against date time
lines(x = data$DateTime, y = data$Sub_metering_3, col = 'blue')

#Add the legend
legend(
         x = "topright"
       , y = 0.92
       , cex = 0.9
       , box.lwd = NA
       , legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3')   
       , lty=c(1, 1, 1) # Use lines as the symbols
       , lwd=c(1, 1, 1) # set 2.5 to the symbols widths
       , col=c('black', 'red','blue') # gives the legend lines the correct color and width
       ) 

# Draw back a box for the plot, which is being damaged by removal of lines for the legend
box(which = 'plot')

############# End plot (2, 1) #############

############# Plot (2, 2) ; line graph for Global_reactive_power against date time #############

plot(x = data$DateTime, y = data$Global_reactive_power, xlab = 'datetime', ylab='Global_reactive_power', type = 'l')

############# End plot (2, 2) #############

dev.off()

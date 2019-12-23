## Extracting the file.
if(file.exists("exdata_data_household_power_consumption.zip")) {
  unzip("exdata_data_household_power_consumption.zip")
  setwd("Project1")
}

library(data.table)

## Reading the file.
power_data = fread("household_power_consumption.txt", header=TRUE, sep=";",
                   stringsAsFactors=FALSE, dec=".")

## Subsetting the file.
power_subdata = subset(power_data, power_data$Date == "1/2/2007" |
                      power_data$Date == "2/2/2007")

## Creating new variable that accounts for time in the day.
DateTime = strptime(paste(power_subdata$Date, power_subdata$Time, sep = " "),
                    "%d/%m/%Y %H:%M:%S")

## Converting variables to numeric format.
Sub_Metering_1 = as.numeric(as.character(power_subdata$Sub_metering_1))
Sub_Metering_2 = as.numeric(as.character(power_subdata$Sub_metering_2))
Sub_Metering_3 = as.numeric(as.character(power_subdata$Sub_metering_3))

## Plotting.
png("plot3.png", width=480, height=480) ## Start PNG file
plot(DateTime, Sub_Metering_1, xlab = "", ylab = "Energy sub metering", type ="l")

## Annotating lines Met2 and Met3.
lines(DateTime, Sub_Metering_2, type = "l", col = "red")
lines(DateTime, Sub_Metering_3, type = "l", col = "blue")

## Annotating legend
legend("topright", c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"),
      col = c("black", "red", "blue"),cex = 0.6, lty= 1, lwd = 2.5)

dev.off() ## Close PNG file
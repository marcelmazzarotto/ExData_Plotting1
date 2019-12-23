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

## Plotting
png("plot2.png", width=480, height=480) ## Start PNG file
GlobalActivePower = as.numeric(as.character(power_subdata$Global_active_power))
plot(DateTime, GlobalActivePower, type="l",  xlab="", ylab = "Global Active Power (kilowatts)")

dev.off() ## Close PNG file

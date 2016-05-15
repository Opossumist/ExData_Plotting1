# Check for necessary files and packages, and download and load if needed
if (!file.exists("household_power_consumption.txt")) {
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url, data.zip, method = "curl")
  unzip (data.zip)}
if (!library(lubridate, logical.return = TRUE)){
  install.packages("lubridate")
  library(lubridate)}

# Load the data into a table, and subset the appropriate dates
dat <- read.csv2("household_power_consumption.txt",
                 na.strings = "?",
                 dec = ".",
                 colClasses = c("character", "character", rep("numeric", 7)))
dat$Date <- as.Date(dat$Date, format = "%d/%m/%Y")
dat <- subset(dat, ("2007-02-01"<=dat$Date & dat$Date<="2007-02-02"))

# Combine the date and time columns
dat$Time <- ymd_hms(paste(as.character(dat$Date), dat$Time, sep = " "))
dat$Date <- NULL

# Plot the appropriate information
png("plot3.png")
plot(dat$Time, 
     dat$Sub_metering_1, 
     pch = NA,
     xlab = NA,
     ylab = "Energy sub metering")
lines(dat$Time, 
      dat$Sub_metering_1)
lines(dat$Time, 
      dat$Sub_metering_2,
      col = "red")
lines(dat$Time, 
      dat$Sub_metering_3,
      col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, 
       col = c("black", "red", "blue"))

dev.off()
rm(dat)

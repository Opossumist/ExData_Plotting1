# Check for necessary files and packages, and download and load if needed
if (!file.exists("household_power_consumption.txt")) {
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url, data.zip, method = "curl")
  unzip (data.zip)}

# Load the data into a table, and subset the appropriate dates
dat <- read.csv2("household_power_consumption.txt",
                 na.strings = "?",
                 dec = ".",
                 colClasses = c("character", "character", rep("numeric", 7)))
dat$Date <- as.Date(dat$Date, format = "%d/%m/%Y")
dat <- subset(dat, ("2007-02-01"<=dat$Date & dat$Date<="2007-02-02"))

# Open the device, plot the graph, and close the device.
png("plot1.png")
hist(dat$Global_active_power,
     col = "red", 
     xlim = c(0,7), 
     ylim = c(0,1200), 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     axes = FALSE)
axis(side=1, at = c(0,2,4,6))
axis(side=2, at = c(0,200,400,600,800,1000,1200))
dev.off()
rm(dat)
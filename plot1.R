plot1 <- function() {
## Load from 1/2/2007 (DD/MM/YYYY)
house <- read.table("household_power_consumption.txt", sep = ";", skip = grep("1/2/2007", readLines("household_power_consumption.txt")))
## Convert first column to a date object
house$V1 <- as.Date(house$V1,"%d/%m/%Y")
## Convert second column to a POSXLT time object
house$V2 <- strptime(house$V2,"%H:%M:%S")
## subset house to only include values before 3/2/2007
t1 <- "3/2/2007"
house <- subset(house,V1 < as.numeric(as.Date(t1,"%d/%m/%Y")))
## Draw the histogram on the default device (screen)
hist(as.numeric(as.character(house$V3)), main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col= "red")
## Export the histogram to a .png file (default is 480x480, so we leave in the default values)
dev.copy(png, file = "plot1.png")
dev.off()
}
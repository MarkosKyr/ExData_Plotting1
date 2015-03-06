plot4 <- function() {
    ## Load from 1/2/2007 (DD/MM/YYYY)
    house <- read.table("household_power_consumption.txt", sep = ";", skip = grep("1/2/2007", readLines("household_power_consumption.txt")))
    ## Convert first column to a date object
    house$V1 <- as.Date(house$V1,"%d/%m/%Y")
    ## subset house to only include values before 3/2/2007
    t1 <- "3/2/2007"
    house <- subset(house,V1 < as.numeric(as.Date(t1,"%d/%m/%Y")))
    
    ## Convert second column to a POSXLT time object
    v1 <- as.character(house$V1)
    v2 <- as.character(house$V2)
    v3 <- paste(v1,v2)
    house$V2 <- strptime(v3,"%Y-%m-%d %H:%M:%S")   
    
    

par(mfrow = c(2,2))
with (house, {
    ## top-left graph
    plot(V2,as.numeric(as.character(V3)), type= "n", xlab = "", ylab = "Global Active Power", cex.axis = 0.7, cex.lab = 0.7)    
    lines(house$V2,as.numeric(as.character(house$V3)))
    
    ## top-right graph
    plot(V2,as.numeric(as.character(V5)), type= "n", xlab= "datetime", ylab = "Voltage", cex.axis = 0.7, cex.lab = 0.7)
    lines(house$V2,as.numeric(as.character(house$V5)), col = "black")


    ## bottom-left graph
    plot(V2,as.numeric(as.character(V9))*2, type= "n", xlab= "", ylab = "Energy sub metering", cex.axis = 0.7, cex.lab = 0.7)
    lines(house$V2,as.numeric(as.character(house$V7)), col = "black")
    lines(house$V2,as.numeric(as.character(house$V8)), col = "red")
    lines(house$V2,as.numeric(as.character(house$V9)), col = "blue")
    legend("topright", cex = 0.6,lwd = 2, pch = "", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    ## bottom-right graph
    plot(V2,as.numeric(as.character(V4)), type= "n", xlab= "datetime", ylab = "Global_reactive_power", cex.axis = 0.7, cex.lab = 0.7)
    lines(house$V2,as.numeric(as.character(house$V4)), col = "black")



})

## Export the graph to a .png file (default is 480x480, so we leave in the default values)
dev.copy(png, file = "plot4.png")
dev.off()

}
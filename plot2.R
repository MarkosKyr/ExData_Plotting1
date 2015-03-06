plot2 <- function() {
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
    ## Draw the plot on the default device (screen)
    with(house, plot(V2,as.numeric(as.character(V3)), type= "n", xlab = "", ylab = "Global Active Power (kilowatts)"))    
    ## add the lines
    lines(house$V2,as.numeric(as.character(house$V3)))
    ## Export the graph to a .png file (default is 480x480, so we leave in the default values)
    dev.copy(png, file = "plot2.png")
    dev.off()
    
}
## David Cruz Beltran
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file <- download.file(URL,destfile="C:/Users/david/Documents/PowerConsumption.zip")
unzip("./PowerConsumption.zip") 
library(dplyr)
hhpc <- read.csv("household_power_consumption.txt",header=TRUE,sep=";",na.string="?",colClass=c(rep("character",2),rep("numeric",7)))
DATE <- hhpc$Date
TIME <- hhpc$Time
Date_Time <- paste(DATE,TIME,sep=" ")
Date.Time <- strptime(Date_Time,"%d/%m/%Y %H:%M:%S")
PowerConsumption <- data.frame(Date.Time,select(hhpc, -c(Date,Time)))
#exclude <- grepl("2007-02-01",Date.Time)|grepl("2007-02-02",Date.Time)
PowerConsumption <- filter(PowerConsumption,grepl("2007-02-01",Date.Time)|grepl("2007-02-02",Date.Time))
png("plot1.png",width=480,height=480,units="px")
plot1 <- hist(PowerConsumption$Global_active_power,col="red",xlab= "Global Active Power (kilowatts)",ylab="Frequency",main="Global Active Power",breaks=12)
dev.off()


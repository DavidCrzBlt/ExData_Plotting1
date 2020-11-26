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


png("plot4.png",width=480,height=480,units="px")
par(mfrow=c(2,2))
with(PowerConsumption,{
	plot(Date.Time,Global_active_power,type="l",xlab="",ylab="Global Active Power")
	plot(Date.Time,Voltage,type="l",xlab="Datetime",ylab="Voltage")
	plot(Date.Time,Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
	lines(Date.Time,Sub_metering_2,col="red")
	lines(Date.Time,Sub_metering_3,col="blue")
	legend("topright",pch=5,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
	plot(Date.Time,Global_reactive_power,type="l")
	})
dev.off()

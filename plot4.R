#reading test tables
mydata<- read.table("./Project/household_power_consumption.txt", sep = ";", header= TRUE, na.strings = "?" )

#subseting the data
subset <- subset(mydata,mydata$Date=="1/2/2007" | mydata$Date =="2/2/2007")


library(dplyr)
library (lubridate)

#convert the date and time
subset$Date<- as.Date(subset$Date, format= "%d/%m/%Y")
subset$Time<- strptime(subset$Time, format="%H:%M:%S")
subset[1:1440,"Time"] <- format(subset[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subset[1441:2880,"Time"] <- format(subset[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

#seting device file
png(file= "plot4.png")

#making plot
par(mfcol= c(2,2)
with(subset, plot(Time, Global_active_power, type= "l", ylab= "Global Active Power (killowatts)", xlab=""))
with(subset, plot(Time, Sub_metering_1, type= "n", ylab= "Energy sub metering", xlab=""))
with(subset, lines(Time, Sub_metering_1))
with(subset, lines(Time, Sub_metering_2, col= "red"))
with(subset, lines(Time, Sub_metering_3, col= "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty= "n", cex= 0.7)
with(subset, plot(Time, Voltage, type= "l", ylab= "Voltage", xlab="datetime"))
with(subset, plot(Time, Global_reactive_power, type= "l", ylab= "Global_reactive_power", xlab="datetime"))

#closing the device
dev.off()

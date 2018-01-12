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
png(file= "plot2.png")

#making plot
with(subset, plot(Time, Global_active_power, type= "l", ylab= "Global Active Power (killowatts)", xlab=""))

#closing the device
dev.off()
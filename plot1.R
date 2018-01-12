#create a directory if not found, in which the downloded data will be stored
if(!file.exists("./Project")){dir.create("./Project")}

#data set zip Url, from where the data will be downloded
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#download the zip file
download.file(fileUrl,destfile="./Project/Dataset.zip")

# unzip the zip file to Project directory
unzip(zipfile="./Project/Dataset.zip",exdir="./Project")

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
png(file= "plot1.png")

#making histogram
hist(subset$Global_active_power, col= "red", main= "Global Active Power", xlab= "Global Active Power (killowatts)", ylab= "Frequancy")

#closing the device
dev.off()
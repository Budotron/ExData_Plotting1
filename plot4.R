#  download and extract data for electric power consumption data set, 
#  if not already present

# create directory, if not present
if (!file.exists("EDAProj1")){
        dir.create("EDAProj1")
}
library(data.table)
fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# download .zip, if not present
if (!file.exists("./EDAProj1/temp.zip")){
        download.file(url = fileURL, destfile = "./EDAProj1/temp.zip", method = "curl")
        dateDownloaded<-date() 
}
# unzip the downloaded file, and create a data table holding the information for the 
# two days to be focused on
if (!exists("powerDat")){
        file<-unzip("./EDAProj1/temp.zip")
        allPowerDat<-fread(input =file, header = T, na.strings = "?", 
                           stringsAsFactors = F )
        day1<-allPowerDat[allPowerDat$Date=="1/2/2007"]
        day2<-allPowerDat[allPowerDat$Date=="2/2/2007"]
        powerDat<-rbind(day1, day2)
}
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow=c(2,2))
with(powerDat, {
        plot(datetime, Global_active_power, type="l", xlab = "", 
             ylab = "Global Active Power")
        plot(datetime, Voltage, type = "l")
        plot (datetime, Sub_metering_1, type = "l", xlab = "", 
              ylab = "Energy sub metering")
        lines(datetime, Sub_metering_2, type = "l", col = "red")
        lines(datetime, Sub_metering_3, type = "l", col = "blue")
        legend("topright", lwd=c(2,2.5), col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
               bty = "n")
        plot(datetime, Global_reactive_power, type = "l")
})
dev.off()
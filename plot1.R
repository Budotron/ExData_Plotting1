## This code creates the first plot for the EDA course project 1

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
# create the required plot
png(file = "plot1.png", width = 480, height = 480, units = "px")
hist(x = as.numeric(powerDat$Global_active_power), 
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", col = "red")
dev.off()
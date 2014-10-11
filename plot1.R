## This code creates the first plot for the EDA course project 1

# install required packages 
library(data.table)
# function getdata() checks for the existence of a directory containing a file to 
# be downloaded, and if it is not present, downloads a linked file and stores it 
# in a directory in the current workspace. 
#
# input: a URL linked to a file to be downloaded, desired name for the 
#        directory, desired name for the downloaded file, extension for the 
#        file. 
# output : the path to the downloaded file
getdata<-function(fileUrl, dir, filename, ext){
        # create directory, if it is not already present
        dirName<-paste(dir, sep = "")
        if(!file.exists(dirName)){
                dir.create(path = dirName)
        }
        # Get the data, unless this step has already been done
        dest<-paste("./", dirName,"/", filename, ext, sep = "")
        if(!file.exists(dest)){
                download.file(url = fileUrl, destfile = dest, 
                              method = "curl") 
                datedownloaded<-date()
        }
        dest
}
fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp<-getdata(fileUrl = fileURL, 
              dir = "EDAProj1", 
              filename = "temp", 
              ext = ".zip")
file<-unzip(zipfile = temp)
allPowerDat<-fread(input =file, 
                   header = T, 
                   na.strings = "?", 
                   stringsAsFactors = F )
# obtain the days of interest, and concatenate thier infomation into a data frame 
# for analysis
day1<-allPowerDat[allPowerDat$Date=="1/2/2007"]
day2<-allPowerDat[allPowerDat$Date=="2/2/2007"]
powerDat<-rbind(day1, day2)
# create the required plot
png(file = "plot1.png", width = 480, height = 480, units = "px")
hist(x = as.numeric(powerDat$Global_active_power), 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", col = "red")
dev.off()
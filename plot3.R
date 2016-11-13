#============== drawing plot 3 ==============================
if (!require(data.table)==TRUE){
  install.packages("data.table")
  library(data.table)
}
#==============================================================================
# this block creates "in" directory in the working directory of R,downloads zip-file
#and unzip it if necessary
#==============================================================================
if (!file.exists("in")) 
{
  dir.create(file.path(getwd(),"in"))
  Url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(Url,"in/powercons.zip",method = "auto",mode = "wb")
}
if (!file.exists("in/powercons.zip"))
{
  Url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(Url,"in/powercons.zip",method = "auto",mode = "wb")
}
if (!file.exists(file.path(getwd(),"in/household_power_consumption.txt")))
  unzip("in/powercons.zip","household_power_consumption.txt",exdir = file.path(getwd(),"in/"))
#======================= end of block =========================================

df<-fread("in/household_power_consumption.txt",sep = ";",header = TRUE,na.strings="?",nrows = 5)
nam<-names(df)
df<-fread("in/household_power_consumption.txt",sep = ";",header = FALSE,na.strings="?",
          skip=66637,nrows = 2880)
names(df)<-nam
#===== "out" directory will be created if it is missing ===========================
if(!file.exists("out")) dir.create(file.path(getwd(),"out"))

png("out/plot3.png")
with(df,plot(strptime(paste(Date,Time),format = "%d/%m/%Y %H:%M:%S"),Sub_metering_1,
             type = "n",xlab = "",ylab = ""))
with(df,lines(strptime(paste(Date,Time),format = "%d/%m/%Y %H:%M:%S"),Sub_metering_1,
              type ="l"))
with(df,lines(strptime(paste(Date,Time),format = "%d/%m/%Y %H:%M:%S"),Sub_metering_2,
              col="red",type ="l"))
with(df,lines(strptime(paste(Date,Time),format = "%d/%m/%Y %H:%M:%S"),Sub_metering_3,
              col="blue",type ="l"))
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                             col=c("black","red","blue"),lty=1)
dev.off()
print("Plot 3 is done.")
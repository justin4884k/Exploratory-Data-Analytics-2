#Libraries for the file
library(dplyr)
library(ggplot2)
#Download and unzip the files
file.dwnload <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
fle <- "project.zip"
download.file(file.dwnload,fle,method = "auto")
unzip(fle)
#Read the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

ttl_emissions <- summarise(group_by(NEI,year),Emissions=sum(Emissions))
clr <- c("red","green","blue","yellow")
x1 <- barplot(height = ttl_emissions$Emissions/1000, names.arg = ttl_emissions$year,xlab = "years",ylab = expression('total PM'[2.5]*' emission in kilotons'),
              ylim=c(0,8000),main=expression('Total PM'[2.5]* ' emissions at various years in kilotons'),col=clr)
text(x=x1, y= round(ttl_emissions$Emissions/1000,2),label = round(ttl_emissions$Emissions/1000,2),pos = 3,cex = 0.8,col = "black")
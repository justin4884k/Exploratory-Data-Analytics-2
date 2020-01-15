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
#Baltimore Emission
balt_emission <- summarise(group_by(filter(NEI,fips=="24510"),year),Emissions=sum(Emissions))
clr <- c("red","green","blue","yellow")
x2 <- barplot(height = balt_emission$Emissions/1000, names.arg = balt_emission$year,xlab = "years",ylab = expression('total PM'[2.5]*' emission in kilotons'),
              ylim=c(0,4),main=expression('Total PM'[2.5]* ' emissions in Baltimore,MD in kilotons'),col=clr)
text(x=x2, y= round(balt_emission$Emissions/1000,2),label = round(balt_emission$Emissions/1000,2),pos = 3,cex = 0.8,col = "black")
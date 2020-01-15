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
#Data for Coal Use
com_coal <- grepl("Fuel Com.*Coal",SCC$EI.Sector)
com_coal_source <- SCC[com_coal,]
emission_coal <- NEI[(NEI$SCC %in%com_coal_source$SCC),]
emission_coal_rel <- summarise(group_by(emission_coal,year),Emissions=sum(Emissions))
ggplot(emission_coal_rel,aes(x=factor(year),y=Emissions/1000, fill=year,label=round(Emissions/1000,2)))+geom_bar(stat = "identity")+
  xlab("year")+
  ylab(expression("total PM"[2.5]*" emission in tons"))+
  ggtitle(expression("PM"[2.5]*paste(" emissions from coal combustion related sources in kilotons", sep="")))+
  geom_label(aes(fill = year), colour = "white", fontface = "bold")
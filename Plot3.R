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
#Data for Baltimore
balt_emission_year <- summarise(group_by(filter(NEI,fips=="24510"),year,type),Emissions=sum(Emissions))
ggplot(balt_emission_year,aes(x=factor(year),y=Emissions, fill=type,label=round(Emissions,2)))+
  geom_bar(stat = "identity")+
  facet_grid(. ~ type)+
  xlab("year")+
  ylab(expression("total PM"[2.5]*" emission in tons"))+
  ggtitle(expression("PM"[2.5]*paste(" emissions in Baltimore ","City by various source types", sep=" ")))
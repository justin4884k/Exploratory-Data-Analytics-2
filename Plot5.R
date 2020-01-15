library(dplyr)
library(ggplot2)
file.dwnload <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
fle <- "project.zip"
download.file(file.dwnload,fle,method = "auto")
unzip(fle)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

balt_emission_2 <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]
balt_emission_year_2 <- summarise(group_by(balt_emission_2,year),Emissions=sum(Emissions))
ggplot(balt_emission_year_2,aes(x=factor(year), y=Emissions,fill=year, label = round(Emissions,2))) +
  geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression("total PM"[2.5]*" emissions in tons")) +
  ggtitle("Emissions from motor vehicle sources in Baltimore City")+
  geom_label(aes(fill = year),colour = "white", fontface = "bold")
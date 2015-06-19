#Load Data Sets and Packages
neiData <- readRDS("./data/summarySCC_PM25.rds")
sccData <- readRDS("./data/Source_Classification_Code.rds")
library(dplyr)
library(ggplot2)

#Filter by Bal zip and Agrregate by Year and Type
type_nei_yr <- filter(neiData, fips == "24510")
type_nei_yr <- group_by(type_nei_yr, type)
type_nei_yr <- aggregate(Emissions ~ year + type, type_nei_yr, sum)

#Plot Data 
png("Plot3.png")
g <- ggplot(type_nei_yr, aes(year, Emissions, color = type))
g <- g + geom_line() +
  xlab("year") +
  ylab(expression("Total PM2.5 Emissions")) +
  ggtitle('Total Emissions in Baltimore City, Maryland by Year')
print(g)
dev.off()
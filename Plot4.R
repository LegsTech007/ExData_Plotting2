#Load Data Sets and Packages
neiData <- readRDS("./data/summarySCC_PM25.rds")
sccData <- readRDS("./data/Source_Classification_Code.rds")
library(dplyr)

#Merge Data with Labels and Search Txt for Coal
usa_coal <- merge(neiData, sccData, by="SCC")
usa_coal <- usa_coal[grep("Coal", usa_coal$Short.Name),]
usa_coal <- group_by(usa_coal, year)
usa_coal <- summarize(usa_coal, sum(Emissions)/1000)

#Generate the graph in the same directory as the source code
png("Plot4.png")
plot(usa_coal, main="Coal Related PM2.5 Emissions in USA by YR", ylab="Total Emissions (in 1000s")
lines(usa_coal)
dev.off()
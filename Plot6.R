#Load Data Sets and Packages
neiData <- readRDS("./data/summarySCC_PM25.rds")
sccData <- readRDS("./data/Source_Classification_Code.rds")
library(dplyr)

#Filter Data by Bal and LA zip, merge with data key, search for Motor Vehicle and sum EM2.5
bal_la_MV <- filter(neiData, (fips == "24510" | fips == "06037"))
bal_la_MV <- merge(bal_la_MV, sccData, by="SCC")
bal_la_MV <- bal_la_MV[grep("Vehicle", bal_la_MV$EI.Sector),]
bal_la_MV <- group_by(bal_la_MV, fips)
bal_la_MV <- aggregate(Emissions ~ year + fips, bal_la_MV, sum)

#Create Plot in same dir as source code
png("Plot6.png")
g <- ggplot(bal_la_MV, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity")  +
  xlab("year") +
  ylab(expression("Total PM2.5 Emissions")) +
  ggtitle("Total Emissions from Motor Vehicle in Baltimore City, MD vs Los Angeles, CA")
print(g)
dev.off()
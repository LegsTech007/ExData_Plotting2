#Load Data Sets and Packages
neiData <- readRDS("./data/summarySCC_PM25.rds")
sccData <- readRDS("./data/Source_Classification_Code.rds")
library(dplyr)

#Filter Data for Bal, Merge with Data Key and then search and filter by Motor Vehicle
bal_MV <- filter(neiData, fips == "24510")
bal_MV <- merge(bal_MV, sccData, by="SCC")
bal_MV <- bal_MV[grep("Vehicle", bal_MV$EI.Sector),]
bal_MV <- group_by(bal_MV, year)
bal_MV <- summarize(bal_MV, sum(Emissions))

#Generate the graph in the same directory as the source code
png("Plot5.png")
plot(bal_MV, main="Motor Vehicle Related PM2.5 Emissions in Bal City, MD by YR", ylab="Total Emissions")
lines(bal_MV)
dev.off()
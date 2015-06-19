#Load Data Sets and Packages
neiData <- readRDS("./data/summarySCC_PM25.rds")
sccData <- readRDS("./data/Source_Classification_Code.rds")
library(dplyr)

#Group and Sum Emissions by Year 
nei_yr <- group_by(neiData, year)
total_em <- summarize(nei_yr, sum(Emissions)/1000)

#Generate the graph in the same directory as the source code
png("Plot1.png")
plot(total_em, main="Total emissions from PM2.5 in the US", ylab="Total Emissions (1000s)")
lines(total_em)
dev.off()
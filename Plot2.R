#Load Data Sets and Packages
neiData <- readRDS("./data/summarySCC_PM25.rds")
sccData <- readRDS("./data/Source_Classification_Code.rds")
library(dplyr)

#Filter and Sum Emissions data by Zip Code = BAL
bal_em_yr <- filter(neiData, fips == "24510")
bal_em_yr <- group_by(bal_em_yr, year)
bal_em_yr <- summarize(bal_em_yr, sum(Emissions))

#Generate the graph in the same directory as the source code
png("Plot2.png")
plot(bal_em_yr, main="Total PM2.5 emissions in Baltimore City, Maryland", ylab="Total Emissions")
lines(bal_em_yr)
dev.off()
setwd("~/Dropbox/Development/Github/ExData_Plotting2")

# data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. 
# For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for the entire year.
#       fips: A five-digit number (represented as a string) indicating the U.S. county
#       SCC: The name of the source as indicated by a digit string (see source code classification table)
#       Pollutant: A string indicating the pollutant
#       Emissions: Amount of PM2.5 emitted, in tons
#       type: The type of source (point, non-point, on-road, or non-road)
#       year: The year of emissions recorded

if(!exists("NEI")) {
    NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")    
}
if(!exists("SCC")) {
    SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")    
}

# 5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
# Get source codes relating to motor vehicles
baltimore_motor <- subset(baltimore, type=="ON-ROAD")
baltimore_motor_yr <- aggregate(Emissions~year, baltimore_motor, sum)

# plot5
png("plot5.png", width = 480, height = 480)
with(baltimore_motor_yr, barplot(Emissions, year, col="wheat", main="PM2.5 Emissions from motor vehicle sources in Baltimore", 
                                 xlab="Year", ylab="Emissions (tons)", names.arg=c("1999", "2002", "2005", "2008")))
dev.off()
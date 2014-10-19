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

# 6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?
LA_motor <- subset(NEI, fips == "06037" & type=="ON-ROAD")
LA_motor_yr <- aggregate(Emissions~year, LA_motor, sum)

baltimore_motor_yr$County <- "Baltimore City, MD"
LA_motor_yr$County <- "Los Angeles County, CA"
baltimore_LA <- rbind(baltimore_motor_yr, LA_motor_yr)

# plot6
library(ggplot2)
png("plot6.png")
print(ggplot(baltimore_LA, aes(x=factor(year), y=Emissions, fill=County)) +
          geom_bar(stat="identity") + 
          facet_grid(County  ~ ., scales="free") +
          ylab("Total emissions (tons)") + 
          xlab("Year") +
          ggtitle(expression("Motor vehicle emission \nin Baltimore and Los Angeles")))
dev.off()

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

# 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.
library(ggplot2)
baltimore_yr_type <- aggregate(Emissions~year+type, baltimore, sum)

# plot3
png("plot3.png", width = 480, height = 480)
print(ggplot(data=baltimore_yr_type, aes(x=factor(year), y=Emissions, fill=type)) + xlab("Year") + ylab("Total Emissions (tons)") +
          geom_bar(stat="identity", position=position_dodge()) + 
          ggtitle("PM2.5 Emissions in Baltimore City by Source") + theme(plot.title = element_text(lineheight=.8, face="bold")))
dev.off()
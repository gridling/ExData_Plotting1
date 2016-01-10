library(dplyr)
## read in dataset
path = "./exdata_data_household_power_consumption/household_power_consumption.txt"
power <- read.csv2(path , sep =";", header = TRUE, stringsAsFactors = FALSE)

## subsetting dataset
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")
date1 <- subset(power, subset = Date == "2007-02-01")
date2 <- subset(power, subset = Date == "2007-02-02")
power.s <- rbind(date1, date2)  ## "power.s" is the subsetted dataset

## create a date/time class variable
power.t <- tbl_df(power.s)
power.t <- mutate(power.t, Date_Time = paste(power.t$Date, power.t$Time))
power.t <- select(power.t, Date_Time, Global_active_power:Sub_metering_3)
power.t$Date_Time <- as.POSIXlt(power.t$Date_Time, format = "%Y-%m-%d %H:%M:%S")

## plotting the "date-GAP" smooth scatterplot
power.t$Global_active_power <- as.numeric(power.t$Global_active_power)
png(filename = "plot2.png", width = 480, height = 480, units = "px")
with(power.t, plot(Date_Time, Global_active_power, 
                   type = "l",
                   xlab = "",
                   ylab = "Global Active Power (kilowatts)"))
dev.off()


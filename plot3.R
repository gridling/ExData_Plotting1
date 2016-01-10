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

## plotting the three overlaying scatterplots
Sys.setlocale("LC_ALL","English")
power.t$Sub_metering_1 <- as.numeric(power.t$Sub_metering_1)
power.t$Sub_metering_2 <- as.numeric(power.t$Sub_metering_2)
power.t$Sub_metering_3 <- as.numeric(power.t$Sub_metering_3)

png(filename = "plot3.png", width = 480, height = 480, units = "px")

with(power.t, {
    plot(Date_Time, Sub_metering_1, type = "l", col = "black",
         xlab = "", ylab = "Energy sub metering");
    points(Date_Time, Sub_metering_2, type = "l", col = "red");
    points(Date_Time, Sub_metering_3, type = "l", col = "blue")
})

legend(x = "topright", y = NULL, 
       cex = 0.5, lty = 1, lwd = 2, seg.len = 5, xjust = 0, 
       text.font =2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"))

dev.off()


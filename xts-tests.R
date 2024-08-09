# xts tests

dt <- data.table::fread(latestDataFile)
dt[, date_nz := lubridate::ymd_hm(date)]

library(xts)
xts_dt <- xts::as.xts(dt[, .(date_nz, code, strikes)])
xts_dt['2024-06/']
plot(xts_dt[,1],major.ticks='months',minor.ticks=FALSE,main=NULL,col=3)
periodicity(xts_dt)
to.monthly(xts_dt)
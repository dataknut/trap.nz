# makefile to run report

# refresh data from https://trap.nz/view/manage-trap-records/export.csv/169960?field_trap_trap_line_target_id_entityreference_filter%5B0%5D=190278&field_trap_record_date_value%5Bmin%5D%5Bdate%5D=&field_trap_record_date_value%5Bmax%5D%5Bdate%5D=&field_trap_record_bait_type_tid_entityreference_filter_op=in&field_trap_record_recorded_by_value=&field_tags_tid%5Btextfield%5D=&field_tags_tid%5Bvalue_field%5D=&title=&items_per_page=25

library(here)

outputFolder <- here::here("docs")

rmdFolder <- here::here("rmd")

latestDataFile <- path.expand("~/Dropbox/Home/trapping/2024-07-14-telford.csv") # not open data

line <- "Telford"
desc <- "which covers the northern part of Wellington's Southern Walkway between 
Roseneath Park & Lookout and Mount Victoria Lookout"

# could be coded to loop over each line if downloaded data file has a consistent name
# output folder needs to exist

if(!dir.exists(paste0(outputFolder,"/", line))){
  dir.create(paste0(outputFolder,"/", line))
} else {
  message(paste0(outputFolder,"/", line), " exists")
}

rmarkdown::render(here::here(rmdFolder, "trapLineReport.Rmd"),
                  params = list(dataFile = latestDataFile,
                                line = line,
                                desc = desc),
                  output_dir = paste0(outputFolder,"/", line),
                  output_format = "all" # should render all in .Rmd
)

# xts tests

dt <- data.table::fread(latestDataFile)
dt[, date_nz := lubridate::ymd_hm(date)]

library(xts)
xts_dt <- xts::as.xts(dt[, .(date_nz, code, strikes)])
xts_dt['2024-06/']
plot(xts_dt[,1],major.ticks='months',minor.ticks=FALSE,main=NULL,col=3)
periodicity(xts_dt)
to.monthly(xts_dt)




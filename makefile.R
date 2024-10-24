# makefile to run report

# refresh data from 
# https://trap.nz/view/manage-trap-records?field_trap_trap_line_target_id_entityreference_filter%5B%5D=190278&field_trap_record_date_value%5Bmin%5D%5Bdate%5D=&field_trap_record_date_value%5Bmax%5D%5Bdate%5D=&field_trap_record_bait_type_tid_entityreference_filter_op=in&field_trap_record_recorded_by_value=&field_tags_tid%5Btextfield%5D=&field_tags_tid%5Bvalue_field%5D=&title=&items_per_page=25

library(here)

snapshot <- "2024-10-24"

outputFolder <- here::here("docs")

rmdFolder <- here::here("rmd")

latestDataFile <- path.expand(sprintf("~/Dropbox/Home/trapping/%s-telford.csv", 
                                      snapshot)) # not open data

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




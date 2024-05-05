 # makefile to run report

library(here)

outputFolder <- here::here("docs")

rmdFolder <- here::here("rmd")

latestDataFile <- path.expand("~/Dropbox/NZ_2024/trapping/2024-06-06-telford.csv") # not open data

line <- "Telford"
desc <- "which covers the northern part of Wellington's Southern Walkway between 
Roseneath Park & Lookout and Mount Victoria Lookout."

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
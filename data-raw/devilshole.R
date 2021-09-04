# devilshole ——————————————————————————————————————————————————

devilshole=read.csv("data-raw/devilshole.csv",
                    header = TRUE, sep = ";", dec = ",")

usethis::use_data(devilshole, overwrite = TRUE)

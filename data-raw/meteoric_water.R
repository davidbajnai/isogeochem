# meteoric_water ——————————————————————————————————————————————————

meteoric_water=read.csv("data-raw/meteoric_water.csv",
                    header = TRUE, sep = ";", dec = ",")

usethis::use_data(meteoric_water, overwrite = TRUE)

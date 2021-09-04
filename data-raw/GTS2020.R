# GTS2020 ——————————————————————————————————————————————————

GTS2020=read.csv("data-raw/GTS2020.csv",
                    header = TRUE, sep = ";", dec = ",")

usethis::use_data(GTS2020, overwrite = TRUE)

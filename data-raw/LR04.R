# LR04 ——————————————————————————————————————————————————

LR04=read.csv("data-raw/LR04.csv",
                    header = TRUE, sep = ";", dec = ",")

usethis::use_data(LR04, overwrite = TRUE)

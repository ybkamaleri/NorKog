library(data.table)
DT <- data.table(v1 = rep(letters[1:4], 5), v2 = rnorm(20), v3 = sample(20:30, 20, replace = T))

## mean each
DT[, list(mean = mean(as.numeric(v3), na.rm = TRUE)), by = list(v1)]
DT[, lapply(.SD, function(x) mean(v3, na.rm = TRUE)), .SDcol = "v3"]

eato <- function(data, by, stat = c("sum", "mean")) {


}

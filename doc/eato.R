library(data.table)
DT <- data.table(v1 = rep(letters[1:4], 5),
                 v2 = rnorm(20),
                 v3 = sample(20:30, 20, replace = T),
                 v5 = rep(c("samp1", "samp2"), 10))

## mean each
vv <- "v3"
ss <- "v5"
s1 <- quote(v5)

DT[, (vv) := (as.numeric(get(vv)))]
DT[, list(mean = mean(v3, na.rm = TRUE))]
DT[, list(mean = mean(as.numeric(v3), na.rm = TRUE)), by = list(v1)]
DT[, lapply(.SD, function(x) mean(v3, na.rm = TRUE)), .SDcol = "v3"]

DT[v5 == "samp1", .N, by = .(v3)]
DT[get(ss) == "samp1", .N, by = list(get(vv))]
DT[eval(s1) == "samp1", .N, by = list(v3)]


## Testing for speed
library(microbenchmark)
microbenchmark(
  DT[v5 == "samp1", .N, by = .(v3)],
  DT[get(ss) == "samp1", .N, by = list(get(vv))],
  DT[eval(s1) == "samp1", .N, by = list(v3)],
  times = 2000
)


## Delete rows NA
DT2 <- copy(DT)
DT2[2, "v3"] <- NA
test <- DT2[!is.na(v3), ]
test

eato <- function(data, select = NULL, from, by, stat = c("sum", "mean")) {

  stat <- match.arg(stat)

  switch(stat,
         mean = {
           data[, (from) := as.numeric(get(from))]
           total <- data[, list(mean = mean(get(from), na.rm = TRUE))]

           each <- data[, list(mean = mean(get(from), na.rm = TRUE)), by = list(get(by))]

           select <- data[]

         })

}

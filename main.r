writeToFile <- function(fileName, text) {
  con <- file(fileName, open = "a")
  writeLines(text, con)
  close(con)
}

a <- 2^24
b <- 2^25
cat(sprintf("a = %d\n", a))
cat(sprintf("b = %d\n", b))

startTime <- Sys.time()
n <- 0
for (c in a:b) {
  writeToFile("./float/java.txt", sprintf("c = %08d => %8.1f\n", c, as.numeric(c)))
  flush.console()

  if (n == as.integer((c-a)*100/a)) {
    n <- n + 1
    cat(sprintf("%d/100\n", n))
  }
}
stopTime <- Sys.time()

cat(sprintf("%f\n", as.numeric(stopTime - startTime)))
flush.console()

library(parallel) #Importing the library 

#Defining the custom function timeconsumptionfun to pause for 5 seconds 
timeconsumingfun <- function() {
  Sys.sleep(5)  
}

#Defining the number of iterations 
n <- 110

#Calculating the time consumed for Serial execution
time_serial <- system.time({
  for (i in 1:n) {
    timeconsumingfun()
  }
})
cat("Serial Time:", time_serial["elapsed"], "\n")

#Checking the number of cores available and clustering
workers <- detectCores()
num_cores <- min(workers - 1, 4)
c <- makeCluster(num_cores)
clusterExport(c, "timeconsumingfun")

#Calculating the time consumed for Parallel execution
time_parallel <- system.time({
  parLapply(c, 1:n, function(x) timeconsumingfun())
})

stopCluster(c)

cat("Parallel Time:", time_parallel["elapsed"], "\n")

speedup <- as.numeric(time_serial["elapsed"]) / as.numeric(time_parallel["elapsed"])
efficiency <- (speedup / num_cores) * 100

cat("Speedup:", speedup, "\n")
cat("Efficiency:", efficiency,"%\n")
######################################################################################

# Copyright 2022, Nicolau Andrés-Thió

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

######################################################################################

source("R_code/libraries.R")
# This function eases the creation of the experimental specifications for 
# experiments with the same single source, high fi, and low fi budgets, and
# the same seeds per run.
createScriptStructure <- function(functions, singleSourceBudget, highFiBudget, lowFiBudget, seeds, seedsPerRun, doKrig, doCoKrig, printInfo = FALSE){
  jobs <- 0
  runData <- data.frame(matrix(ncol = 5, nrow = 0))
  if(doKrig){
    for(func in functions){
      for(seedStart in seq(1, seeds, seedsPerRun)){
        jobs <- jobs + 1
        if(printInfo){print(paste0("Working on job ", jobs, " for krig"))}
        data <- c(func, "kriging", singleSourceBudget, 0, paste0(seedStart, "-", min(seedStart + seedsPerRun - 1, seeds)))
        runData[jobs, ] <- data
      }
    }
  }
  if(doCoKrig){
    for(func in functions){
      for(seedStart in seq(1, seeds, seedsPerRun)){
        jobs <- jobs + 1
        if(printInfo){print(paste0("Working on job ", jobs, " for cokrig"))}
        data <- c(func, "cokriging", highFiBudget, lowFiBudget, paste0(seedStart, "-", min(seedStart + seedsPerRun - 1, seeds)))
        runData[jobs, ] <- data
      }
    }
  }
  colnames(runData) <- c("instance", "technique", "highFiBudget", "lowFiBudget", "seeds")
  if(printInfo){print(paste0("Created script with ", jobs, " jobs"))}
  return(runData)
}




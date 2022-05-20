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
source("R_code/dataProcessor.R")
source("R_code/plotFeatures.R")
source("R_code/experimentalRunScriptCreator.R")
options(warn = -1)

# This script processes and plots the features of the newly created 81000 instances,
# and chooses a diverse subset. A script is created to analyse Co-Kriging vs Kriging
# performance on this reduced subset.
print("CREATING NEW INSTANCES EXPERIMENTAL SCRIPT.")
# First get features of all instances, this will take a while so better to 
# do a few lines at a time then combine
newInstancesFeatures <- combineAndAverageFeatures("newInstancesFeatures", 1, 10, jobsPerArray = 100, printInfo = FALSE)
for(i in seq(2, 81)){
  cat(paste0("\rGetting features of instances ", i*1000, "/81000"))
  newInstancesFeatures <- rbind(newInstancesFeatures, combineAndAverageFeatures("newInstancesFeatures", (i-1)*10 + 1, i*10, jobsPerArray = 100, printInfo = FALSE))
}
cat(" - done.\n")
# Plot the features!
graphScale <- 0.7
newInstancesFeatures$pch = 4
newInstancesFeatures$legend = "Disturbance-based"
newInstancesFeatures$col = "sienna1"
cat("Plotting feature graphs ")
plotFeatures(newInstancesFeatures, "newInstancesFeatures", mult = graphScale, legend = FALSE)
cat("- done.\n")
# Next want to create subset of instances which fill the space when plotting 
# CC vs LCC_0.5. Do so by creating a grid and choosing a random instance 
# for each dimension in each grid position.
cat("Choosing instance subset ")
started <- FALSE
count <- 0
for(corrTop in seq(1, 0.05, -0.05)){
  if(corrTop == 1){tempData <- newInstancesFeatures[newInstancesFeatures$CC <= corrTop & newInstancesFeatures$CC >= corrTop - 0.05, ]}
  else{tempData <- newInstancesFeatures[newInstancesFeatures$CC < corrTop & newInstancesFeatures$CC >= corrTop - 0.05, ]}
  for(prob in seq(0, 0.95, 0.05)){
    if(prob == 0.95){tempData2 <- tempData[tempData$LCC_0.5 >= prob & tempData$LCC_0.5 <= prob + 0.05, ]}
    else{tempData2 <- tempData[tempData$LCC_0.5 >= prob & tempData$LCC_0.5 < prob + 0.05, ]}
    for(dim in c(1, 2, 5, 10)){
      tempData3 <- tempData2[str_which(tempData2$instance, paste0("-dim", dim, "-"), negate = FALSE), ]
      count <- count + 1
      # cat(paste0(count, " - Working on corr ", corrTop, " prob ", prob, " and dim ", dim))
      # if(nrow(tempData3) == 0){
      #   cat(" - skipped\n")
      #   next
      # }
      # cat("\n")
      # Grab a random one if there are multiple
      tempData3 <- tempData3[sample(1:nrow(tempData3), 1), ]
      if(!started){
        subsetData <- tempData3
        started <- TRUE
      }
      else{subsetData <- rbind(subsetData, tempData3)}
    }
  }
}
cat("- done.\n")

# Got the subset, now create the script
for(dim in c(1, 2, 5, 10)){
  if(dim == 1 | dim == 2){seedsPerRun <- 20}
  else if(dim == 5){seedsPerRun <- 10}
  else{seedsPerRun <- 4}
  instances <- subsetData[str_which(subsetData$instance, paste0("-dim", dim, "-"), negate = FALSE), "instance"]
  runData <- createScriptStructure(instances, 5*dim, 4*dim, dim*10, 20, seedsPerRun, TRUE, TRUE)
  if(dim != 1){
    existingRunData <- read.table("data/runScripts/newInstancesTesting.txt", header = TRUE, sep = " ", fill = TRUE)
    runData <- rbind(existingRunData, runData)
  }
  write.table(runData, "data/runScripts/newInstancesTesting.txt", quote = FALSE, row.names = FALSE)
  # print(paste0("Dim ", dim))
}

print("CREATED NEW INSTANCES EXPERIMENTAL SCRIPT.")


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
source("R_code/experimentalRunScriptCreator.R")
options(warn = -1)

# Script which creates the experimental run for the literature test suite.
# Seeds per run decreases for larger dimensions as it takes longer to run,
# this is done so that each experimental specification takes a similar amount of
# time to run.
print("CREATING LITERATURE SUITE EXPERIMENTAL SCRIPT.")
for(dim in 1:50){
  if(!file.exists(paste0("data/availableFunctions/biSourceDim", dim, ".txt"))){next}
  functions <- read.table(paste0("data/availableFunctions/biSourceDim", dim, ".txt"), header = FALSE, sep = " ", fill = TRUE)[[1]]
  if(dim <= 4){seedsPerRun <- 20}
  else if(dim <= 9){seedsPerRun <- 10}
  else if(dim <= 15){seedsPerRun <- 5}
  else{seedsPerRun <- 2}
  
  runData <- createScriptStructure(functions, 5*dim, 4*dim, dim*10, 20, seedsPerRun, TRUE, TRUE)
  if(dim != 1){
    existingRunData <- read.table("data/runScripts/litSuiteTesting.txt", header = TRUE, sep = " ", fill = TRUE)
    runData <- rbind(existingRunData, runData)
  }
  write.table(runData, "data/runScripts/litSuiteTesting.txt", quote = FALSE, row.names = FALSE)
}

print("CREATED LITERATURE SUITE EXPERIMENTAL SCRIPT.")


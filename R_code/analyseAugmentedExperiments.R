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
source("R_code/plotPerformance.R")
source("R_code/decisionTreeAnalysis.R")
options(warn = -1)

# This script takes the results stored in the files litSuiteTesting and in 
# newInstancesTesting and processes them. That is it takes the results of the 
# augmented suite experiments and plots the instance features and the performance of the
# models, as well as running the analysis of the decision trees. 
print("ANALYSING AUGMENTED SUITE EXPERIMENTS.")
graphScale <- 0.7
# Grab results from both runs
literatureTestSuiteResults <- combineAndProcessResults("litSuiteTesting", 1, 906)
newInstancesResults <- combineAndProcessResults("newInstancesTesting", 1, 995, 6)
# Add columns for information when plotting features
literatureTestSuiteResults$pch = 16
literatureTestSuiteResults$legend = "Fixed"
literatureTestSuiteResults$col = "black"
literatureTestSuiteResults[str_which(literatureTestSuiteResults$instance, "Wang", negate = FALSE), "pch"] = 17
literatureTestSuiteResults[str_which(literatureTestSuiteResults$instance, "Wang", negate = FALSE), "legend"] = "Error-based"
literatureTestSuiteResults[str_which(literatureTestSuiteResults$instance, "Wang", negate = FALSE), "col"] = "sienna3"
literatureTestSuiteResults[str_which(literatureTestSuiteResults$instance, "Toal", negate = FALSE), "pch"] = 15
literatureTestSuiteResults[str_which(literatureTestSuiteResults$instance, "Toal", negate = FALSE), "legend"] = "Parameter-based"
literatureTestSuiteResults[str_which(literatureTestSuiteResults$instance, "Toal", negate = FALSE), "col"] = "sienna4"
newInstancesResults$pch = 4
newInstancesResults$legend = "Disturbance-based"
newInstancesResults$col = "sienna1"

# Combine the results
combinedResults <- rbind(newInstancesResults, literatureTestSuiteResults)
# Plot feature graphs
cat("Plotting feature graphs ")
plotFeatures(combinedResults, "augmentedSuiteTestingFeatures", mult = graphScale)
cat("- done.\n")
# Add columns of information when plotting model performance
combinedResults[combinedResults$superiorModel == "Co-Kriging", "pch"] <- 17
combinedResults[combinedResults$superiorModel == "Co-Kriging", "col"] <- "green4"
combinedResults[combinedResults$superiorModel == "Co-Kriging", "legend"] <- "Co-Kriging"
combinedResults[combinedResults$superiorModel == "Tied", "pch"] <- 16
combinedResults[combinedResults$superiorModel == "Tied", "col"] <- "darkgoldenrod1"
combinedResults[combinedResults$superiorModel == "Tied", "legend"] <- "Tied"
combinedResults[combinedResults$superiorModel == "Kriging", "pch"] <- 15
combinedResults[combinedResults$superiorModel == "Kriging", "col"] <- "red"
combinedResults[combinedResults$superiorModel == "Kriging", "legend"] <- "Kriging"
# Plot performance graphs
cat("Plotting performance graphs ")
plotPerformance(combinedResults, "augmentedSuiteTestingFeatures", mult = graphScale)
cat("- done.\n")
# Perform analysis of decision tree accuracies
cat("Perform decision tree analysis:\n")
runDecisionTreeAnalysis(literatureTestSuiteResults, "literatureTestSuite")
runDecisionTreeAnalysis(combinedResults, "augmentedTestSuite")

